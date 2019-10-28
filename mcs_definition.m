%% Script defines Modulation and Coding Schemes
%
% Author:	Jiri Milos, DREL FEEC BUT, 2018
%
global wifi_params

switch wifi_standard
    case '802dot11ad'
        wifi_params.general.PHYlayer = 'SC';
        %         wifi_params.general.PHYlayer = 'LPSC';
        % Single Carrier
        % MCS 1 -------------------------------------------------------------------
        wifi_params.MCS(2).N_ss = 1;
        wifi_params.MCS(2).field_base = 1; % Base MCS field
        wifi_params.MCS(2).field_extended = 0; % Extended SC MCS indication field
        wifi_params.MCS(2).MCS = 'MCS1';
        wifi_params.MCS(2).CR = 1/2;
        wifi_params.MCS(2).Repetition = 2;
        wifi_params.MCS(2).M = 2; % pi/2-BPSK
        wifi_params.MCS(2).N_cbps = 1; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(2).N_cbpb = 448; % Number of coded bits per symbol block, see Table 20-21
        % MCS 2 -------------------------------------------------------------------
        wifi_params.MCS(3).N_ss = 1;
        wifi_params.MCS(3).field_base = 2; % Base MCS field
        wifi_params.MCS(3).field_extended = 0; % Extended SC MCS indication field
        wifi_params.MCS(3).MCS = 'MCS2';
        wifi_params.MCS(3).CR = 1/2;
        wifi_params.MCS(3).Repetition = 1;
        wifi_params.MCS(3).M = 2; % pi/2-BPSK
        wifi_params.MCS(3).N_cbps = 1; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(3).N_cbpb = 448; % Number of coded bits per symbol block, see Table 20-21
        % MCS 3 -------------------------------------------------------------------
        wifi_params.MCS(4).N_ss = 1;
        wifi_params.MCS(4).field_base = 3; % Base MCS field
        wifi_params.MCS(4).field_extended = 0; % Extended SC MCS indication field
        wifi_params.MCS(4).MCS = 'MCS3';
        wifi_params.MCS(4).CR = 5/8;
        wifi_params.MCS(4).Repetition = 1;
        wifi_params.MCS(4).M = 2; % pi/2-BPSK
        wifi_params.MCS(4).N_cbps = 1; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(4).N_cbpb = 448; % Number of coded bits per symbol block, see Table 20-21
        % MCS 4 -------------------------------------------------------------------
        wifi_params.MCS(5).N_ss = 1;
        wifi_params.MCS(5).field_base = 4; % Base MCS field
        wifi_params.MCS(5).field_extended = 0; % Extended SC MCS indication field
        wifi_params.MCS(5).MCS = 'MCS4';
        wifi_params.MCS(5).CR = 3/4;
        wifi_params.MCS(5).Repetition = 1;
        wifi_params.MCS(5).M = 2; % pi/2-BPSK
        wifi_params.MCS(5).N_cbps = 1; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(5).N_cbpb = 448; % Number of coded bits per symbol block, see Table 20-21
        % MCS 5 -------------------------------------------------------------------
        wifi_params.MCS(6).N_ss = 1;
        wifi_params.MCS(6).field_base = 5; % Base MCS field
        wifi_params.MCS(6).field_extended = 0; % Extended SC MCS indication field
        wifi_params.MCS(6).MCS = 'MCS5';
        wifi_params.MCS(6).CR = 13/16;
        wifi_params.MCS(6).Repetition = 1;
        wifi_params.MCS(6).M = 2; % pi/2-BPSK
        wifi_params.MCS(6).N_cbps = 1; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(6).N_cbpb = 448; % Number of coded bits per symbol block, see Table 20-21
        % MCS 6 -------------------------------------------------------------------
        wifi_params.MCS(7).N_ss = 1;
        wifi_params.MCS(7).field_base = 6; % Base MCS field
        wifi_params.MCS(7).field_extended = 0; % Extended SC MCS indication field
        wifi_params.MCS(7).MCS = 'MCS6';
        wifi_params.MCS(7).CR = 1/2;
        wifi_params.MCS(7).Repetition = 1;
        wifi_params.MCS(7).M = 4; % pi/2-QPSK
        wifi_params.MCS(7).N_cbps = 2; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(7).N_cbpb = 896; % Number of coded bits per symbol block, see Table 20-21
        % MCS 7 -------------------------------------------------------------------
        wifi_params.MCS(8).N_ss = 1;
        wifi_params.MCS(8).field_base = 7; % Base MCS field
        wifi_params.MCS(8).field_extended = 0; % Extended SC MCS indication field
        wifi_params.MCS(8).MCS = 'MCS7';
        wifi_params.MCS(8).CR = 5/8;
        wifi_params.MCS(8).Repetition = 1;
        wifi_params.MCS(8).M = 4; % pi/2-QPSK
        wifi_params.MCS(8).N_cbps = 2; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(8).N_cbpb = 896; % Number of coded bits per symbol block, see Table 20-21
        % MCS 8 -------------------------------------------------------------------
        wifi_params.MCS(9).N_ss = 1;
        wifi_params.MCS(9).field_base = 8; % Base MCS field
        wifi_params.MCS(9).field_extended = 0; % Extended SC MCS indication field
        wifi_params.MCS(9).MCS = 'MCS8';
        wifi_params.MCS(9).CR = 3/4;
        wifi_params.MCS(9).Repetition = 1;
        wifi_params.MCS(9).M = 4; % pi/2-QPSK
        wifi_params.MCS(9).N_cbps = 2; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(9).N_cbpb = 896; % Number of coded bits per symbol block, see Table 20-21
        % MCS 9 -------------------------------------------------------------------
        wifi_params.MCS(10).N_ss = 1;
        wifi_params.MCS(10).field_base = 9; % Base MCS field
        wifi_params.MCS(10).field_extended = 0; % Extended SC MCS indication field
        wifi_params.MCS(10).MCS = 'MCS9';
        wifi_params.MCS(10).CR = 13/16;
        wifi_params.MCS(10).Repetition = 1;
        wifi_params.MCS(10).M = 4; % pi/2-QPSK
        wifi_params.MCS(10).N_cbps = 2; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(10).N_cbpb = 896; % Number of coded bits per symbol block, see Table 20-21
        % MCS 9.1 -----------------------------------------------------------------
        wifi_params.MCS(11).N_ss = 1;
        wifi_params.MCS(11).field_base = 6; % Base MCS field
        wifi_params.MCS(11).field_extended = 1; % Extended SC MCS indication field
        wifi_params.MCS(11).MCS = 'MCS9.1';
        wifi_params.MCS(11).CR = 7/8;
        wifi_params.MCS(11).Repetition = 1;
        wifi_params.MCS(11).M = 4; % pi/2-QPSK
        wifi_params.MCS(11).N_cbps = 2; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(11).N_cbpb = 896; % Number of coded bits per symbol block, see Table 20-21
        % MCS 10 ------------------------------------------------------------------
        wifi_params.MCS(12).N_ss = 1;
        wifi_params.MCS(12).field_base = 10; % Base MCS field
        wifi_params.MCS(12).field_extended = 0; % Extended SC MCS indication field
        wifi_params.MCS(12).MCS = 'MCS10';
        wifi_params.MCS(12).CR = 1/2;
        wifi_params.MCS(12).Repetition = 1;
        wifi_params.MCS(12).M = 16; % pi/2-16QAM
        wifi_params.MCS(12).N_cbps = 4; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(12).N_cbpb = 1792; % Number of coded bits per symbol block, see Table 20-21
        % MCS 11 ------------------------------------------------------------------
        wifi_params.MCS(13).N_ss = 1;
        wifi_params.MCS(13).field_base = 11; % Base MCS field
        wifi_params.MCS(13).field_extended = 0; % Extended SC MCS indication field
        wifi_params.MCS(13).MCS = 'MCS11';
        wifi_params.MCS(13).CR = 5/8;
        wifi_params.MCS(13).Repetition = 1;
        wifi_params.MCS(13).M = 16; % pi/2-16QAM
        wifi_params.MCS(13).N_cbps = 4; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(13).N_cbpb = 1792; % Number of coded bits per symbol block, see Table 20-21
        % MCS 12 ------------------------------------------------------------------
        wifi_params.MCS(14).N_ss = 1;
        wifi_params.MCS(14).field_base = 12; % Base MCS field
        wifi_params.MCS(14).field_extended = 0; % Extended SC MCS indication field
        wifi_params.MCS(14).MCS = 'MCS12';
        wifi_params.MCS(14).CR = 3/4;
        wifi_params.MCS(14).Repetition = 1;
        wifi_params.MCS(14).M = 16; % pi/2-16QAM
        wifi_params.MCS(14).N_cbps = 4; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(14).N_cbpb = 1792; % Number of coded bits per symbol block, see Table 20-21
        % MCS 12.1 ----------------------------------------------------------------
        wifi_params.MCS(15).N_ss = 1;
        wifi_params.MCS(15).field_base = 7; % Base MCS field
        wifi_params.MCS(15).field_extended = 1; % Extended SC MCS indication field
        wifi_params.MCS(15).MCS = 'MCS12.1';
        wifi_params.MCS(15).CR = 13/16;
        wifi_params.MCS(15).Repetition = 1;
        wifi_params.MCS(15).M = 16; % pi/2-16QAM
        wifi_params.MCS(15).N_cbps = 4; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(15).N_cbpb = 1792; % Number of coded bits per symbol block, see Table 20-21
        % MCS 12.2 ----------------------------------------------------------------
        wifi_params.MCS(16).N_ss = 1;
        wifi_params.MCS(16).field_base = 8; % Base MCS field
        wifi_params.MCS(16).field_extended = 1; % Extended SC MCS indication field
        wifi_params.MCS(16).MCS = 'MCS12.2';
        wifi_params.MCS(16).CR = 7/8;
        wifi_params.MCS(16).Repetition = 1;
        wifi_params.MCS(16).M = 16; % pi/2-16QAM
        wifi_params.MCS(16).N_cbps = 4; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(16).N_cbpb = 1792; % Number of coded bits per symbol block, see Table 20-21
        % MCS 12.3 ----------------------------------------------------------------
        wifi_params.MCS(17).N_ss = 1;
        wifi_params.MCS(17).field_base = 9; % Base MCS field
        wifi_params.MCS(17).field_extended = 1; % Extended SC MCS indication field
        wifi_params.MCS(17).MCS = 'MCS12.3';
        wifi_params.MCS(17).CR = 5/8;
        wifi_params.MCS(17).Repetition = 1;
        wifi_params.MCS(17).M = 64; % pi/2-64QAM
        wifi_params.MCS(17).N_cbps = 6; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(17).N_cbpb = 2688; % Number of coded bits per symbol block, see Table 20-21
        % MCS 12.4 ----------------------------------------------------------------
        wifi_params.MCS(18).N_ss = 1;
        wifi_params.MCS(18).field_base = 10; % Base MCS field
        wifi_params.MCS(18).field_extended = 1; % Extended SC MCS indication field
        wifi_params.MCS(18).MCS = 'MCS12.4';
        wifi_params.MCS(18).CR = 3/4;
        wifi_params.MCS(18).Repetition = 1;
        wifi_params.MCS(18).M = 64; % pi/2-64QAM
        wifi_params.MCS(18).N_cbps = 6; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(18).N_cbpb = 2688; % Number of coded bits per symbol block, see Table 20-21
        % MCS 12.5 ----------------------------------------------------------------
        wifi_params.MCS(19).N_ss = 1;
        wifi_params.MCS(19).field_base = 11; % Base MCS field
        wifi_params.MCS(19).field_extended = 1; % Extended SC MCS indication field
        wifi_params.MCS(19).MCS = 'MCS12.5';
        wifi_params.MCS(19).CR = 13/16;
        wifi_params.MCS(19).Repetition = 1;
        wifi_params.MCS(19).M = 64; % pi/2-64QAM
        wifi_params.MCS(19).N_cbps = 6; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(19).N_cbpb = 2688; % Number of coded bits per symbol block, see Table 20-21
        % MCS 12.6 ----------------------------------------------------------------
        wifi_params.MCS(20).N_ss = 1;
        wifi_params.MCS(20).field_base = 12; % Base MCS field
        wifi_params.MCS(20).field_extended = 1; % Extended SC MCS indication field
        wifi_params.MCS(20).MCS = 'MCS12.6';
        wifi_params.MCS(20).CR = 7/8;
        wifi_params.MCS(20).Repetition = 1;
        wifi_params.MCS(20).M = 64; % pi/2-64QAM
        wifi_params.MCS(20).N_cbps = 6; % Number of coded bits per symbol, see Table 20-19
        wifi_params.MCS(20).N_cbpb = 2688; % Number of coded bits per symbol block, see Table 20-21
end

% MCS indices preselection
mcs_tol = 0.001;
switch wifi_standard
    case '802dot11n'
        n_MCS_vec20 = (0:31).'; % for 20 MHz bandwidth
        n_MCS_vec40 = (0:32).'; % for 40 MHz bandwidth
        n_MCS_data_rates_vec20 = [...
            6.5,   13,    19.5,   26,     39,     52,     58.5,   65,...
            13,     26,    39,     52,     78,    104,    117,    130,...
            19.5,   39,    58.5,   78,    117,    156,    175.5,  195,...
            26,     52,    78,    104,    156,    208,    234,    260;...
            7.2,   14.4,  21.7,   28.9,   43.3,   57.8,   65,     72.2,...
            14.4,   28.9,  43.3,   57.8,   86.7,  115.6,  130,    144.4,...
            21.7,   43.3,  65,     86.7,  130,    173.3,  195,    216.7,...
            28.9,   57.8,  86.7,  115.6,  173.3,  231.1,  260,    288.9]*1e6; % [Mb/s]
        n_MCS_data_rates_vec40 = [...
            13.5,   27,    40.5,   54,     81,    108,    121.5,  135,...
            27,     54,    81,    108,    162,    216,    243,    270,...
            40.5,   81,   121.5,  162,    243,    324,    364.5,  405,...
            54,    108,   162,    216,    324,    432,    486,    540,   6;...
            15,     30,    45,     60,     90,    120,    135,    150,...
            30,     60,    90,    120,    180,    240,    270,    300,...
            45,     90,   135,    180,    270,    360,    405,    450,...
            60,    120,   180,    240,    360,    480,    540,    600,   6.7]*1e6; % [Mb/s]
        ind_mcs_offset = 0;
        
        if ischar(MCSvec)
            switch MCSvec
                case 'all'
                    MCSvec = n_MCS_vec20(1:8); % only for SISO and BW = 20 MHz
                otherwise
                    error('Unsupported option');
            end
        end
        
        ind_mcs_tmp1 = find(abs(n_MCS_vec20-MCSvec) < mcs_tol);
        ind_mcs_mod1 = mod(ind_mcs_tmp1, length(n_MCS_vec20));
        ind_mcs_mod1(ind_mcs_mod1 == 0) = length(n_MCS_vec20);
        i_mcs_vec_aux = (sort(ind_mcs_mod1 + ind_mcs_offset)).';
        %        TBD
        
    case '802dot11ad'
        ad_MCS_vec = [1:9, 9.1, 10:12, 12.1:0.1:12.6].'; % for SC
        ad_MCS_data_rates_vec = [...
            385; 770; 962.5; 1155; 1251.25; 1540; 1925; 2310; 2502.5;...
            2695; 3080; 3850; 4620; 5005; 5390; 5775; 6390; 7507.5; 8085]*1e6; % [Mb/s]
        %     table(ad_MCS_vec, ad_MCS_data_rates_vec)
        ind_mcs_offset = 1; % NOTE: in the switch-case structure above, relevant MCS have the first index shifted by the value ind_mcs_offset
        
        if ischar(MCSvec)
            switch MCSvec
                case 'all'
                    MCSvec = ad_MCS_vec;
                otherwise
                    error('Unsupported option');
            end
        end
        
        ind_mcs_tmp1 = find(abs(ad_MCS_vec-MCSvec) < mcs_tol);
        ind_mcs_mod1 = mod(ind_mcs_tmp1, length(ad_MCS_vec));
        ind_mcs_mod1(ind_mcs_mod1 == 0) = length(ad_MCS_vec);
        i_mcs_vec_aux = (sort(ind_mcs_mod1 + ind_mcs_offset)).';
        
        %     mcs_vec_aux = mod(find(abs(ad_MCS_vec-MCSvec) < mcs_tol)+1, length(ad_MCS_vec)) + ind_mcs_offset;
        if isempty(i_mcs_vec_aux)
            error('Chosen MCS undefined for IEEE 802.11ad SC mode (see load_wifi_params.m and mcs_definition.m)');
        end
    case {'802dot11g', '802dot11ac', '802dot11af', '802dot11ah', '802dot11ax'}
        warning('Check in future (see load_wifi_params.m)');
    otherwise
        error('Undefined IEEE 802.11 standard (see load_wifi_params.m)');
end

