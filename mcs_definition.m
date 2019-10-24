%% Script defines Modulation and Coding Schemes
%
% Author:	Jiri Milos, DREL FEEC BUT, 2018
%
global wifi_params

switch wifi_standard
    case '802dot11g'
        wifi_params.general.PHYlayer = 'OFDM';
        % MCS 0 -------------------------------------------------------------------
        wifi_params.MCS(1).N_ss = 1; % Nss number of spatial streams
        wifi_params.MCS(1).N_es = 1; % Nes number of BCC encoders for the DATA field
        wifi_params.MCS(1).MCS = 'MCS0';
        wifi_params.MCS(1).CR = 1/2;
        wifi_params.MCS(1).M = 2; % BPSK
        wifi_params.MCS(1).N_cbps = 48;
        wifi_params.MCS(1).N_dbps = 24;
        % MCS 1 -------------------------------------------------------------------
        wifi_params.MCS(2).N_ss = 1;
        wifi_params.MCS(2).N_es = 1;
        wifi_params.MCS(2).MCS = 'MCS1';
        wifi_params.MCS(2).CR = 3/4;
        wifi_params.MCS(2).M = 2; % BPSK
        wifi_params.MCS(2).N_cbps = 48;
        wifi_params.MCS(2).N_dbps = 36;
        % MCS 2 -------------------------------------------------------------------
        wifi_params.MCS(3).N_ss = 1;
        wifi_params.MCS(3).N_es = 1;
        wifi_params.MCS(3).MCS = 'MCS2';
        wifi_params.MCS(3).CR = 1/2;
        wifi_params.MCS(3).M = 4; % QPSK
        wifi_params.MCS(3).N_cbps = 96;
        wifi_params.MCS(3).N_dbps = 48;
        % MCS 3 -------------------------------------------------------------------
        wifi_params.MCS(4).N_ss = 1;
        wifi_params.MCS(4).N_es = 1;
        wifi_params.MCS(4).MCS = 'MCS3';
        wifi_params.MCS(4).CR = 3/4;
        wifi_params.MCS(4).M = 4; % QPSK
        wifi_params.MCS(4).N_cbps = 96;
        wifi_params.MCS(4).N_dbps = 72;
        % MCS 4 ---------------------------------------------------
        wifi_params.MCS(5).N_ss = 1;
        wifi_params.MCS(5).N_es = 1;
        wifi_params.MCS(5).MCS = 'MCS4';
        wifi_params.MCS(5).CR = 1/2;
        wifi_params.MCS(5).M = 16; % 16QAM
        wifi_params.MCS(5).N_cbps = 192;
        wifi_params.MCS(5).N_dbps = 96;
        % MCS 5 -------------------------------------------------------------------
        wifi_params.MCS(6).N_ss = 1;
        wifi_params.MCS(6).N_es = 1;
        wifi_params.MCS(6).MCS = 'MCS5';
        wifi_params.MCS(6).CR = 3/4;
        wifi_params.MCS(6).M = 16; % 16QAM
        wifi_params.MCS(6).N_cbps = 192;
        wifi_params.MCS(6).N_dbps = 144;
        % MCS 6 -------------------------------------------------------------------
        wifi_params.MCS(7).N_ss = 1;
        wifi_params.MCS(7).N_es = 1;
        wifi_params.MCS(7).MCS = 'MCS6';
        wifi_params.MCS(7).CR = 2/3;
        wifi_params.MCS(7).M = 64; % 64QAM
        wifi_params.MCS(7).N_cbps = 288;
        wifi_params.MCS(7).N_dbps = 192;
        % MCS 7 -------------------------------------------------------------------
        wifi_params.MCS(8).N_ss = 1;
        wifi_params.MCS(8).N_es = 1;
        wifi_params.MCS(8).MCS = 'MCS7';
        wifi_params.MCS(8).CR = 3/4;
        wifi_params.MCS(8).M = 64; % 64QAM
        wifi_params.MCS(8).N_cbps = 288;
        wifi_params.MCS(8).N_dbps = 216;
    case '802dot11n'
        wifi_params.general.PHYlayer = 'OFDM';
        switch ChannelBandwidth
            case 20
                % MCS 0 -------------------------------------------------------------------
                wifi_params.MCS(1).N_ss = 1; % Nss number of spatial streams
                wifi_params.MCS(1).N_es = 1; % Nes number of BCC encoders for the DATA field
                wifi_params.MCS(1).MCS = 'MCS0';
                wifi_params.MCS(1).CR = 1/2;
                wifi_params.MCS(1).M = 2; % BPSK
%                 wifi_params.MCS(1).N_cbps = wifi_params.mapping.n_data*log2(wifi_params.MCS(1).M)*wifi_params.MCS(1).N_ss;
%                 wifi_params.MCS(1).N_dbps = wifi_params.MCS(1).N_cbps*wifi_params.MCS(1).CR;
                wifi_params.MCS(1).N_cbps = 52;
                wifi_params.MCS(1).N_dbps = 26;
                % MCS 1 -------------------------------------------------------------------
                wifi_params.MCS(2).N_ss = 1;
                wifi_params.MCS(2).N_es = 1;
                wifi_params.MCS(2).MCS = 'MCS1';
                wifi_params.MCS(2).CR = 1/2;
                wifi_params.MCS(2).M = 4; % QPSK
                wifi_params.MCS(2).N_cbps = 104;
                wifi_params.MCS(2).N_dbps = 52;
                % MCS 2 -------------------------------------------------------------------
                wifi_params.MCS(3).N_ss = 1;
                wifi_params.MCS(3).N_es = 1;
                wifi_params.MCS(3).MCS = 'MCS2';
                wifi_params.MCS(3).CR = 3/4;
                wifi_params.MCS(3).M = 4; % QPSK
                wifi_params.MCS(3).N_cbps = 104;
                wifi_params.MCS(3).N_dbps = 78;
                % MCS 3 -------------------------------------------------------------------
                wifi_params.MCS(4).N_ss = 1;
                wifi_params.MCS(4).N_es = 1;
                wifi_params.MCS(4).MCS = 'MCS3';
                wifi_params.MCS(4).CR = 1/2;
                wifi_params.MCS(4).M = 16; % 16QAM
                wifi_params.MCS(4).N_cbps = 208;
                wifi_params.MCS(4).N_dbps = 104;
                % MCS 4 ---------------------------------------------------
                wifi_params.MCS(5).N_ss = 1;
                wifi_params.MCS(5).N_es = 1;
                wifi_params.MCS(5).MCS = 'MCS4';
                wifi_params.MCS(5).CR = 3/4;
                wifi_params.MCS(5).M = 16; % 16QAM
                wifi_params.MCS(5).N_cbps = 208;
                wifi_params.MCS(5).N_dbps = 156;
                % MCS 5 -------------------------------------------------------------------
                wifi_params.MCS(6).N_ss = 1;
                wifi_params.MCS(6).N_es = 1;
                wifi_params.MCS(6).MCS = 'MCS5';
                wifi_params.MCS(6).CR = 2/3;
                wifi_params.MCS(6).M = 64; % 64QAM
                wifi_params.MCS(6).N_cbps = 312;
                wifi_params.MCS(6).N_dbps = 208;
                % MCS 6 -------------------------------------------------------------------
                wifi_params.MCS(7).N_ss = 1;
                wifi_params.MCS(7).N_es = 1;
                wifi_params.MCS(7).MCS = 'MCS6';
                wifi_params.MCS(7).CR = 3/4;
                wifi_params.MCS(7).M = 64; % 64QAM
                wifi_params.MCS(7).N_cbps = 312;
                wifi_params.MCS(7).N_dbps = 234;
                % MCS 7 -------------------------------------------------------------------
                wifi_params.MCS(8).N_ss = 1;
                wifi_params.MCS(8).N_es = 1;
                wifi_params.MCS(8).MCS = 'MCS7';
                wifi_params.MCS(8).CR = 5/6;
                wifi_params.MCS(8).M = 64; % 64QAM
                wifi_params.MCS(8).N_cbps = 312;
                wifi_params.MCS(8).N_dbps = 260;
                % MCS 8 -------------------------------------------------------------------
                wifi_params.MCS(9).N_ss = 2;
                wifi_params.MCS(9).N_es = 1;
                wifi_params.MCS(9).MCS = 'MCS8';
                wifi_params.MCS(9).CR = 1/2;
                wifi_params.MCS(9).M = 2; % BPSK
                wifi_params.MCS(9).N_cbps = 104;
                wifi_params.MCS(9).N_dbps = 52;
                % MCS 9 -------------------------------------------------------------------
                wifi_params.MCS(10).N_ss = 2;
                wifi_params.MCS(10).N_es = 1;
                wifi_params.MCS(10).MCS = 'MCS9';
                wifi_params.MCS(10).CR = 1/2;
                wifi_params.MCS(10).M = 4; % QPSK
                wifi_params.MCS(10).N_cbps = 208;
                wifi_params.MCS(10).N_dbps = 104;
                % MCS 10 -------------------------------------------------------------------
                wifi_params.MCS(11).N_ss = 2;
                wifi_params.MCS(11).N_es = 1;
                wifi_params.MCS(11).MCS = 'MCS10';
                wifi_params.MCS(11).CR = 3/4;
                wifi_params.MCS(11).M = 4; % QPSK
                wifi_params.MCS(11).N_cbps = 208;
                wifi_params.MCS(11).N_dbps = 156;
                % MCS 11 -------------------------------------------------------------------
                wifi_params.MCS(12).N_ss = 2;
                wifi_params.MCS(12).N_es = 1;
                wifi_params.MCS(12).MCS = 'MCS11';
                wifi_params.MCS(12).CR = 1/2;
                wifi_params.MCS(12).M = 16; % 16QAM
                wifi_params.MCS(12).N_cbps = 416;
                wifi_params.MCS(12).N_dbps = 208;
                % MCS 12 -------------------------------------------------------------------
                wifi_params.MCS(13).N_ss = 2;
                wifi_params.MCS(13).N_es = 1;
                wifi_params.MCS(13).MCS = 'MCS12';
                wifi_params.MCS(13).CR = 3/4;
                wifi_params.MCS(13).M = 16; % 16QAM
                wifi_params.MCS(13).N_cbps = 416;
                wifi_params.MCS(13).N_dbps = 312;
                % MCS 13 -------------------------------------------------------------------
                wifi_params.MCS(14).N_ss = 2;
                wifi_params.MCS(14).N_es = 1;
                wifi_params.MCS(14).MCS = 'MCS13';
                wifi_params.MCS(14).CR = 2/3;
                wifi_params.MCS(14).M = 64; % 64QAM
                wifi_params.MCS(14).N_cbps = 624;
                wifi_params.MCS(14).N_dbps = 416;
                % MCS 14 -------------------------------------------------------------------
                wifi_params.MCS(15).N_ss = 2;
                wifi_params.MCS(15).N_es = 1;
                wifi_params.MCS(15).MCS = 'MCS14';
                wifi_params.MCS(15).CR = 3/4;
                wifi_params.MCS(15).M = 64; % 64QAM
                wifi_params.MCS(15).N_cbps = 624;
                wifi_params.MCS(15).N_dbps = 468;
                % MCS 15 -------------------------------------------------------------------
                wifi_params.MCS(16).N_ss = 2;
                wifi_params.MCS(16).N_es = 1;
                wifi_params.MCS(16).MCS = 'MCS15';
                wifi_params.MCS(16).CR = 5/6;
                wifi_params.MCS(16).M = 64; % 64QAM
                wifi_params.MCS(16).N_cbps = 624;
                wifi_params.MCS(16).N_dbps = 520;
                % MCS 16 -------------------------------------------------------------------
                wifi_params.MCS(17).N_ss = 3;
                wifi_params.MCS(17).N_es = 1;
                wifi_params.MCS(17).MCS = 'MCS16';
                wifi_params.MCS(17).CR = 1/2;
                wifi_params.MCS(17).M = 2; % BPSK
                wifi_params.MCS(17).N_cbps = 156;
                wifi_params.MCS(17).N_dbps = 78;
                % MCS 17 -------------------------------------------------------------------
                wifi_params.MCS(18).N_ss = 3;
                wifi_params.MCS(18).N_es = 1;
                wifi_params.MCS(18).MCS = 'MCS17';
                wifi_params.MCS(18).CR = 1/2;
                wifi_params.MCS(18).M = 4; % QPSK
                wifi_params.MCS(18).N_cbps = 312;
                wifi_params.MCS(18).N_dbps = 156;
                % MCS 18 -------------------------------------------------------------------
                wifi_params.MCS(19).N_ss = 3;
                wifi_params.MCS(19).N_es = 1;
                wifi_params.MCS(19).MCS = 'MCS18';
                wifi_params.MCS(19).CR = 3/4;
                wifi_params.MCS(19).M = 4; % QPSK
                wifi_params.MCS(19).N_cbps = 312;
                wifi_params.MCS(19).N_dbps = 234;
                % MCS 19 -------------------------------------------------------------------
                wifi_params.MCS(20).N_ss = 3;
                wifi_params.MCS(20).N_es = 1;
                wifi_params.MCS(20).MCS = 'MCS19';
                wifi_params.MCS(20).CR = 1/2;
                wifi_params.MCS(20).M = 16; % 16QAM
                wifi_params.MCS(20).N_cbps = 624;
                wifi_params.MCS(20).N_dbps = 312;
                % MCS 20 -------------------------------------------------------------------
                wifi_params.MCS(21).N_ss = 3;
                wifi_params.MCS(21).N_es = 1;
                wifi_params.MCS(21).MCS = 'MCS20';
                wifi_params.MCS(21).CR = 3/4;
                wifi_params.MCS(21).M = 16; % 16QAM
                wifi_params.MCS(21).N_cbps = 624;
                wifi_params.MCS(21).N_dbps = 468;
                % MCS 21 -------------------------------------------------------------------
                wifi_params.MCS(22).N_ss = 3;
                wifi_params.MCS(22).N_es = 1;
                wifi_params.MCS(22).MCS = 'MCS21';
                wifi_params.MCS(22).CR = 2/3;
                wifi_params.MCS(22).M = 64; % 64QAM
                wifi_params.MCS(22).N_cbps = 936;
                wifi_params.MCS(22).N_dbps = 624;
                % MCS 22 -------------------------------------------------------------------
                wifi_params.MCS(23).N_ss = 3;
                wifi_params.MCS(23).N_es = 1;
                wifi_params.MCS(23).MCS = 'MCS22';
                wifi_params.MCS(23).CR = 3/4;
                wifi_params.MCS(23).M = 64; % 64QAM
                wifi_params.MCS(23).N_cbps = 936;
                wifi_params.MCS(23).N_dbps = 702;
                % MCS 23 -------------------------------------------------------------------
                wifi_params.MCS(24).N_ss = 3;
                wifi_params.MCS(24).N_es = 1;
                wifi_params.MCS(24).MCS = 'MCS23';
                wifi_params.MCS(24).CR = 5/6;
                wifi_params.MCS(24).M = 64; % 64QAM
                wifi_params.MCS(24).N_cbps = 936;
                wifi_params.MCS(24).N_dbps = 780;
                % MCS 24 -------------------------------------------------------------------
                wifi_params.MCS(25).N_ss = 4;
                wifi_params.MCS(25).N_es = 1;
                wifi_params.MCS(25).MCS = 'MCS24';
                wifi_params.MCS(25).CR = 1/2;
                wifi_params.MCS(25).M = 2; % BPSK
                wifi_params.MCS(25).N_cbps = 208;
                wifi_params.MCS(25).N_dbps = 104;
                % MCS 25 -------------------------------------------------------------------
                wifi_params.MCS(26).N_ss = 4;
                wifi_params.MCS(26).N_es = 1;
                wifi_params.MCS(26).MCS = 'MCS25';
                wifi_params.MCS(26).CR = 1/2;
                wifi_params.MCS(26).M = 4; % QPSK
                wifi_params.MCS(26).N_cbps = 416;
                wifi_params.MCS(26).N_dbps = 208;
                % MCS 26 -------------------------------------------------------------------
                wifi_params.MCS(27).N_ss = 4;
                wifi_params.MCS(27).N_es = 1;
                wifi_params.MCS(27).MCS = 'MCS26';
                wifi_params.MCS(27).CR = 3/4;
                wifi_params.MCS(27).M = 4; % QPSK
                wifi_params.MCS(27).N_cbps = 416;
                wifi_params.MCS(27).N_dbps = 312;
                % MCS 27 -------------------------------------------------------------------
                wifi_params.MCS(28).N_ss = 4;
                wifi_params.MCS(28).N_es = 1;
                wifi_params.MCS(28).MCS = 'MCS27';
                wifi_params.MCS(28).CR = 1/2;
                wifi_params.MCS(28).M = 16; % 16QAM
                wifi_params.MCS(28).N_cbps = 832;
                wifi_params.MCS(28).N_dbps = 416;
                % MCS 28 -------------------------------------------------------------------
                wifi_params.MCS(29).N_ss = 4;
                wifi_params.MCS(29).N_es = 1;
                wifi_params.MCS(29).MCS = 'MCS28';
                wifi_params.MCS(29).CR = 3/4;
                wifi_params.MCS(29).M = 16; % 16QAM
                wifi_params.MCS(29).N_cbps = 832;
                wifi_params.MCS(29).N_dbps = 624;
                % MCS 29 -------------------------------------------------------------------
                wifi_params.MCS(30).N_ss = 4;
                wifi_params.MCS(30).N_es = 1;
                wifi_params.MCS(30).MCS = 'MCS29';
                wifi_params.MCS(30).CR = 2/3;
                wifi_params.MCS(30).M = 64; % 64QAM
                wifi_params.MCS(30).N_cbps = 1248;
                wifi_params.MCS(30).N_dbps = 832;
                % MCS 30 -------------------------------------------------------------------
                wifi_params.MCS(31).N_ss = 4;
                wifi_params.MCS(31).N_es = 1;
                wifi_params.MCS(31).MCS = 'MCS30';
                wifi_params.MCS(31).CR = 3/4;
                wifi_params.MCS(31).M = 64; % 64QAM
                wifi_params.MCS(31).N_cbps = 1248;
                wifi_params.MCS(31).N_dbps = 936;
                % MCS 31 -------------------------------------------------------------------
                wifi_params.MCS(32).N_ss = 3;
                wifi_params.MCS(32).N_es = 1;
                wifi_params.MCS(32).MCS = 'MCS31';
                wifi_params.MCS(32).CR = 5/6;
                wifi_params.MCS(32).M = 64; % 64QAM
                wifi_params.MCS(32).N_cbps = 1248;
                wifi_params.MCS(32).N_dbps = 1040;
                % =========================================================================
                % MCS 32 - it is not defined for BW = 20 MHz
                wifi_params.MCS(33).N_ss = [];
                wifi_params.MCS(33).N_es = [];
                wifi_params.MCS(33).MCS = 'MCS32';
                wifi_params.MCS(33).CR = [];
                wifi_params.MCS(33).M = []; % 64QAM
                
            case 40
                % MCS 0 -------------------------------------------------------------------
                wifi_params.MCS(1).N_ss = 1; % Nss number of spatial streams
                wifi_params.MCS(1).N_es = 1; % Nes number of BCC encoders for the DATA field
                wifi_params.MCS(1).MCS = 'MCS0';
                wifi_params.MCS(1).CR = 1/2;
                wifi_params.MCS(1).M = 2; % BPSK
                wifi_params.MCS(1).N_cbps = 108;
                wifi_params.MCS(1).N_dbps = 54;
                % MCS 1 -------------------------------------------------------------------
                wifi_params.MCS(2).N_ss = 1;
                wifi_params.MCS(2).N_es = 1;
                wifi_params.MCS(2).MCS = 'MCS1';
                wifi_params.MCS(2).CR = 1/2;
                wifi_params.MCS(2).M = 4; % QPSK
                wifi_params.MCS(2).N_cbps = 216;
                wifi_params.MCS(2).N_dbps = 108;
                % MCS 2 -------------------------------------------------------------------
                wifi_params.MCS(3).N_ss = 1;
                wifi_params.MCS(3).N_es = 1;
                wifi_params.MCS(3).MCS = 'MCS2';
                wifi_params.MCS(3).CR = 3/4;
                wifi_params.MCS(3).M = 4; % QPSK
                wifi_params.MCS(3).N_cbps = 216;
                wifi_params.MCS(3).N_dbps = 162;
                % MCS 3 -------------------------------------------------------------------
                wifi_params.MCS(4).N_ss = 1;
                wifi_params.MCS(4).N_es = 1;
                wifi_params.MCS(4).MCS = 'MCS3';
                wifi_params.MCS(4).CR = 1/2;
                wifi_params.MCS(4).M = 16; % 16QAM
                wifi_params.MCS(4).N_cbps = 432;
                wifi_params.MCS(4).N_dbps = 216;
                % MCS 4 ---------------------------------------------------
                wifi_params.MCS(5).N_ss = 1;
                wifi_params.MCS(5).N_es = 1;
                wifi_params.MCS(5).MCS = 'MCS4';
                wifi_params.MCS(5).CR = 3/4;
                wifi_params.MCS(5).M = 16; % 16QAM
                wifi_params.MCS(5).N_cbps = 432;
                wifi_params.MCS(5).N_dbps = 324;
                % MCS 5 -------------------------------------------------------------------
                wifi_params.MCS(6).N_ss = 1;
                wifi_params.MCS(6).N_es = 1;
                wifi_params.MCS(6).MCS = 'MCS5';
                wifi_params.MCS(6).CR = 2/3;
                wifi_params.MCS(6).M = 64; % 64QAM
                wifi_params.MCS(6).N_cbps = 648;
                wifi_params.MCS(6).N_dbps = 432;
                % MCS 6 -------------------------------------------------------------------
                wifi_params.MCS(7).N_ss = 1;
                wifi_params.MCS(7).N_es = 1;
                wifi_params.MCS(7).MCS = 'MCS6';
                wifi_params.MCS(7).CR = 3/4;
                wifi_params.MCS(7).M = 64; % 64QAM
                wifi_params.MCS(7).N_cbps = 648;
                wifi_params.MCS(7).N_dbps = 486;
                % MCS 7 -------------------------------------------------------------------
                wifi_params.MCS(8).N_ss = 1;
                wifi_params.MCS(8).N_es = 1;
                wifi_params.MCS(8).MCS = 'MCS7';
                wifi_params.MCS(8).CR = 5/6;
                wifi_params.MCS(8).M = 64; % 64QAM
                wifi_params.MCS(8).N_cbps = 648;
                wifi_params.MCS(8).N_dbps = 540;
                % MCS 8 -------------------------------------------------------------------
                wifi_params.MCS(9).N_ss = 2;
                wifi_params.MCS(9).N_es = 1;
                wifi_params.MCS(9).MCS = 'MCS8';
                wifi_params.MCS(9).CR = 1/2;
                wifi_params.MCS(9).M = 2; % BPSK
                wifi_params.MCS(9).N_cbps = 216;
                wifi_params.MCS(9).N_dbps = 108;
                % MCS 9 -------------------------------------------------------------------
                wifi_params.MCS(10).N_ss = 2;
                wifi_params.MCS(10).N_es = 1;
                wifi_params.MCS(10).MCS = 'MCS9';
                wifi_params.MCS(10).CR = 1/2;
                wifi_params.MCS(10).M = 4; % QPSK
                wifi_params.MCS(10).N_cbps = 432;
                wifi_params.MCS(10).N_dbps = 216;
                % MCS 10 -------------------------------------------------------------------
                wifi_params.MCS(11).N_ss = 2;
                wifi_params.MCS(11).N_es = 1;
                wifi_params.MCS(11).MCS = 'MCS10';
                wifi_params.MCS(11).CR = 3/4;
                wifi_params.MCS(11).M = 4; % QPSK
                wifi_params.MCS(11).N_cbps = 432;
                wifi_params.MCS(11).N_dbps = 324;
                % MCS 11 -------------------------------------------------------------------
                wifi_params.MCS(12).N_ss = 2;
                wifi_params.MCS(12).N_es = 1;
                wifi_params.MCS(12).MCS = 'MCS11';
                wifi_params.MCS(12).CR = 1/2;
                wifi_params.MCS(12).M = 16; % 16QAM
                wifi_params.MCS(12).N_cbps = 864;
                wifi_params.MCS(12).N_dbps = 432;
                % MCS 12 -------------------------------------------------------------------
                wifi_params.MCS(13).N_ss = 2;
                wifi_params.MCS(13).N_es = 1;
                wifi_params.MCS(13).MCS = 'MCS12';
                wifi_params.MCS(13).CR = 3/4;
                wifi_params.MCS(13).M = 16; % 16QAM
                wifi_params.MCS(13).N_cbps = 864;
                wifi_params.MCS(13).N_dbps = 648;
                % MCS 13 -------------------------------------------------------------------
                wifi_params.MCS(14).N_ss = 2;
                wifi_params.MCS(14).N_es = 1;
                wifi_params.MCS(14).MCS = 'MCS13';
                wifi_params.MCS(14).CR = 2/3;
                wifi_params.MCS(14).M = 64; % 64QAM
                wifi_params.MCS(14).N_cbps = 1296;
                wifi_params.MCS(14).N_dbps = 864;
                % MCS 14 -------------------------------------------------------------------
                wifi_params.MCS(15).N_ss = 2;
                wifi_params.MCS(15).N_es = 1;
                wifi_params.MCS(15).MCS = 'MCS14';
                wifi_params.MCS(15).CR = 3/4;
                wifi_params.MCS(15).M = 64; % 64QAM
                wifi_params.MCS(15).N_cbps = 1296;
                wifi_params.MCS(15).N_dbps = 972;
                % MCS 15 -------------------------------------------------------------------
                wifi_params.MCS(16).N_ss = 2;
                wifi_params.MCS(16).N_es = 1;
                wifi_params.MCS(16).MCS = 'MCS15';
                wifi_params.MCS(16).CR = 5/6;
                wifi_params.MCS(16).M = 64; % 64QAM
                wifi_params.MCS(16).N_cbps = 1296;
                wifi_params.MCS(16).N_dbps = 1080;
                % MCS 16 -------------------------------------------------------------------
                wifi_params.MCS(17).N_ss = 3;
                wifi_params.MCS(17).N_es = 1;
                wifi_params.MCS(17).MCS = 'MCS16';
                wifi_params.MCS(17).CR = 1/2;
                wifi_params.MCS(17).M = 2; % BPSK
                wifi_params.MCS(17).N_cbps = 324;
                wifi_params.MCS(17).N_dbps = 162;
                % MCS 17 -------------------------------------------------------------------
                wifi_params.MCS(18).N_ss = 3;
                wifi_params.MCS(18).N_es = 1;
                wifi_params.MCS(18).MCS = 'MCS17';
                wifi_params.MCS(18).CR = 1/2;
                wifi_params.MCS(18).M = 4; % QPSK
                wifi_params.MCS(18).N_cbps = 648;
                wifi_params.MCS(18).N_dbps = 324;
                % MCS 18 -------------------------------------------------------------------
                wifi_params.MCS(19).N_ss = 3;
                wifi_params.MCS(19).N_es = 1;
                wifi_params.MCS(19).MCS = 'MCS18';
                wifi_params.MCS(19).CR = 3/4;
                wifi_params.MCS(19).M = 4; % QPSK
                wifi_params.MCS(19).N_cbps = 648;
                wifi_params.MCS(19).N_dbps = 486;
                % MCS 19 -------------------------------------------------------------------
                wifi_params.MCS(20).N_ss = 3;
                wifi_params.MCS(20).N_es = 1;
                wifi_params.MCS(20).MCS = 'MCS19';
                wifi_params.MCS(20).CR = 1/2;
                wifi_params.MCS(20).M = 16; % 16QAM
                wifi_params.MCS(20).N_cbps = 1296;
                wifi_params.MCS(20).N_dbps = 648;
                % MCS 20 -------------------------------------------------------------------
                wifi_params.MCS(21).N_ss = 3;
                wifi_params.MCS(21).N_es = 1;
                wifi_params.MCS(21).MCS = 'MCS20';
                wifi_params.MCS(21).CR = 3/4;
                wifi_params.MCS(21).M = 16; % 16QAM
                wifi_params.MCS(21).N_cbps = 1296;
                wifi_params.MCS(21).N_dbps = 972;
                % MCS 21 -------------------------------------------------------------------
                wifi_params.MCS(22).N_ss = 3;
                wifi_params.MCS(22).N_es = 2;
                wifi_params.MCS(22).MCS = 'MCS21';
                wifi_params.MCS(22).CR = 2/3;
                wifi_params.MCS(22).M = 64; % 64QAM
                wifi_params.MCS(22).N_cbps = 1944;
                wifi_params.MCS(22).N_dbps = 1296;
                % MCS 22 -------------------------------------------------------------------
                wifi_params.MCS(23).N_ss = 3;
                wifi_params.MCS(23).N_es = 2;
                wifi_params.MCS(23).MCS = 'MCS22';
                wifi_params.MCS(23).CR = 3/4;
                wifi_params.MCS(23).M = 64; % 64QAM
                wifi_params.MCS(23).N_cbps = 1944;
                wifi_params.MCS(23).N_dbps = 1458;
                % MCS 23 -------------------------------------------------------------------
                wifi_params.MCS(24).N_ss = 3;
                wifi_params.MCS(24).N_es = 2;
                wifi_params.MCS(24).MCS = 'MCS23';
                wifi_params.MCS(24).CR = 5/6;
                wifi_params.MCS(24).M = 64; % 64QAM
                wifi_params.MCS(24).N_cbps = 1944;
                wifi_params.MCS(24).N_dbps = 1620;
                % MCS 24 -------------------------------------------------------------------
                wifi_params.MCS(25).N_ss = 4;
                wifi_params.MCS(25).N_es = 1;
                wifi_params.MCS(25).MCS = 'MCS24';
                wifi_params.MCS(25).CR = 1/2;
                wifi_params.MCS(25).M = 2; % BPSK
                wifi_params.MCS(25).N_cbps = 216;
                wifi_params.MCS(25).N_dbps = 432;
                % MCS 25 -------------------------------------------------------------------
                wifi_params.MCS(26).N_ss = 4;
                wifi_params.MCS(26).N_es = 1;
                wifi_params.MCS(26).MCS = 'MCS25';
                wifi_params.MCS(26).CR = 1/2;
                wifi_params.MCS(26).M = 4; % QPSK
                wifi_params.MCS(26).N_cbps = 432;
                wifi_params.MCS(26).N_dbps = 864;
                % MCS 26 -------------------------------------------------------------------
                wifi_params.MCS(27).N_ss = 4;
                wifi_params.MCS(27).N_es = 1;
                wifi_params.MCS(27).MCS = 'MCS26';
                wifi_params.MCS(27).CR = 3/4;
                wifi_params.MCS(27).M = 4; % QPSK
                wifi_params.MCS(27).N_cbps = 648;
                wifi_params.MCS(27).N_dbps = 864;
                % MCS 27 -------------------------------------------------------------------
                wifi_params.MCS(28).N_ss = 4;
                wifi_params.MCS(28).N_es = 1;
                wifi_params.MCS(28).MCS = 'MCS27';
                wifi_params.MCS(28).CR = 1/2;
                wifi_params.MCS(28).M = 16; % 16QAM
                wifi_params.MCS(28).N_cbps = 1728;
                wifi_params.MCS(28).N_dbps = 864;
                % MCS 28 -------------------------------------------------------------------
                wifi_params.MCS(29).N_ss = 4;
                wifi_params.MCS(29).N_es = 2;
                wifi_params.MCS(29).MCS = 'MCS28';
                wifi_params.MCS(29).CR = 3/4;
                wifi_params.MCS(29).M = 16; % 16QAM
                wifi_params.MCS(29).N_cbps = 1728;
                wifi_params.MCS(29).N_dbps = 1296;
                % MCS 29 -------------------------------------------------------------------
                wifi_params.MCS(30).N_ss = 4;
                wifi_params.MCS(30).N_es = 2;
                wifi_params.MCS(30).MCS = 'MCS29';
                wifi_params.MCS(30).CR = 2/3;
                wifi_params.MCS(30).M = 64; % 64QAM
                wifi_params.MCS(30).N_cbps = 2592;
                wifi_params.MCS(30).N_dbps = 1728;
                % MCS 30 -------------------------------------------------------------------
                wifi_params.MCS(31).N_ss = 4;
                wifi_params.MCS(31).N_es = 2;
                wifi_params.MCS(31).MCS = 'MCS30';
                wifi_params.MCS(31).CR = 3/4;
                wifi_params.MCS(31).M = 64; % 64QAM
                wifi_params.MCS(31).N_cbps = 2592;
                wifi_params.MCS(31).N_dbps = 1944;
                % MCS 31 -------------------------------------------------------------------
                wifi_params.MCS(32).N_ss = 3;
                wifi_params.MCS(32).N_es = 2;
                wifi_params.MCS(32).MCS = 'MCS31';
                wifi_params.MCS(32).CR = 5/6;
                wifi_params.MCS(32).M = 64; % 64QAM
                wifi_params.MCS(32).N_cbps = 2592;
                wifi_params.MCS(32).N_dbps = 2160;
                % MCS 32 -------------------------------------------------------------------
                wifi_params.MCS(33).N_ss = 1;
                wifi_params.MCS(33).N_es = 1;
                wifi_params.MCS(33).MCS = 'MCS32';
                wifi_params.MCS(33).CR = 1/2;
                wifi_params.MCS(33).M = 2; % BPSK
                wifi_params.MCS(33).N_cbps = 48;
                wifi_params.MCS(33).N_dbps = 24;
                % MCS 33 -------------------------------------------------------------------
                wifi_params.MCS(34).N_ss = 2;
                wifi_params.MCS(34).N_es = 1;
                wifi_params.MCS(34).MCS = 'MCS33';
                wifi_params.MCS(34).CR = 1/2;
                wifi_params.MCS(34).M = [16 4]; % 16QAM and QPSK
                wifi_params.MCS(34).N_cbps = 312;
                wifi_params.MCS(34).N_dbps = 156;
                % MCS 34 -------------------------------------------------------------------
                wifi_params.MCS(35).N_ss = 2;
                wifi_params.MCS(35).N_es = 1;
                wifi_params.MCS(35).MCS = 'MCS34';
                wifi_params.MCS(35).CR = 1/2;
                wifi_params.MCS(35).M = [64 4]; % 64QAM and QPSK
                wifi_params.MCS(35).N_cbps = 416;
                wifi_params.MCS(35).N_dbps = 208;
                % MCS 35 -------------------------------------------------------------------
                wifi_params.MCS(36).N_ss = 2;
                wifi_params.MCS(36).N_es = 1;
                wifi_params.MCS(36).MCS = 'MCS35';
                wifi_params.MCS(36).CR = 1/2;
                wifi_params.MCS(36).M = [64 16]; % 64QAM and 16QAM
                wifi_params.MCS(36).N_cbps = 520;
                wifi_params.MCS(36).N_dbps = 260;
                % MCS 36 -------------------------------------------------------------------
                wifi_params.MCS(37).N_ss = 2;
                wifi_params.MCS(37).N_es = 1;
                wifi_params.MCS(37).MCS = 'MCS36';
                wifi_params.MCS(37).CR = 3/4;
                wifi_params.MCS(37).M = [16 4]; % 16QAM and QPSK
                wifi_params.MCS(37).N_cbps = 312;
                wifi_params.MCS(37).N_dbps = 234;
                % MCS 37 -------------------------------------------------------------------
                wifi_params.MCS(38).N_ss = 2;
                wifi_params.MCS(38).N_es = 1;
                wifi_params.MCS(38).MCS = 'MCS37';
                wifi_params.MCS(38).CR = 3/4;
                wifi_params.MCS(38).M = [64 4]; % 64QAM and QPSK
                wifi_params.MCS(38).N_cbps = 416;
                wifi_params.MCS(38).N_dbps = 312;
                % MCS 38 -------------------------------------------------------------------
                wifi_params.MCS(39).N_ss = 2;
                wifi_params.MCS(39).N_es = 1;
                wifi_params.MCS(39).MCS = 'MCS38';
                wifi_params.MCS(39).CR = 3/4;
                wifi_params.MCS(39).M = [64 16]; % 64QAM and 16QAM
                wifi_params.MCS(39).N_cbps = 520;
                wifi_params.MCS(39).N_dbps = 390;
        end
    case '802dot11ac'
        wifi_params.general.PHYlayer = 'OFDM';
        switch ChannelBandwidth
            case 20
                % MCS 0 -------------------------------------------------------------------
                wifi_params.MCS(1).N_ss = 1; % Nss number of spatial streams
                wifi_params.MCS(1).N_es = 1; % Nes number of BCC encoders for the DATA field
                wifi_params.MCS(1).MCS = 'MCS0';
                wifi_params.MCS(1).CR = 1/2;
                wifi_params.MCS(1).M = 2; % BPSK
                wifi_params.MCS(1).N_cbps = 52;
                wifi_params.MCS(1).N_dbps = 26;
                % MCS 1 -------------------------------------------------------------------
                wifi_params.MCS(2).N_ss = 1;
                wifi_params.MCS(2).N_es = 1;
                wifi_params.MCS(2).MCS = 'MCS1';
                wifi_params.MCS(2).CR = 1/2;
                wifi_params.MCS(2).M = 4; % QPSK
                wifi_params.MCS(2).N_cbps = 104;
                wifi_params.MCS(2).N_dbps = 52;
                % MCS 2 -------------------------------------------------------------------
                wifi_params.MCS(3).N_ss = 1;
                wifi_params.MCS(3).N_es = 1;
                wifi_params.MCS(3).MCS = 'MCS2';
                wifi_params.MCS(3).CR = 3/4;
                wifi_params.MCS(3).M = 4; % QPSK
                wifi_params.MCS(3).N_cbps = 104;
                wifi_params.MCS(3).N_dbps = 78;
                % MCS 3 -------------------------------------------------------------------
                wifi_params.MCS(4).N_ss = 1;
                wifi_params.MCS(4).N_es = 1;
                wifi_params.MCS(4).MCS = 'MCS3';
                wifi_params.MCS(4).CR = 1/2;
                wifi_params.MCS(4).M = 16; % 16QAM
                wifi_params.MCS(4).N_cbps = 208;
                wifi_params.MCS(4).N_dbps = 104;
                % MCS 4 ---------------------------------------------------
                wifi_params.MCS(5).N_ss = 1;
                wifi_params.MCS(5).N_es = 1;
                wifi_params.MCS(5).MCS = 'MCS4';
                wifi_params.MCS(5).CR = 3/4;
                wifi_params.MCS(5).M = 16; % 16QAM
                wifi_params.MCS(5).N_cbps = 208;
                wifi_params.MCS(5).N_dbps = 156;
                % MCS 5 -------------------------------------------------------------------
                wifi_params.MCS(6).N_ss = 1;
                wifi_params.MCS(6).N_es = 1;
                wifi_params.MCS(6).MCS = 'MCS5';
                wifi_params.MCS(6).CR = 2/3;
                wifi_params.MCS(6).M = 64; % 64QAM
                wifi_params.MCS(6).N_cbps = 312;
                wifi_params.MCS(6).N_dbps = 208;
                % MCS 6 -------------------------------------------------------------------
                wifi_params.MCS(7).N_ss = 1;
                wifi_params.MCS(7).N_es = 1;
                wifi_params.MCS(7).MCS = 'MCS6';
                wifi_params.MCS(7).CR = 3/4;
                wifi_params.MCS(7).M = 64; % 64QAM
                wifi_params.MCS(7).N_cbps = 312;
                wifi_params.MCS(7).N_dbps = 234;
                % MCS 7 -------------------------------------------------------------------
                wifi_params.MCS(8).N_ss = 1;
                wifi_params.MCS(8).N_es = 1;
                wifi_params.MCS(8).MCS = 'MCS7';
                wifi_params.MCS(8).CR = 5/6;
                wifi_params.MCS(8).M = 64; % 64QAM
                wifi_params.MCS(8).N_cbps = 312;
                wifi_params.MCS(8).N_dbps = 260;
                % MCS 8 -------------------------------------------------------------------
                wifi_params.MCS(9).N_ss = 1;
                wifi_params.MCS(9).N_es = 1;
                wifi_params.MCS(9).MCS = 'MCS8';
                wifi_params.MCS(9).CR = 3/4;
                wifi_params.MCS(9).M = 256; % 256QAM
                wifi_params.MCS(9).N_cbps = 416;
                wifi_params.MCS(9).N_dbps = 312;
            otherwise
                error('IEEE 802.11ac is not defined completely, excepting CBW_20 mode')
        end
    case '802dot11af'
        wifi_params.general.PHYlayer = 'OFDM';
    case '802dot11ah'
        wifi_params.general.PHYlayer = 'OFDM';
          switch ChannelBandwidth
            case 1
                % MCS 0 -------------------------------------------------------------------
                wifi_params.MCS(1).N_ss = 1; % Nss number of spatial streams
                wifi_params.MCS(1).N_es = 1; % Nes number of BCC encoders for the DATA field
                wifi_params.MCS(1).MCS = 'MCS0';
                wifi_params.MCS(1).CR = 1/2;
                wifi_params.MCS(1).M = 2; % BPSK
                wifi_params.MCS(1).N_cbps = 24;
                wifi_params.MCS(1).N_dbps = 12;
                % MCS 1 -------------------------------------------------------------------
                wifi_params.MCS(2).N_ss = 1;
                wifi_params.MCS(2).N_es = 1;
                wifi_params.MCS(2).MCS = 'MCS1';
                wifi_params.MCS(2).CR = 1/2;
                wifi_params.MCS(2).M = 4; % QPSK
                wifi_params.MCS(2).N_cbps = 48;
                wifi_params.MCS(2).N_dbps = 24;
                % MCS 2 -------------------------------------------------------------------
                wifi_params.MCS(3).N_ss = 1;
                wifi_params.MCS(3).N_es = 1;
                wifi_params.MCS(3).MCS = 'MCS2';
                wifi_params.MCS(3).CR = 3/4;
                wifi_params.MCS(3).M = 4; % QPSK
                wifi_params.MCS(3).N_cbps = 48;
                wifi_params.MCS(3).N_dbps = 36;
                % MCS 3 -------------------------------------------------------------------
                wifi_params.MCS(4).N_ss = 1;
                wifi_params.MCS(4).N_es = 1;
                wifi_params.MCS(4).MCS = 'MCS3';
                wifi_params.MCS(4).CR = 1/2;
                wifi_params.MCS(4).M = 16; % 16QAM
                wifi_params.MCS(4).N_cbps = 96;
                wifi_params.MCS(4).N_dbps = 48;
                % MCS 4 -------------------------------------------------------------------
                wifi_params.MCS(5).N_ss = 1;
                wifi_params.MCS(5).N_es = 1;
                wifi_params.MCS(5).MCS = 'MCS4';
                wifi_params.MCS(5).CR = 3/4;
                wifi_params.MCS(5).M = 16; % 16QAM
                wifi_params.MCS(5).N_cbps = 96;
                wifi_params.MCS(5).N_dbps = 72;
                % MCS 5 -------------------------------------------------------------------
                wifi_params.MCS(6).N_ss = 1;
                wifi_params.MCS(6).N_es = 1;
                wifi_params.MCS(6).MCS = 'MCS5';
                wifi_params.MCS(6).CR = 2/3;
                wifi_params.MCS(6).M = 64; % 64QAM
                wifi_params.MCS(6).N_cbps = 144;
                wifi_params.MCS(6).N_dbps = 96;
                % MCS 6 -------------------------------------------------------------------
                wifi_params.MCS(7).N_ss = 1;
                wifi_params.MCS(7).N_es = 1;
                wifi_params.MCS(7).MCS = 'MCS6';
                wifi_params.MCS(7).CR = 3/4;
                wifi_params.MCS(7).M = 64; % 64QAM
                wifi_params.MCS(7).N_cbps = 144;
                wifi_params.MCS(7).N_dbps = 108;
                % MCS 7 -------------------------------------------------------------------
                wifi_params.MCS(8).N_ss = 1;
                wifi_params.MCS(8).N_es = 1;
                wifi_params.MCS(8).MCS = 'MCS7';
                wifi_params.MCS(8).CR = 5/6;
                wifi_params.MCS(8).M = 64; % 64QAM
                wifi_params.MCS(8).N_cbps = 144;
                wifi_params.MCS(8).N_dbps = 120;
                % MCS 8 -------------------------------------------------------------------
                wifi_params.MCS(9).N_ss = 1;
                wifi_params.MCS(9).N_es = 1;
                wifi_params.MCS(9).MCS = 'MCS8';
                wifi_params.MCS(9).CR = 3/4;
                wifi_params.MCS(9).M = 256; % 256QAM
                wifi_params.MCS(9).N_cbps = 192;
                wifi_params.MCS(9).N_dbps = 144;
                % MCS 9 -------------------------------------------------------------------
                wifi_params.MCS(10).N_ss = 1;
                wifi_params.MCS(10).N_es = 1;
                wifi_params.MCS(10).MCS = 'MCS9';
                wifi_params.MCS(10).CR = 5/6;
                wifi_params.MCS(10).M = 256; % 256QAM
                wifi_params.MCS(10).N_cbps = 192;
                wifi_params.MCS(10).N_dbps = 160;
                % MCS 10 (repetition coding) ----------------------------------------------
                wifi_params.MCS(11).N_ss = 1;
                wifi_params.MCS(11).N_es = 1;
                wifi_params.MCS(11).MCS = 'MCS10';
                wifi_params.MCS(11).CR = 1/2;
                wifi_params.MCS(11).M = 2; % BPSK
                wifi_params.MCS(11).N_cbps = 24;
                wifi_params.MCS(11).N_dbps = 6;
              case 2
                % MCS 0 -------------------------------------------------------------------
                wifi_params.MCS(1).N_ss = 1; % Nss number of spatial streams
                wifi_params.MCS(1).N_es = 1; % Nes number of BCC encoders for the DATA field
                wifi_params.MCS(1).MCS = 'MCS0';
                wifi_params.MCS(1).CR = 1/2;
                wifi_params.MCS(1).M = 2; % BPSK
                wifi_params.MCS(1).N_cbps = 52;
                wifi_params.MCS(1).N_dbps = 26;
                % MCS 1 -------------------------------------------------------------------
                wifi_params.MCS(2).N_ss = 1;
                wifi_params.MCS(2).N_es = 1;
                wifi_params.MCS(2).MCS = 'MCS1';
                wifi_params.MCS(2).CR = 1/2;
                wifi_params.MCS(2).M = 4; % QPSK
                wifi_params.MCS(2).N_cbps = 104;
                wifi_params.MCS(2).N_dbps = 52;
                % MCS 2 -------------------------------------------------------------------
                wifi_params.MCS(3).N_ss = 1;
                wifi_params.MCS(3).N_es = 1;
                wifi_params.MCS(3).MCS = 'MCS2';
                wifi_params.MCS(3).CR = 3/4;
                wifi_params.MCS(3).M = 4; % QPSK
                wifi_params.MCS(3).N_cbps = 104;
                wifi_params.MCS(3).N_dbps = 78;
                % MCS 3 -------------------------------------------------------------------
                wifi_params.MCS(4).N_ss = 1;
                wifi_params.MCS(4).N_es = 1;
                wifi_params.MCS(4).MCS = 'MCS3';
                wifi_params.MCS(4).CR = 1/2;
                wifi_params.MCS(4).M = 16; % 16QAM
                wifi_params.MCS(4).N_cbps = 208;
                wifi_params.MCS(4).N_dbps = 104;
                % MCS 4 -------------------------------------------------------------------
                wifi_params.MCS(5).N_ss = 1;
                wifi_params.MCS(5).N_es = 1;
                wifi_params.MCS(5).MCS = 'MCS4';
                wifi_params.MCS(5).CR = 3/4;
                wifi_params.MCS(5).M = 16; % 16QAM
                wifi_params.MCS(5).N_cbps = 208;
                wifi_params.MCS(5).N_dbps = 156;
                % MCS 5 -------------------------------------------------------------------
                wifi_params.MCS(6).N_ss = 1;
                wifi_params.MCS(6).N_es = 1;
                wifi_params.MCS(6).MCS = 'MCS5';
                wifi_params.MCS(6).CR = 2/3;
                wifi_params.MCS(6).M = 64; % 64QAM
                wifi_params.MCS(6).N_cbps = 312;
                wifi_params.MCS(6).N_dbps = 208;
                % MCS 6 -------------------------------------------------------------------
                wifi_params.MCS(7).N_ss = 1;
                wifi_params.MCS(7).N_es = 1;
                wifi_params.MCS(7).MCS = 'MCS6';
                wifi_params.MCS(7).CR = 3/4;
                wifi_params.MCS(7).M = 64; % 64QAM
                wifi_params.MCS(7).N_cbps = 312;
                wifi_params.MCS(7).N_dbps = 234;
                % MCS 7 -------------------------------------------------------------------
                wifi_params.MCS(8).N_ss = 1;
                wifi_params.MCS(8).N_es = 1;
                wifi_params.MCS(8).MCS = 'MCS7';
                wifi_params.MCS(8).CR = 5/6;
                wifi_params.MCS(8).M = 64; % 64QAM
                wifi_params.MCS(8).N_cbps = 312;
                wifi_params.MCS(8).N_dbps = 260;
                % MCS 8 -------------------------------------------------------------------
                wifi_params.MCS(9).N_ss = 1;
                wifi_params.MCS(9).N_es = 1;
                wifi_params.MCS(9).MCS = 'MCS8';
                wifi_params.MCS(9).CR = 3/4;
                wifi_params.MCS(9).M = 256; % 256QAM
                wifi_params.MCS(9).N_cbps = 416;
                wifi_params.MCS(9).N_dbps = 312;
              otherwise
                error('IEEE 802.11ah is not defined completely, excepting 1 and 2 MHz system bandwidth')
          end
    case '802dot11ax'
        wifi_params.general.PHYlayer = 'OFDM';
        % MCS 0 -------------------------------------------------------------------
        wifi_params.MCS(1).N_ss = 1; % Nss number of spatial streams
        wifi_params.MCS(1).N_es = 1; % Nes number of BCC encoders for the DATA field
        wifi_params.MCS(1).MCS = 'MCS0';
        wifi_params.MCS(1).CR = 1/2;
        wifi_params.MCS(1).M = 2; % BPSK
        wifi_params.MCS(1).N_cbps = 234;
        wifi_params.MCS(1).N_dbps = 117;
        % MCS 1 -------------------------------------------------------------------
        wifi_params.MCS(2).N_ss = 1;
        wifi_params.MCS(2).N_es = 1;
        wifi_params.MCS(2).MCS = 'MCS1';
        wifi_params.MCS(2).CR = 1/2;
        wifi_params.MCS(2).M = 4; % QPSK
        wifi_params.MCS(2).N_cbps = 468;
        wifi_params.MCS(2).N_dbps = 234;
        % MCS 2 -------------------------------------------------------------------
        wifi_params.MCS(3).N_ss = 1;
        wifi_params.MCS(3).N_es = 1;
        wifi_params.MCS(3).MCS = 'MCS2';
        wifi_params.MCS(3).CR = 3/4;
        wifi_params.MCS(3).M = 4; % QPSK
        wifi_params.MCS(3).N_cbps = 468;
        wifi_params.MCS(3).N_dbps = 351;
        % MCS 3 -------------------------------------------------------------------
        wifi_params.MCS(4).N_ss = 1;
        wifi_params.MCS(4).N_es = 1;
        wifi_params.MCS(4).MCS = 'MCS3';
        wifi_params.MCS(4).CR = 1/2;
        wifi_params.MCS(4).M = 16; % 16QAM
        wifi_params.MCS(4).N_cbps = 936;
        wifi_params.MCS(4).N_dbps = 468;
        % MCS 4 ---------------------------------------------------
        wifi_params.MCS(5).N_ss = 1;
        wifi_params.MCS(5).N_es = 1;
        wifi_params.MCS(5).MCS = 'MCS4';
        wifi_params.MCS(5).CR = 3/4;
        wifi_params.MCS(5).M = 16; % 16QAM
        wifi_params.MCS(5).N_cbps = 936;
        wifi_params.MCS(5).N_dbps = 702;
        % MCS 5 -------------------------------------------------------------------
        wifi_params.MCS(6).N_ss = 1;
        wifi_params.MCS(6).N_es = 1;
        wifi_params.MCS(6).MCS = 'MCS5';
        wifi_params.MCS(6).CR = 2/3;
        wifi_params.MCS(6).M = 64; % 64QAM
        wifi_params.MCS(6).N_cbps = 1404;
        wifi_params.MCS(6).N_dbps = 936;
        % MCS 6 -------------------------------------------------------------------
        wifi_params.MCS(7).N_ss = 1;
        wifi_params.MCS(7).N_es = 1;
        wifi_params.MCS(7).MCS = 'MCS6';
        wifi_params.MCS(7).CR = 3/4;
        wifi_params.MCS(7).M = 64; % 64QAM
        wifi_params.MCS(7).N_cbps = 1404;
        wifi_params.MCS(7).N_dbps = 1053;
        % MCS 7 -------------------------------------------------------------------
        wifi_params.MCS(8).N_ss = 1;
        wifi_params.MCS(8).N_es = 1;
        wifi_params.MCS(8).MCS = 'MCS7';
        wifi_params.MCS(8).CR = 5/6;
        wifi_params.MCS(8).M = 64; % 64QAM
        wifi_params.MCS(8).N_cbps = 1404;
        wifi_params.MCS(8).N_dbps = 1170;
        % MCS 8 -------------------------------------------------------------------
        wifi_params.MCS(9).N_ss = 1;
        wifi_params.MCS(9).N_es = 1;
        wifi_params.MCS(9).MCS = 'MCS8';
        wifi_params.MCS(9).CR = 3/4;
        wifi_params.MCS(9).M = 256; % 256QAM
        wifi_params.MCS(9).N_cbps = 1872;
        wifi_params.MCS(9).N_dbps = 1404;
        % MCS 9 -------------------------------------------------------------------
        wifi_params.MCS(10).N_ss = 1;
        wifi_params.MCS(10).N_es = 1;
        wifi_params.MCS(10).MCS = 'MCS9';
        wifi_params.MCS(10).CR = 5/6;
        wifi_params.MCS(10).M = 256; % 256QAM
        wifi_params.MCS(10).N_cbps = 1872;
        wifi_params.MCS(10).N_dbps = 1560;
        % MCS 10 -------------------------------------------------------------------
        wifi_params.MCS(11).N_ss = 1;
        wifi_params.MCS(11).N_es = 1;
        wifi_params.MCS(11).MCS = 'MCS10';
        wifi_params.MCS(11).CR = 3/4;
        wifi_params.MCS(11).M = 1024; % 1024QAM
        wifi_params.MCS(11).N_cbps = 2340;
        wifi_params.MCS(11).N_dbps = 1755;
        % MCS 11 -------------------------------------------------------------------
        wifi_params.MCS(12).N_ss = 1;
        wifi_params.MCS(12).N_es = 1;
        wifi_params.MCS(12).MCS = 'MCS11';
        wifi_params.MCS(12).CR = 5/6;
        wifi_params.MCS(12).M = 1024; % 1024QAM
        wifi_params.MCS(12).N_cbps = 2340;
        wifi_params.MCS(12).N_dbps = 1950;
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
        warning('Check in future (see load_wifi_params.m, line 260)');
    otherwise
        error('Undefined IEEE 802.11 standard (see load_wifi_params.m)');
end

