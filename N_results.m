%% IEEE 802.11n performance results visualisation
%
% Authors:	Jiri Milos and Ladislav Polak, DREL FEEC BUT, 2018
%

close all
clear all
clc

%% Define parameters
commonDirectory = '.\results\G_N\';
filenameN_20MHz_BCC = {...
    'wifi_802dot11n_BW20_MHz_from-10to30_dB_BCC_LLR_MCS0_LENGTH01000_normalCP_50_repeat_2018-11-05_173957.mat';
    'wifi_802dot11n_BW20_MHz_from-10to30_dB_BCC_LLR_MCS1_LENGTH01000_normalCP_50_repeat_2018-11-05_174146.mat';
    'wifi_802dot11n_BW20_MHz_from-10to30_dB_BCC_LLR_MCS2_LENGTH01000_normalCP_50_repeat_2018-11-05_174324.mat';
    'wifi_802dot11n_BW20_MHz_from-10to30_dB_BCC_LLR_MCS3_LENGTH01000_normalCP_50_repeat_2018-11-05_174514.mat';
    'wifi_802dot11n_BW20_MHz_from-10to30_dB_BCC_LLR_MCS4_LENGTH01000_normalCP_50_repeat_2018-11-05_174656.mat';
    'wifi_802dot11n_BW20_MHz_from-10to30_dB_BCC_LLR_MCS5_LENGTH01000_normalCP_50_repeat_2018-11-05_174904.mat';
    'wifi_802dot11n_BW20_MHz_from-10to30_dB_BCC_LLR_MCS6_LENGTH01000_normalCP_50_repeat_2018-11-05_175111.mat';
    'wifi_802dot11n_BW20_MHz_from-10to30_dB_BCC_LLR_MCS7_LENGTH01000_normalCP_50_repeat_2018-11-05_175310.mat'
    };
%% Visualize BER and throughput
figure(1);

for i_plot = 1:length(filenameN_20MHz_BCC)
    load(fullfile([commonDirectory, filenameN_20MHz_BCC{i_plot}]));
    
    subplot(121)
    semilogy(SNR,results.ber_coded_data,'LineWidth',1.5)
    hold on
    
    subplot(122)
    plot(SNR,results.throughput_coded_data,'LineWidth',1.5)
    hold on
    
    maxThr(i_plot) = max(results.throughput_coded_data);
    legendF1{i_plot} = ['MCS', num2str(i_plot-1)];
end

subplot(121)
axis([SNR(1) SNR(end) 10^(-4) 1])
grid on
xlabel('SNR [dB]')
ylabel('BER [-]')
legend(legendF1, 'Location', 'SouthWest')
title('IEEE 802.11n')

subplot(122)
yorder = numorder(max(maxThr));
maxy = 10^(yorder+1);
axis([SNR(1) SNR(end) 0 maxy])
grid on
xlabel('SNR [dB]')
ylabel('Throughput [bps]')
legend(legendF1, 'Location', 'NorthWest')
title('BW = 20 MHz | BCC')
