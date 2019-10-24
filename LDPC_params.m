function [coding] = LDPC_params(wifi_params, m_stbc, mcs_ind)
% Function for computing auxiliary LDPC coding parameters
%
% Author:	Jiri Milos, DREL FEEC BUT, 2018
%

coding.type = 'LDPC';

LENGTH = wifi_params.general.LENGTH;
service_length = wifi_params.mapping.service_length;

MCS = wifi_params.MCS(mcs_ind);
switch wifi_params.general.standard
    case {'802dot11n', '802dot11ac'}
        %% vypocet parametru dle standardu IEEE 802.11-2012
        %% a]
        % disp('Number of the bits in the PSDU and SEMCS.CRVICE field:')
        N_pld = LENGTH*8 + 16; % number of the bits in the PSDU and SEMCS.CRVICE field
        % disp('Number of available bits in the minimum number of OFDM symbols in which the Data field of the packet may fit:')
        N_avbits = MCS.N_cbps*m_stbc*ceil(N_pld/(MCS.N_cbps*MCS.CR*m_stbc));
        
        coding.N_pld = N_pld;
        
        
        %% b] integer number of LDPC codewords to be transmitted N_cw and the length of codewords to be used L_ldpc
        if N_avbits <= 648
            N_cw = 1;
            if N_avbits >= N_pld+(912*(1-MCS.CR))
                L_ldpc = 1296;
            else
                L_ldpc = 648;
            end
        elseif (N_avbits > 648) && (N_avbits <= 1296)
            N_cw = 1;
            if N_avbits >= N_pld+(1464*(1-MCS.CR))
                L_ldpc = 1944;
            else
                L_ldpc = 1296;
            end
        elseif (N_avbits > 1296) && (N_avbits <= 1944)
            N_cw = 1;
            L_ldpc = 1944;
        elseif (N_avbits > 1944) && (N_avbits <= 2592)
            N_cw = 2;
            if N_avbits >= N_pld+(2916*(1-MCS.CR))
                L_ldpc = 1944;
            else
                L_ldpc = 1296;
            end
        elseif (N_avbits > 2592)
            N_cw = ceil(N_pld/(1944*MCS.CR));
            L_ldpc = 1944;
        end
        
        coding.N_cw = N_cw;
        coding.L_ldpc = L_ldpc;
        %% c] Compute the number of shortening bits N_shrt to be padded to the Npld data bits before encoding
        % disp('Number of shortening bits N_shrt, to be padded to the Npld data bits before encoding:')
        N_shrt = max([0, (N_cw*L_ldpc*MCS.CR)-N_pld]);
        if N_shrt < 0
            error('The N_shrt parameter must be non-negative');
        end
        coding.shortening.N_shrt = N_shrt;
        % disp('---------------------------------------------');
        N_spcw = floor(N_shrt/N_cw); % number of shortening bits per codeword
        coding.shortening.N_spcw = N_spcw;
        % disp('---------------------------------------------');
        N_input_bits = N_pld+N_shrt;
        k = N_input_bits;
        
        coding.N_input_bits = N_input_bits;
        
        N_bpcw = N_input_bits/N_cw; % Number of bits per signal codeword
        coding.N_bpcw = N_bpcw;
        
        nFirstShortenedPlusOne = rem(N_shrt,N_cw); % number of codewords shortened 1 bit more than the remaining codewords, see page 1812, section c
        n_shrt_cw = zeros(1,N_cw);
        if nFirstShortenedPlusOne ~= 0
            for i_cw = 1:N_cw
                if nFirstShortenedPlusOne >= i_cw
                    n_shrt_cw(i_cw) = N_spcw+1;
                else
                    n_shrt_cw(i_cw) = N_spcw; %%%%%%%%%
                end
            end
        else
            n_shrt_cw = N_spcw*ones(1,N_cw);
        end
        
        n_bitwoshrt_cw = (ones(1,N_cw)*N_bpcw)-n_shrt_cw;
        if sum(n_shrt_cw) ~= N_shrt
            disp(['sum(',mat2str(n_shrt_cw),') ~= ',num2str(N_shrt)])
            error('Wrong number of shortened bits')
        end
        
        %     shrt_ind = true(N_cw,N_bpcw);
        shrt_ind = false(N_cw,L_ldpc);
        bitwoshrt_ind = shrt_ind;
        for i_cw = 1:N_cw
            shrt_ind(i_cw,n_bitwoshrt_cw(i_cw)+1:N_bpcw) = true;
            bitwoshrt_ind(i_cw,1:n_bitwoshrt_cw(i_cw)) = true;
        end
        
        % save to shortening substructure
        coding.shortening.nFirstShortenedPlusOne = nFirstShortenedPlusOne;
        coding.shortening.N_spcw = N_spcw;
        coding.shortening.n_shrt_cw = n_shrt_cw;
        coding.shortening.n_bitwoshrt_cw = n_bitwoshrt_cw;
        coding.shortening.bitwoshrt_ind = bitwoshrt_ind;
        coding.shortening.shrt_ind = shrt_ind;
        
        %% d] Number of bits to be punctured N_punc, from the codewords after encoding
        N_punc = max([0, (N_cw*L_ldpc)-N_avbits-N_shrt]);
        if ((N_punc > (0.1*N_cw*L_ldpc*(1-MCS.CR))) && (N_shrt < (1.2*N_punc*(MCS.CR/(1-MCS.CR))))) || (N_punc > (0.3*N_cw*L_ldpc*(1-MCS.CR)))
            N_avbits = N_avbits + (MCS.N_cbps*m_stbc);
            N_punc = max([0, (N_cw*L_ldpc)-N_avbits-N_shrt]);
        end
        
        N_ppcw = floor(N_punc/N_cw);
        
        nFirstPuncturedPlusOne = rem(N_punc,N_cw); % number of cdwds punctured 1 bit more than the remaining codewords, see page 1812, section c
        n_punc_cw = zeros(1,N_cw);
        if nFirstPuncturedPlusOne ~= 0
            for i_cw = 1:N_cw
                if nFirstPuncturedPlusOne >= i_cw
                    n_punc_cw(i_cw) = N_ppcw+1;
                else
                    n_punc_cw(i_cw) = N_ppcw; %%%%%%%%%%%%
                end
            end
        else
            n_punc_cw = N_ppcw*ones(1,N_cw);
        end
        
        if sum(n_punc_cw) ~= N_punc
            disp(['sum(',mat2str(n_punc_cw),') ~= ',num2str(N_punc)])
            error('Wrong number of punctured bits')
        end
        
        punc_ind = false(N_cw,L_ldpc);
        parity_ind = punc_ind;
        
        for i_cw = 1:N_cw
            parity_ind(i_cw,N_bpcw+1:L_ldpc-n_punc_cw(i_cw)) = true;
            punc_ind(i_cw,L_ldpc-n_punc_cw(i_cw)+1:L_ldpc) = true;
        end
        
        % N_avbits parameter is computed again
        coding.N_avbits = N_avbits;
        % save to puncturing substructure
        coding.puncturing.N_punc = N_punc;
        coding.puncturing.N_ppcw = N_ppcw;
        coding.puncturing.nFirstPuncturedPlusOne = nFirstPuncturedPlusOne;
        coding.puncturing.n_punc_cw = n_punc_cw;
        coding.puncturing.punc_ind = punc_ind;
        coding.puncturing.parity_ind = parity_ind;
        % Number of symbols
        coding.N_sym = N_avbits/MCS.N_cbps;
        
        %% e] Number of the coded bits to be repeated N_rep
        N_rep = max([0, round(N_avbits-(N_cw*L_ldpc*(1-MCS.CR)))-N_pld]);
        nFirstRepeatedPlusOne = rem(N_rep,N_cw);
        
        N_repcw = floor(N_rep/N_cw);
        n_rep_cw = zeros(1,N_cw);
        if nFirstRepeatedPlusOne ~= 0
            for i_cw = 1:N_cw
                if nFirstRepeatedPlusOne >= i_cw
                    n_rep_cw(i_cw) = N_repcw+1;
                else
                    n_rep_cw(i_cw) = N_repcw;
                end
            end
        else
            n_rep_cw = N_repcw*ones(1,N_cw);
        end
        
        if sum(n_rep_cw) ~= N_rep
            error('Wrong number of bits to be repeated per codeword');
        end
        
        % save to repeating substructure
        coding.repeating.N_rep = N_rep;
        coding.repeating.nFirstRepeatedPlusOne = nFirstRepeatedPlusOne;
        coding.repeating.N_repcw = N_repcw;
        coding.repeating.n_rep_cw = n_rep_cw;

    case {'802dot11ad'}
        % encoding using systematic LDPC encoder
        
        % LDPC code rates
        switch MCS.CR
            case 1/2
                L_ldpc = 672;
                num_data_bits = 336;
                punc_parity_bits = 0;
            case 5/8
                L_ldpc = 672;
                num_data_bits = 420;
                punc_parity_bits = 0;
            case 3/4
                L_ldpc = 672;
                num_data_bits = 504;
                punc_parity_bits = 0;
            case 13/16
                L_ldpc = 672;
                num_data_bits = 546;
                punc_parity_bits = 0;
            case 7/8
                L_ldpc = 624;
                num_data_bits = 546;
                if MCS.Repetition == 1
                    punc_parity_bits = 48;
                else
                    punc_parity_bits = 0;
                end
        end
        
        N_cw = ceil((LENGTH*8)/((L_ldpc/MCS.Repetition)*MCS.CR));
        
        N_data_pad = (N_cw*(L_ldpc/MCS.Repetition)*MCS.CR)-(LENGTH*8);
        
        N_blks = ceil((N_cw*L_ldpc)/MCS.N_cbpb);
        N_blk_pad = (N_blks*MCS.N_cbpb)-(N_cw*L_ldpc);
        
        coding.N_cw = N_cw;
        coding.L_ldpc = L_ldpc;
        coding.N_Data_pad = N_data_pad;
        coding.num_data_bits = num_data_bits;
        coding.punc_parity_bits = punc_parity_bits;
        coding.N_blks = N_blks;
        coding.N_blk_pad = N_blk_pad;
    otherwise
        error('Undefined standard for using with LDPC encoder (see LDPC_params.m)');
end

% save other useful parameters
coding.CR = MCS.CR;


%% LDPC coder structure
% prepare channel encoder and decoder
[coding.UsedLDPC_matrix, coding.Z] = LDPC_matrix(MCS.CR,L_ldpc);

end

