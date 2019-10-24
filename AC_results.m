%% IEEE 802.11ac performance results visualisation
%
% Authors:	Jiri Milos and Ladislav Polak, DREL FEEC BUT, 2018
%

close all
clear all
clc

%% Define parameters
commonDirectory = '.\results\AC\';
filenameAC_20MHz_LDPC = {...
    'wifi_802dot11ac_BW20_MHz_from-10to30_dB_LDPC_LLR_MCS0_LENGTH05000_shortCP_50_repeat_2018-11-05_004314.mat';
    };

filenameAC_20MHz_BCC = {...
    'wifi_802dot11ac_BW20_MHz_from-10to30_dB_BCC_LLR_MCS0_LENGTH05000_shortCP_50_repeat_2018-11-05_181334.mat';
    };

%% Visualize BER and throughput
figure(1);

for i_plot = 1:length(filenameAC_20MHz_LDPC)
    load(fullfile([commonDirectory, filenameAC_20MHz_LDPC{i_plot}]));
    
    subplot(121)
    semilogy(SNR,results.ber_coded_data)
    hold on
    
    subplot(122)
    plot(SNR,results.throughput_coded_data)
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
title('IEEE 802.11ac')

subplot(122)
yorder = numorder(max(maxThr));
maxy = 10^(yorder+1);
axis([SNR(1) SNR(end) 0 maxy])
grid on
xlabel('SNR [dB]')
ylabel('Throughput [bps]')
legend(legendF1, 'Location', 'NorthWest')
title('BW = 20 MHz | LDPC')

figure(2);

for i_plot = 1:length(filenameAC_20MHz_BCC)
    load(fullfile([commonDirectory, filenameAC_20MHz_BCC{i_plot}]));
    
    subplot(121)
    semilogy(SNR,results.ber_coded_data)
    hold on
    
    subplot(122)
    plot(SNR,results.throughput_coded_data)
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
title('IEEE 802.11ac')

subplot(122)
yorder = numorder(max(maxThr));
maxy = 10^(yorder+1);
axis([SNR(1) SNR(end) 0 maxy])
grid on
xlabel('SNR [dB]')
ylabel('Throughput [bps]')
legend(legendF1, 'Location', 'NorthWest')
title('BW = 20 MHz | BCC')

