function rxObj = WIFI_RX_ad(wifi_params,rxObj,channelObj, ChanMod_output, mcs_num, SNR_dB, txObj, var_n, var_s)
% WIFI transmitter function according to IEEE 802.11ad standard
% Author:   Jiri Milos, DREL FEEC BUT, 2019

%% DEFINE MODEL PARAMETERS
% Used MCS
MCS = wifi_params.MCS(mcs_num);
% Number of PSDU data octets
LENGTH = wifi_params.general.LENGTH;
% Channel coding
% number of codewords
N_cw = wifi_params.coding.N_cw;
% single codeword length
L_ldpc = wifi_params.coding.L_ldpc;
% number of symbol blocks
N_blks = ceil((N_cw*L_ldpc)/MCS.N_cbpb);
% number of symbol padding bits
N_blk_pad = (N_blks*MCS.N_cbpb)-(N_cw*L_ldpc);
% LDPC decoder definition

hDec = comm.LDPCDecoder(wifi_params.coding.UsedLDPC_matrix,'IterationTerminationCondition','Parity check satisfied');
% hDec = comm.gpu.LDPCDecoder(wifi_params.coding.UsedLDPC_matrix,'IterationTerminationCondition','Parity check satisfied');

% Modulation mapping
modNorm = wifi_params.modulation(log2(MCS.M)).hMod_factor;
hDemod = wifi_params.modulation(log2(MCS.M)).hDemod;
hDemod_LLR = wifi_params.modulation(log2(MCS.M)).hDemod_LLR;

SymbolAlphabet = (constellation(hDemod).')*wifi_params.modulation(log2(MCS.M)).hMod_factor;
hScalQuant = wifi_params.modulation.hScalQuant;

% Spreading
n_fft = wifi_params.mapping.n_fft; % chips
n_tot = wifi_params.mapping.n_tot; % chips
n_gi = n_fft-n_tot; % chips

%% RECEIVED VECTOR
y_rx = ChanMod_output;

%% FRAME PARSER
% extract preambles and other fields from frame
% no synchronization is performed, yet
% load exact number of chips for each frame field (excepting Data and TRN -> here set to -1)

% Control

% SC

% LPSC

% OFDM

% NOTE:
warning('Only SC mode is considered yet (see WIFI_RX_ad.m, line 45)');

% parsing
y_rx_stf = y_rx(wifi_params.framing.ChipMap{1});
y_rx_cef = y_rx(wifi_params.framing.ChipMap{2});
y_rx_header = y_rx(wifi_params.framing.ChipMap{3});
y_rx_data = y_rx(wifi_params.framing.ChipMap{4});
y_rx_btf = y_rx(wifi_params.framing.ChipMap{5});


% -------------------------- only for debug and testing --
y_tx = txObj.output.x_s;
y_tx_stf = y_tx(wifi_params.framing.ChipMap{1});
y_tx_cef = y_tx(wifi_params.framing.ChipMap{2});
y_tx_header = y_tx(wifi_params.framing.ChipMap{3});
y_tx_data = y_tx(wifi_params.framing.ChipMap{4});
y_tx_btf = y_tx(wifi_params.framing.ChipMap{5});

%% SYNCHRONIZATION
% using STF
% TBD

%% CHANNEL ESTIMATION
% using CEF
est_h = ad_cir_estimator(y_rx_cef, wifi_params);

%% GUARD REMOVAL AND SYMBOL DE-BLOCKING
% guard removal
rx_Ga64_rotated = zeros(N_blks+1, n_gi); % preallocation (N_blks +1 of Ga64 sequences within data frame)
% remove Ga64 at the end of rx data blocks stream
y_rx_data_length = length(y_rx_data);
rx_Ga64_rotated(N_blks+1, :) = y_rx_data(1, y_rx_data_length-n_gi+1:y_rx_data_length);
y_rx_data(y_rx_data_length-n_gi+1:y_rx_data_length) = [];

if mod(length(y_rx_data),n_fft) ~= 0
    error('Wrong length of block of received symbols');
end

rx_modulatedDataSymbolsAndGuard = reshape(y_rx_data, n_fft, []).';
% rest of guard removal
rx_guard = rx_modulatedDataSymbolsAndGuard(:,1:n_gi);
rx_Ga64_rotated(1:N_blks, :) = rx_guard;
k_Ga64 = 0:n_gi-1;
rx_Ga64 = rx_Ga64_rotated.*repmat(exp(-1j*pi*k_Ga64/2), N_blks+1, 1);

rx_modulatedDataSymbol_blocks = rx_modulatedDataSymbolsAndGuard(:,n_gi+1:n_fft);
% derotate data symbols first
modulated_symbol_index_k = (0:numel(rx_modulatedDataSymbol_blocks(1,:))-1);
modulated_symbol_derotating_factor = exp(-1j*pi*modulated_symbol_index_k/2);
if wifi_params.general.dataSymbolRotation == 0
    rx_modulatedDataSymbol_blocks_derotated = rx_modulatedDataSymbol_blocks;
else
    rx_modulatedDataSymbol_blocks_derotated = rx_modulatedDataSymbol_blocks.*repmat(modulated_symbol_derotating_factor, N_blks, 1);
end

%% CHANNEL EQUALIZATION
    
    % with LS ZF equalizer
    if strcmp(wifi_params.general.channel,'awgn') == 1
        est_h_padded = [channelObj.h, zeros(1, 448-length(channelObj.h))];
        H_est = channelObj.H(1:end-n_gi);
    else
        est_h_padded = [[est_h(1:120),zeros(1,length(est_h)-120)], zeros(1,n_fft-n_gi-length(est_h))];
        H_est = fft(est_h_padded);
    end
    
    H_est_perf = channelObj.H;
    
    FDE_data_output = zeros(size(rx_modulatedDataSymbol_blocks));
    rx_layer_x = zeros(N_blks, length(FDE_data_output(1,:)));
    
    demodulatorOutSSD = zeros(N_blks, log2(MCS.M)*length(FDE_data_output(1,:)));
    for i_eq = 1:N_blks
        % prealloc
        demodulatorOutSSD_blk = zeros(1, log2(MCS.M)*length(FDE_data_output(1,:)));
        %
                
        FDE_data_input = (rx_modulatedDataSymbol_blocks_derotated(i_eq,:));

        for jj = 1:length(FDE_data_input)

            rx_user_sym_tmp = fft(FDE_data_input(jj));
            H_est_tmp = H_est(jj);
            
            rx_layer_x(i_eq, jj) = ifft((H_est_tmp.^(-1)).*rx_user_sym_tmp); % ZF1 %% toto je posledni funkcni verze
            %     rx_layer_x(i_eq, jj) = ifft(pinv(H_est_tmp).*rx_user_sym_tmp); % ZF2
            
            %     rx_layer_x(i_eq, jj) =
            %     ifft((conj(H_est_tmp)/((abs(H_est_tmp)^2)+(2*(10^(-SNR_dB/10))^2))).*rx_user_sym_tmp); % MMSE
            %     rx_layer_x(i_eq, jj) = ifft((conj(H_est_tmp)/((abs(H_est_tmp)^2)+(2*var_n^2))).*rx_user_sym_tmp);% MMSE
            
            % informace pro demodulator
            CSM = hDemod.CustomSymbolMapping;
            if MCS.M == 2
                bittable = (logical(de2bi(0:length(SymbolAlphabet)-1).'));
            else
                bittable = flipud(logical(de2bi(CSM).'));
            end
            %
            [Q, R] = qr(H_est_tmp);
            demodulatorOutSSD_blk(1, ((jj-1)*log2(MCS.M))+1:jj*log2(MCS.M)) = (LTE_softsphere(rx_layer_x(i_eq, jj), (rx_user_sym_tmp), Q, R, SymbolAlphabet, bittable, 1, log2(MCS.M))).';
%                      demodulatorOutSSD_blk(1, ((jj-1)*log2(MCS.M))+1:jj*log2(MCS.M)) = (LTE_softsphere(rx_layer_x(i_eq, jj), ifft(rx_user_sym_tmp), Q, R, SymbolAlphabet, bittable, 1, log2(MCS.M))).'; % pozor na implementaci ifft! overit zda je to korektne nebo ne!
        end
        demodulatorOutSSD(i_eq,:) = demodulatorOutSSD_blk;
        
		
        %%% see: http://www.ursi.org/proceedings/procGA11/ursi/C02-3.pdf % jednoducha implementace MMSE
        
    end
    
    
    % rx_modulatedDataSymbol_blocks_derotated_equalized = FDE_data_output;
	rx_modulatedDataSymbol_blocks_derotated_equalized = rx_layer_x;

%% DATA BLOCKS DEMODULATION
% remove pi/2 rotation - removed above (obsolete)
% modulated_symbol_index_k = (0:numel(rx_modulatedDataSymbol_blocks)-1);
% rx_modulatedDataSymbol_blocks_derotated = reshape(rx_modulatedDataSymbol_blocks.',1,[]).*exp(-1j*pi*modulated_symbol_index_k/2);

% demodulation
% if strcmp(wifi_params.coding.decision_type,'LLR')
%     %     hDemod_LLR.Variance = 10^(-channelObj.SNR/10);
%     demodulatorOut = step(hDemod_LLR, rx_modulatedDataSymbol_blocks_derotated.'/modNorm);
%     demodulatorOut_hard = step(hDemod, rx_modulatedDataSymbol_blocks_derotated.'/modNorm);
% else
%     demodulatorOut = -2*step(hDemod, rx_modulatedDataSymbol_blocks_derotated.'/modNorm)+1;
%     demodulatorOut_hard = demodulatorOut;
% end
% % demodulatorIn = reshape(rx_modulatedDataSymbol_blocks_derotated_equalized.', 1, []);
% %  demodulatorOut = demodulator(demodulatorIn, MCS.M, wifi_params, SNR_dB); % testovani demodulatoru

% release(hDemod_LLR)
% hDemod_LLR.Variance = 10^(-channelObj.SNR/10);
%  demodulatorOut = (-2*step(hDemod, demodulatorIn.'/modNorm)+1).';
%  hDemod_LLR.Variance = 10^(-channelObj.SNR/10);
%  demodulatorOut33 = step(hDemod_LLR, demodulatorIn.'/modNorm);
% demodulatorOut33 = reshape(demodulatorOut44.',1,[]);
% release(hDemod_LLR);


demodulatorOut = reshape(-demodulatorOutSSD.',1,[]).';


%% LDPC CHANNEL DECODING

decoderIn = 10*demodulatorOut*(1/wifi_params.modulation(log2(MCS.M)).hMod_factor);
warning('TBD')

% generate scrambling sequence of data and block pad length
scr_seed = wifi_params.scrambling.scr_seed;
length_PSDU_rx_padded = 8*LENGTH+wifi_params.coding.N_Data_pad;

scramblingSeq = AD_ScramblingSeqGen(length_PSDU_rx_padded+N_blk_pad, scr_seed);

scramblingSeq_data = scramblingSeq(1:length_PSDU_rx_padded); % scrambling seq for input data
scramblingSeq_block_pad = scramblingSeq(length_PSDU_rx_padded+1:end); % scrambling sequence for blocks pad bits, see ch. 20.6.3.2.3.3/e, page 2475

% ee] reverse concatenation of coded bit stream and N_blk_pad zeros
% demux decoderIn and scrambled block pad zeros (reverse concatenation)
% extract decoder input bits
decoderIn_extracted = decoderIn(1:length(decoderIn)-N_blk_pad,:);
% extract block pad zeros
extracted_blk_pads = decoderIn(end-N_blk_pad+1:end,:);
descrambled_blk_pads = extracted_blk_pads.*(-2*scramblingSeq_block_pad+1); % should be all logical zeros (i.e. > 0)

% cc] reshape to matrix with N_blks rows
% dec_block_matrix = reshape(decoderIn_extracted,[],N_blks).'; % not necessary for decoding

% LDPC decoding (encoding process is fully described in 20.6.3.2.3.3)
% bb] procedure for converting the scrambled PSDU data to LDPC codeword
switch MCS.Repetition
    case 1
        if MCS.CR ~= 7/8
            % reshape input codeword to decode to N_cw rows
            decoderIn_all_cw = reshape(decoderIn_extracted,[],N_cw).';
            % scrambler output stream is broken into blocks of L_cwd bits
            L_cwd = L_ldpc*MCS.CR;
            
            % preallocate output of the decoder
            decoderOut_cw_tmp = zeros(N_cw, L_cwd); % all cw
            
            % decode each code word
            for i_cw = 1:N_cw
                decoderIn_cw_temp = decoderIn_all_cw(i_cw, :);
                
                decoderOut_cw = hDec.step(decoderIn_cw_temp.');
                decoderOut_cw_tmp(i_cw, :) = decoderOut_cw.';
            end
            
        elseif MCS.CR == 7/8
            % in this case, 48 bits are punctured from the parity bits of
            % the code rate 13/16
            % scrambler output stream is broken into blocks of L_cr78 bits
            L_cr78 = 546;
            N_remove_parity = 48; % number of parity bits to remove
            % preallocate output of the decoder
            decoderOut_cw_tmp = zeros(N_cw, L_cr78); % all cw
            
            % reshape input codeword to decode to N_cw rows
            decoderIn_all_cw = reshape(decoderIn_extracted,[],N_cw).';
            
            % decode each code word using LDPC matrix for code rate 13/16
            for i_cw = 1:N_cw
                decoderIn_cw_temp = decoderIn_all_cw(i_cw, :);
                % pick data part
                cw_data_part = decoderIn_cw_temp(1, 1:L_cr78);
                % pick parity part and add zeros (add first 48 parity bits
                % to each codeword parity (logical 0 = +1))
                cw_parity_part = [ones(1, N_remove_parity), decoderIn_cw_temp(1, L_cr78+1:end)];
                
                decoderIn_cw_temp2 = [cw_data_part, cw_parity_part]; % decoder input
                
                decoderOut_cw = hDec.step(decoderIn_cw_temp2.');
                decoderOut_cw_tmp(i_cw, :) = decoderOut_cw.';
            end
            
        end
    case 2
        L_z = L_ldpc/(2*MCS.Repetition); % Length of block in bits
        L_zeros = L_z; % number of zeros
        
        % preallocate output of the decoder
        decoderOut_cw_tmp = zeros(N_cw, L_z); % all cw
        
        
        % reshape input codeword to decode to N_cw rows
        decoderIn_all_cw = reshape(decoderIn_extracted,[],N_cw).';
        
        for i_cw = 1:N_cw
            decoderIn_cw_temp = decoderIn_all_cw(i_cw, :);
            useRepeat = 1;
            % extract repetition (L_z bits)
            % for now, it is not employed
            decoderIn_cw_repeated_part_scrambled = decoderIn_cw_temp(1, L_z+1:L_z+L_zeros);
            PNseq_for_repetition = AD_ScramblingSeqGen(length(decoderIn_cw_repeated_part_scrambled), [1 1 1 1 1 1 1]);
            decoderIn_cw_repeated_part = ((decoderIn_cw_repeated_part_scrambled.').*(-2*PNseq_for_repetition+1)).';
            % replace repeated part in decoderIn_cw_temp by zero symbols (log. 0 = +1)
            decoderIn_cw_temp(1, L_z+1:L_z+L_zeros) = +10;
            
            if useRepeat == 1
                decoderIn_cw_temp(1,1:L_z) = decoderIn_cw_temp(1,1:L_z)+decoderIn_cw_repeated_part;
            end
            %             decoderIn_cw_temp_from_repetition = decoderIn_cw_temp;
            %             decoderIn_cw_temp_from_repetition(1,1:L_z) = decoderIn_cw_repeated_part.';
            %             subplot(311), stem(decoderIn_cw_temp), xlim([1 672])
            % decoder
            decoderOut_cw_with_decoded_zeros = hDec.step(decoderIn_cw_temp.');
            decoderOut_cw_tmp(i_cw, :) = decoderOut_cw_with_decoded_zeros(1:L_z).';
            %             subplot(312), stem(decoderOut_cw_tmp), xlim([1 672])
            %             % try to decode repeated part
            %             release(hDec)
            %             decoderOut_cw_tmp2 = hDec.step(decoderIn_cw_temp_from_repetition.')
            %             subplot(313), stem(decoderOut_cw_tmp2), xlim([1 672])
        end
end

% build singe decoder output stream
decoderOut = reshape(decoderOut_cw_tmp.',[],1).';

%% DESCRAMBLING
% descrambling sequence defined in line 100
descramblerIn = decoderOut;
if wifi_params.general.useScrambling == 0
    descramblerOut = xor(descramblerIn, zeros(size(scramblingSeq_data.')));
else
    descramblerOut = xor(descramblerIn, scramblingSeq_data.');
end
%% EXTRACT PSDU INFORMATION
% PSDU
PSDU_rx_padded = descramblerOut;
N_PSDU_padding_zeros = wifi_params.coding.N_Data_pad;

PSDU_rx = PSDU_rx_padded(1,1:LENGTH*8);

%% Save results

rxObj.output.PSDU = PSDU_rx.'; % user traffic data without overhead
rxObj.output.PSDU_padded = PSDU_rx_padded.'; % user traffic data without overhead padded with zeros

rxObj.output.coded_data = decoderOut.'; % decoder output - user traffic data + SERVICE zeros field with overhead
rxObj.output.uncoded_data = (demodulatorOut(1:length(decoderIn)-N_blk_pad)<0).' + 0; % decoder input (raw data) (demodulated bits)

end