function txObj = WIFI_TX_ad(wifi_params,txObj,mcs_num)
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
N_blks = wifi_params.coding.N_blks;
% number of symbol padding bits
N_blk_pad = wifi_params.coding.N_blk_pad;
% LDPC encoder definition
hEnc = comm.LDPCEncoder(wifi_params.coding.UsedLDPC_matrix);
% Modulation mapping
hMod = wifi_params.modulation(log2(MCS.M)).hMod;
modNorm = wifi_params.modulation(log2(MCS.M)).hMod_factor;
% Spreading
n_fft = wifi_params.mapping.n_fft; % chips
n_tot = wifi_params.mapping.n_tot; % chips
n_gi = n_fft-n_tot; % chips

%% GENERATE PSDU INFORMATION
if wifi_params.general.sendAllZeros == true
    PSDU_tx = zeros(LENGTH*8,1);
elseif wifi_params.general.sendAllOnes == true
    PSDU_tx = ones(LENGTH*8,1);
else
    PSDU_tx = randi([0 1],LENGTH*8,1);
end

padding_zeros = zeros(wifi_params.coding.N_Data_pad,1);
PSDU_tx_padded = [PSDU_tx; padding_zeros];

% both should be scrambled, padding zeros with continuous scrambling word, see page 2474
%% SCRAMBLING
scr_seed = wifi_params.scrambling.scr_seed;
scramblingSeq = AD_ScramblingSeqGen(length(PSDU_tx_padded)+N_blk_pad, scr_seed);
scramblingSeq_data = scramblingSeq(1:length(PSDU_tx_padded)); % scrambling seq for input data
scramblingSeq_block_pad = scramblingSeq(length(PSDU_tx_padded)+1:end); % scrambling sequence for blocks pad bits, see ch. 20.6.3.2.3.3/e, page 2475
if wifi_params.general.useScrambling == 0
    scramblerOut = xor(PSDU_tx_padded, zeros(size(scramblingSeq_data))); % tx scrambling OFF
else
    scramblerOut = xor(PSDU_tx_padded, scramblingSeq_data); % tx scrambling ON
end
% scramblerOut = PSDU_tx_padded; % vyrazeni scrambleru
%% LDPC CHANNEL CODING
encoderIn = scramblerOut;

% LDPC Encoding process is fully described in 20.6.3.2.3.3

% a] is done in load_wifi_params.m and LDPC_params.m
% b] procedure for converting the scrambled PSDU data to LDPC codeword
switch MCS.Repetition
    case 1
        if MCS.CR ~= 7/8
            % preallocation of output auxiliary matrix
            encoderOut_all_cw = zeros(N_cw, L_ldpc);
            % scrambler output stream is broken into blocks of L_cwd bits
            L_cwd = L_ldpc*MCS.CR;
            % sequences of length L_cwd, each row = single input data word
            encoderIn_data_blocks = reshape(encoderIn, L_cwd, []).';
            % encode each data word
            for i_cw = 1:N_cw
                encoderIn_cw_temp = encoderIn_data_blocks(i_cw, :);
                
                encoderOut_cw_temp = hEnc.step(encoderIn_cw_temp.');
                encoderOut_cw_temp = encoderOut_cw_temp.';
                % save input word and parity to matrix (each row = 1 codeword)
                encoderOut_all_cw(i_cw, :) = encoderOut_cw_temp;
            end
            
        elseif MCS.CR == 7/8
            % in this case, 48 bits are punctured from the parity bits of
            % the code rate 13/16
            % scrambler output stream is broken into blocks of L_cr78 bits
            L_cr78 = 546;
            N_remove_parity = 48; % number of parity bits to remove
            % preallocation of output auxiliary matrix
            encoderOut_all_cw = zeros(N_cw, L_ldpc+N_remove_parity);
            % sequences of length L_cr78, each row = single input data word
            encoderIn_data_blocks = reshape(encoderIn, L_cr78, []).';
            % encode each data word using LDPC matrix for code rate 13/16
            for i_cw = 1:N_cw
                encoderIn_cw_temp = encoderIn_data_blocks(i_cw, :);
                
                encoderOut_cw_temp = hEnc.step(encoderIn_cw_temp.');
                encoderOut_cw_temp = encoderOut_cw_temp.';
                % save input word and parity to matrix (each row = 1 codeword)
                encoderOut_all_cw(i_cw, :) = encoderOut_cw_temp;
            end
            % remove the first 48 parity bits from each codeword
            encoderOut_all_cw(:,L_cr78+1:L_cr78+N_remove_parity) = [];
            
        end
    case 2
        % preallocation of output auxiliary matrix
        encoderOut_all_cw = zeros(N_cw, L_ldpc);
        
        L_z = L_ldpc/(2*MCS.Repetition); % Length of block in bits
        L_zeros = L_z; % number of zeros
        % sequence length 2*L_z
        encoderIn_data_blocks = reshape(encoderIn, L_z, []).';
        encoderIn_data_blocks = [encoderIn_data_blocks, zeros(length(encoderIn)/L_z, L_zeros)]; % concatenate with zeros
        
        for i_cw = 1:N_cw
            encoderIn_cw_temp = encoderIn_data_blocks(i_cw, :);
            
            encoderOut_cw_temp = hEnc.step(encoderIn_cw_temp.');
            encoderOut_cw_temp = encoderOut_cw_temp.';
            % repetiton and scrambling
            encoderIn_cw_for_repetition = encoderIn_cw_temp(1:L_z);
            PNseq_for_repetition = AD_ScramblingSeqGen(length(encoderIn_cw_for_repetition), [1 1 1 1 1 1 1]);
            encoderIn_cw_repeated_scrambled = xor(encoderIn_cw_for_repetition, PNseq_for_repetition.');
            % replacement of zeros bits (from L_z+1 to 336) by repeated and scrambled input sequence
            encoderOut_cw_temp2 = encoderOut_cw_temp;
            encoderOut_cw_temp2(1,L_z+1:336) = encoderIn_cw_repeated_scrambled;
            encoderOut_all_cw(i_cw, :) = encoderOut_cw_temp2;
        end
        
    otherwise
        error('Wrong repetition factor, see WIFI_TX_ad.m and mcs_definition.m');
end
% c] concatenate to single codeword stream [1x?]
encoderOut_single_row = reshape(encoderOut_all_cw.', 1, []);

% d] divide to symbol blocks and add symbol pad bits
% e] concatenation of coded bit stream and N_blk_pad zeros
block_pad_zeros = zeros(N_blk_pad, 1);
% scrambling of block pad bits with continuous scrambling sequence from
% data scrambling
if wifi_params.general.useScrambling == 0
    scrambled_block_pad_zeros = xor(block_pad_zeros, zeros(size(scramblingSeq_block_pad))); % tx block pad zeros scrambling OFF
else
    scrambled_block_pad_zeros = xor(block_pad_zeros, scramblingSeq_block_pad); % tx block pad zeros scrambling ON
end
% concatenation
encoderOut = [encoderOut_single_row, scrambled_block_pad_zeros.']; % for raw BER computing
% symbol blocks (each row = 1 symbol block [bits])
% symbol_blocks_bits = reshape(encoderOut.',[],N_blks).';

%% MODULATION MAPPING
% common modulation
modulatedDataSymbol = step(hMod,encoderOut.')*modNorm;
modulated_STF_symbol_index_k = (0:length(modulatedDataSymbol)-1).';
% add pi/2 rotation
if wifi_params.general.dataSymbolRotation == 0
    modulatedDataSymbol_rotated = modulatedDataSymbol;
else
    modulatedDataSymbol_rotated = modulatedDataSymbol.*exp(1j*pi*modulated_STF_symbol_index_k/2);
end

% konstelace(modulatedDataSymbol, modulatedDataSymbol_rotated)

%% SYMBOL BLOCKING AND GUARD INSERTION
% blocks division
modulatedDataSymbol_blocks = reshape(modulatedDataSymbol_rotated,[],N_blks).';
% guard insertion
Ga64 = wifi_params.spreading.Golay_Seq.Ga_64;
k_Ga64 = 0:n_gi-1;
Ga64_rotated = Ga64.*exp(1j*pi*k_Ga64/2);

Ga64_rotated_repeated = repmat(Ga64_rotated, N_blks, 1);

% concatenate guard and blocks
modulatedDataSymbolsAndGuard = [Ga64_rotated_repeated, modulatedDataSymbol_blocks];
% single stream of guard and blocks
outputBlocks = reshape(modulatedDataSymbolsAndGuard.',[],1).';
% add the last guard on the end of the final block
outputBlocks = [outputBlocks, Ga64_rotated];

% NOTE:
% warning('Only data blocks are considered yet (see WIFI_TX_ad.m)');

%% Process other frame fields and concatenate to FRAME
% auxiliary Golay sequences
Ga128 = wifi_params.spreading.Golay_Seq.Ga_128;
Gb128 = wifi_params.spreading.Golay_Seq.Gb_128;
Gu512 = [-Gb128, -Ga128, +Gb128, -Ga128];
Gv512 = [-Gb128, +Ga128, -Gb128, -Ga128];

% Gu512 = [Gb128, Ga128, Gb128, Ga128]; % test purpose
% Gv512 = [Gb128, Ga128, Gb128, Ga128]; % test purpose

Gv128 = -Gb128;
% =========================================================================
% Control -----------------------------------------------------------------

% SC ----------------------------------------------------------------------
% these waveforms must be checked whether they are corresponding to the
% standard, see on page 2447
% STF {16x +Ga128, 1x -Ga128}:
STF = [repmat(Ga128, 1, 16), -Ga128];
modulated_STF_symbol_index_k = (0:length(STF)-1);
% add pi/2 rotation
modulatedSTFSymbol_rotated = STF.*exp(1j*pi*modulated_STF_symbol_index_k/2);
% CEF {Gu512, Gv512, Gv128}:
CEF = [Gu512, Gv512, Gv128];
modulated_CEF_symbol_index_k = (0:length(CEF)-1);
% add pi/2 rotation
modulatedCEFSymbol_rotated = CEF.*exp(1j*pi*modulated_CEF_symbol_index_k/2);
% Header {64 bits}:
if MCS.field_extended == 1
    switch MCS.field_base
        case 6
            Base_Length1 = floor(N_blks*4/3)*42;
            Base_Length2 = floor(floor(N_blks*56/39)*68.25);
        case 7
            Base_Length1 = floor(floor(N_blks*4/3)*52.5);
            Base_Length2 = floor(floor(N_blks*8/3)*68.25);
        case 8
            Base_Length1 = floor(N_blks*4/3)*63;
            Base_Length2 = floor(floor(N_blks*112/39)*68.25);
        case 9
            Base_Length1 = floor(floor(N_blks*4/3)*68.25);
            Base_Length2 = N_blks*210;
        case 10
            Base_Length1 = floor(N_blks*8/3)*42;
            Base_Length2 = N_blks*252;
        case 11
            Base_Length1 = floor(floor(N_blks*8/3)*52.5);
            Base_Length2 = N_blks*273;
        case 12
            Base_Length1 = floor(N_blks*8/3)*63;
            Base_Length2 = floor(floor(N_blks*56/13)*68.25);
        otherwise
            error('Impossible combination of MCS fields, see mcs_definition.m');
    end
    
    % Length_field in header
    Length_field = Base_Length1-floor((Base_Length2-wifi_params.general.LENGTH)/4);
else
    % Length_field in header
    Length_field = wifi_params.general.LENGTH;
end

Length_field_bin = de2bi(Length_field, 18, 'right-msb');
% (provisionally), see: 20.6.3.1.4 Header encoding and modulation
% LSB first
Header = [...
    wifi_params.scrambling.scr_seed,...         % bits 0...6 = scrambilng seed (length 7)
    [de2bi(MCS.field_base,4,'right-msb'), de2bi(MCS.field_extended,1,'right-msb')],... % bits 7...11 = MCS according to Table 20-17 (length 5)
    Length_field_bin,...                        % bits 12...29 = Length (length 18)
    0,...                                       % bits 30...30 = Additional PPDU (length 1) % NOTE: set to zero for now, see Table 20-17
    0,...                                       % bits 31...31 = Packet Type (length 1) % NOTE: set to zero for now, see Table 20-17
    [0 0 0 0 0],...                             % bits 32...36 = Training Length (length 5) % NOTE: set to all zeros vector for now - NO BEAMFORMING TRN, see Table 20-17
    0,...                                       % bits 37...37 = Aggregation (length 1) % NOTE: set to zero for now, see Table 20-17
    0,...                                       % bits 38...38 = Beam Tracking Request (length 1) % NOTE: set to zero for now, see Table 20-17
    [1 1 1 1],...                               % bits 39...42 = Last RSSI (length 4) % NOTE: set to all ones vector for now, see Table 20-17 (Last RSSI >= -42 dBm)
    0,...                                       % bits 43...43 = Turnaround (length 1) % NOTE: set to zero for now, see Table 20-17 and Table 20-1
    MCS.field_extended,...                      % bits 44...44 = Extended SC MCS Indication (length 1) % see Table 20-17
    [0 0 0],...                                 % bits 45...47 = Reserved all zero bits (length 3); shall be ignored in receiver % see Table 20-17
    ];
HeaderCRC = CRC16_FCS(wifi_params.framing.Header.hCRCgen, Header).'; % Header CRC-16 calculation
HeaderWithCRC = [Header, HeaderCRC];

% header encoding
% 1/ scrambling input header bits excepting first seven bits
scramblingSeqHeader = AD_ScramblingSeqGen(length(HeaderWithCRC)-length(wifi_params.scrambling.scr_seed), wifi_params.scrambling.scr_seed).';
% scrambling and concatenation with scrambling seq. results to $\bar{d}_{1s}=[q_1, q_2, \dots, q_{64}]$
scramblerHeaderOut = [HeaderWithCRC(1:length(wifi_params.scrambling.scr_seed)), xor(HeaderWithCRC(length(wifi_params.scrambling.scr_seed)+1:end), scramblingSeqHeader)];
% 2/ LDPC encoding (CR = 3/4)
encoderIn_Header = [scramblerHeaderOut, zeros(1, 504-length(HeaderWithCRC))];

hEncHeader = comm.LDPCEncoder(wifi_params.framing.Header.coding.UsedLDPC_matrix);
encoderOut_Header = hEncHeader.step(encoderIn_Header.');
% codeword sequence 1
% length(cs1) = 224
cs1 = encoderOut_Header;
cs1([length(HeaderWithCRC)+1:504, 665:672]) = []; % remove defined bits
% codeword sequence 2
% length(cs2) = 224
cs2 = encoderOut_Header;
cs2([length(HeaderWithCRC)+1:504, 657:664]) = []; % remove defined bits

scramblingSeq_cs2 = AD_ScramblingSeqGen(length(cs2), ones(1, 7)).';
cs2_Scrambled = single(xor(cs2.', scramblingSeq_cs2));
% concatenate cs1 and cs2_scrambled to form a 448 bits header codeword
cs12 = [cs1.', cs2_Scrambled];

% pi/2-BPSK mapping of header block
modulated_Header_symbol_index_k = (0:length(cs12)-1);
modulatedHeaderSymbol_rotated1 = (2*cs12-1).*exp(1j*pi*modulated_Header_symbol_index_k/2);
modulatedHeaderSymbol_rotated_withGI1 = [Ga64_rotated, modulatedHeaderSymbol_rotated1]; % guard insertion
% repeat HeaderSymbol block and multiply by -1
modulatedHeaderSymbol_rotated2 = -1*modulatedHeaderSymbol_rotated1;
modulatedHeaderSymbol_rotated_withGI2 = [Ga64_rotated, modulatedHeaderSymbol_rotated2];
% concatenate modulated HeaderSymbol blocks with GI
modulatedHeaderSymbol_rotated_withGI12 = [modulatedHeaderSymbol_rotated_withGI1, modulatedHeaderSymbol_rotated_withGI2];

% Beamforming training field (BTF) - in future
BTF = [];
modulatedBTFSymbol_rotated = BTF; % Header.*exp(1j*pi*modulated_Header_symbol_index_k/2);

% LPSC --------------------------------------------------------------------

% OFDM --------------------------------------------------------------------
% windowing / only in OFDM (No windowing in CEF and STF)
% x_s = zeros(1, sum(wifi_params.framing.ChipLengths));
x_s(wifi_params.framing.ChipMap{1}) = 1*modulatedSTFSymbol_rotated;
x_s(wifi_params.framing.ChipMap{2}) = 1*modulatedCEFSymbol_rotated;
x_s(wifi_params.framing.ChipMap{3}) = 1*modulatedHeaderSymbol_rotated_withGI12;
x_s(wifi_params.framing.ChipMap{4}) = outputBlocks;
x_s(wifi_params.framing.ChipMap{5}) = 0*modulatedBTFSymbol_rotated;


%% Save outputs
txObj.output.PSDU = PSDU_tx; % user traffic data without overhead
txObj.output.PSDU_padded = PSDU_tx_padded; % user traffic data without overhead padded with zeros

txObj.output.coded_data = encoderIn; % encoder input
txObj.output.uncoded_data = encoderOut_single_row; % encoder output (raw data)

% txObj.genie.scramblingSeq.data = scramblingSeq_data; % scrambling sequence for data
% txObj.genie.scramblingSeq.block_pad = scramblingSeq_block_pad; % scrambling sequence for block pad bits

% save('tx_test.mat','PSDU_tx','PSDU_tx_plus_service','encoderIn','encoderOut');
txObj.output.Data = outputBlocks;
txObj.output.DataDerotated = modulatedDataSymbol.';
txObj.output.STF = STF;
txObj.output.CEF = CEF;
txObj.output.Header = Header;
txObj.output.HeaderCRC = HeaderCRC;
txObj.output.BTF = BTF;
txObj.output.x_s = x_s;

txObj.genie.modulatedDataSymbol = modulatedDataSymbol;
txObj.genie.modulatedDataSymbol_rotated = modulatedDataSymbol_rotated;

txObj.genie.x_STF = modulatedSTFSymbol_rotated;
txObj.genie.x_CEF = modulatedCEFSymbol_rotated;
txObj.genie.x_header1 = modulatedHeaderSymbol_rotated1;
txObj.genie.x_header2 = modulatedHeaderSymbol_rotated2;

txObj.genie.scramblingSeq_data = scramblingSeq_data;

end