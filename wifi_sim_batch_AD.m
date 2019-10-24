%% Performance Analysis of IEEE 802.11 WLAN Technologies
% main simulation batch file; modifications are possible
%
% Authors:	Jiri Milos and Ladislav Polak, DREL FEEC BUT, 2018 and 2019
%

close all
clearvars;
clear global
clc

% cd('D:\ownCloud\_Projekty\COST_FEWERCON2\_NORCAS\WIFI sim JB posledni release')
% addpath('D:\ownCloud\_Projekty\COST_FEWERCON2\_NORCAS\WIFI sim JB posledni release')

global DEBUG_MODE;
DEBUG_MODE = false;

saveResults = false;
%% Define simulation parameters ----------------------------------------
wifi_standard = '802dot11ad'; % single carrier (SC) physical layer

ChannelBandwidth = [2640]; % [MHz]

UserMode = 'single'; % Not adjustable
MIMO_mode = 'SISO'; % Not adjustable

GuardInterval = 'normal'; % Not adjustable for SC
coding_type = 'LDPC'; % 'LDPC' encoding is mandatory for SC mode

decision_type = 'LLR'; %'HD' - Hard decision values; 'LLR' - Log-likelihood ratio(LLR);

LENGTH = 500; % user data octet length (1--262144)

MCSvec = 'all'; %[12.2:0.1:12.6]; % individual MCS types or string 'all'
MCSvec = 8;
channelType = 'fad_meas'; % 'awgn' , 'fad' or 'fad_meas'
SNR = -10:1:15;

N_frames = 5; % number of frames within inner loop (for each SNR value)
n_users = [1 1]; % [AP STA] tx always set to 1

% necessary MCS definition and MCS vector indices definition
mcs_definition;

for i_mcs = i_mcs_vec_aux % mcs loop
    tic;
    % simulation parameters
    load_wifi_params;
    
    % preallocate result variables
    results = result_allocation(SNR,N_frames,wifi_params);
    % main simulation file
    sim_file;
    
    % save results for each MCS
    results = result_all(results);
    % generate results filename
    output_filename = load_filename(SNR,N_frames,i_mcs,wifi_params,wifi_standard, ChannelBandwidth, coding_type, LENGTH, GuardInterval, decision_type);
    filename_suffix = [];
    if saveResults == 1
        save(fullfile('.\results',[output_filename, filename_suffix, '.mat']));
    end
    t_elapsed(1, i_mcs) = toc;
    
end % mcs loop

disp('-------------------------------------------------')
disp(['Elapsed time: ', num2str(sum(t_elapsed)),' seconds.'])
disp(' ')
disp('SNR: ')
disp(SNR)
disp('BER CODED DATA: ')
disp(results.ber_coded_data)
disp('THR CODED DATA: ')
disp(results.throughput_coded_data)

% present BER results for single MCS value
if length(MCSvec) == 1
    figure(1)
    subplot(131)
    semilogy(SNR, results.ber_PSDU)
    hold on, grid on
    semilogy(SNR, results.ber_PSDU_padded)
    semilogy(SNR, results.ber_coded_data,'k:')
    semilogy(SNR, results.ber_uncoded_data,'k--')
    xlabel('SNR [dB]'), xlim([SNR(1) SNR(end)])
    ylabel('BER [-]'), ylim([1e-6 1])
    legend('PSDU','PSDU + padding','coded','uncoded','Location','southeast')
    
    subplot(132)
    semilogy(SNR, results.fer_frames_PSDU)
    hold on, grid on
    semilogy(SNR, results.fer_frames_coded_data)
    xlabel('SNR [dB]'), xlim([SNR(1) SNR(end)])
    ylabel('FER [-]'), ylim([1e-6 1])
    legend('PSDU','PSDU + padding')
    
    subplot(133)
    plot(SNR, results.throughput_coded_data)
    hold on, grid on
    xlabel('SNR [dB]'), xlim([SNR(1) SNR(end)])
    ylabel('Throughput [b/s]')
    xlim([SNR(1), SNR(end)])
    ylim([0, (floor(ad_MCS_data_rates_vec(i_mcs-1)/1e9)+1)*1e9])
end