% present results for norcas 2019
% 13.8.2019
% Jiri Milos
close all
clearvars
clc

slozka = 'D:\ownCloud\_Projekty\COST_FEWERCON2\_NORCAS\WIFI sim JB posledni release';
podslozka = 'results';

filenames1 = {...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS1_LENGTH00500_100_repeat_2019-08-12_123716.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS2_LENGTH00500_100_repeat_2019-08-12_133818.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS3_LENGTH00500_100_repeat_2019-08-12_142941.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS4_LENGTH00500_100_repeat_2019-08-12_151208.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS5_LENGTH00500_100_repeat_2019-08-12_155439.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS6_LENGTH00500_100_repeat_2019-08-12_163136.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS7_LENGTH00500_100_repeat_2019-08-12_170459.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS8_LENGTH00500_100_repeat_2019-08-12_173146.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS9_LENGTH00500_100_repeat_2019-08-12_175843.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS9.1_LENGTH00500_100_repeat_2019-08-12_182556.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS10_LENGTH00500_100_repeat_2019-08-12_185326.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS11_LENGTH00500_100_repeat_2019-08-12_191656.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS12_LENGTH00500_100_repeat_2019-08-12_193623.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS12.1_LENGTH00500_100_repeat_2019-08-12_195555.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS12.2_LENGTH00500_100_repeat_2019-08-12_201549.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS12.3_LENGTH00500_100_repeat_2019-08-12_203846.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS12.4_LENGTH00500_100_repeat_2019-08-12_205655.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS12.5_LENGTH00500_100_repeat_2019-08-12_211512.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-10to25_dB_LDPC_LLR_MCS12.6_LENGTH00500_100_repeat_2019-08-12_213350.mat'};

filenames2 = {...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS1_LENGTH00500_100_repeat_2019-08-13_092129.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS2_LENGTH00500_100_repeat_2019-08-13_100426.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS3_LENGTH00500_100_repeat_2019-08-13_104111.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS4_LENGTH00500_100_repeat_2019-08-13_111135.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS5_LENGTH00500_100_repeat_2019-08-13_114201.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS6_LENGTH00500_100_repeat_2019-08-13_120830.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS7_LENGTH00500_100_repeat_2019-08-13_123157.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS8_LENGTH00500_100_repeat_2019-08-13_125039.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS9_LENGTH00500_100_repeat_2019-08-13_130925.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS9.1_LENGTH00500_100_repeat_2019-08-13_132826.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS10_LENGTH00500_100_repeat_2019-08-13_134749.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS11_LENGTH00500_100_repeat_2019-08-13_140432.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS12_LENGTH00500_100_repeat_2019-08-13_141828.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS12.1_LENGTH00500_100_repeat_2019-08-13_143229.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS12.2_LENGTH00500_100_repeat_2019-08-13_144634.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS12.3_LENGTH00500_100_repeat_2019-08-13_150252.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS12.4_LENGTH00500_100_repeat_2019-08-13_151551.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS12.5_LENGTH00500_100_repeat_2019-08-13_152859.mat';...
    'wifi_802dot11ad_BW2640_MHz_from-4.500000e+00to1.950000e+01_dB_LDPC_LLR_MCS12.6_LENGTH00500_100_repeat_2019-08-13_154223.mat'};

[m1, n1] = size(filenames1);
[m2, n2] = size(filenames2);

if m1 ~= m2
    error('Results are incomplete...');
end

lineWidth = 1;
for i = 1:m1
    load(fullfile(slozka, podslozka, filenames1{i}));
    SNR1_tmp = SNR;
    ber_coded_data1_tmp = results.ber_coded_data;
    fer_frames_PSDU1_tmp = results.fer_frames_PSDU;
    thr_coded_data1_tmp = results.throughput_coded_data;
    
    load(fullfile(slozka, podslozka, filenames2{i}));
    SNR2_tmp = SNR;
    ber_coded_data2_tmp = results.ber_coded_data;
    fer_frames_PSDU2_tmp = results.fer_frames_PSDU;
    thr_coded_data2_tmp = results.throughput_coded_data;
    
    SNR_tmp = [SNR1_tmp, SNR2_tmp];
    ber_coded_data_tmp = [ber_coded_data1_tmp, ber_coded_data2_tmp];
    fer_frames_PSDU_tmp = [fer_frames_PSDU1_tmp, fer_frames_PSDU2_tmp];
    thr_coded_data_tmp = [thr_coded_data1_tmp, thr_coded_data2_tmp];
    
    [SNR, Ix] = sort(SNR_tmp);
    %     ber_coded_data = zeros(size(SNR));
    ber_coded_data = ber_coded_data_tmp(Ix);
    
    %     fer_frames_PSDU = zeros(size(SNR));
    fer_frames_PSDU = fer_frames_PSDU_tmp(Ix);
    
    %     thr_coded_data = zeros(size(SNR));
    thr_coded_data = thr_coded_data_tmp(Ix);
    
    
    figure(1);
    h1(i) = semilogy(SNR,ber_coded_data,'LineWidth',lineWidth);
    hold all, grid on
    
    figure(2);
    h2(i) = semilogy(SNR,fer_frames_PSDU,'LineWidth',lineWidth);
    hold all, grid on
    
    figure(3);
    h3(i) = plot(SNR, thr_coded_data,'LineWidth',lineWidth);
    hold all, grid on
    
    strFile = filenames1{i};
    is1 = strfind(strFile, 'MCS');
    is2 = strfind(strFile, '_LENGTH');
    mcsNum = strFile(is1+3:is2-1);
    
    legendEntry{i} = [mcsNum];
    
end

legendEntry;

fontSize = 12;

figure(1)
ylim([1e-3 1e0])
xlim([-5 25])
xlabel('SNR [dB]','FontSize', fontSize)
ylabel('BER [-]','FontSize', fontSize)
set(gca,'FontSize',fontSize-1)
% lgd1 = legend(legendEntry,'Position',[0.85 0.47 0.1 0.2]);
lgd1 = legend(legendEntry,'Location','northeast');
% lgd1.Title.String = 'MCS';
f1name = 'ber_norcas';
print(f1name,'-depsc')
system(['epstopdf ', f1name, '.eps'])

figure(2)
ylim([1e-1 1e0])
xlim([-5 25])
xlabel('SNR [dB]','FontSize', fontSize)
ylabel('FER [-]','FontSize', fontSize)
set(gca,'FontSize',fontSize-1)
% legend(legendEntry,'Position',[0.85 0.5 0.1 0.2])
legend(legendEntry,'Location','northeast')
f2name = 'fer_norcas';
print(f2name,'-depsc')
system(['epstopdf ', f2name, '.eps'])


figure(3)
xlim([-5 25])
xlabel('SNR [dB]','FontSize', fontSize)
ylabel('Throughput [bps]','FontSize', fontSize)
set(gca,'FontSize',fontSize-1)
legend(legendEntry,'Location','northwest')
f3name = 'thr_norcas';
print(f3name,'-depsc')
system(['epstopdf ', f3name, '.eps'])


