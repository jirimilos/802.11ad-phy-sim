% present_results_wifi_AD
% Script presents a simulated performance results of IEEE 802.11ad 

results_index = 1;
print_to_eps = false;

switch results_index
    case 1        
        filenames = {
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS1_LENGTH01000_100_repeat_2019-02-26_094102.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS2_LENGTH01000_100_repeat_2019-02-26_100151.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS3_LENGTH01000_100_repeat_2019-02-26_102028.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS4_LENGTH01000_100_repeat_2019-02-26_103743.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS5_LENGTH01000_100_repeat_2019-02-26_105246.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS6_LENGTH01000_100_repeat_2019-02-26_111652.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS7_LENGTH01000_100_repeat_2019-02-26_113744.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS8_LENGTH01000_100_repeat_2019-02-26_115700.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS9.1_LENGTH01000_100_repeat_2019-02-26_123123.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS9_LENGTH01000_100_repeat_2019-02-26_121349.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS10_LENGTH01000_100_repeat_2019-02-26_130035.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS11_LENGTH01000_100_repeat_2019-02-26_132644.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS12_LENGTH01000_100_repeat_2019-02-26_135035.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS12.1_LENGTH01000_100_repeat_2019-02-26_141100.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS12.2_LENGTH01000_100_repeat_2019-02-26_143239.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS12.3_LENGTH01000_100_repeat_2019-02-26_150335.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS12.4_LENGTH01000_100_repeat_2019-02-26_153236.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS12.5_LENGTH01000_100_repeat_2019-02-26_155712.mat';
            'wifi_802dot11ad_BW2640_MHz_from-10to30_dB_LDPC_LLR_MCS12.6_LENGTH01000_100_repeat_2019-02-26_162305.mat';            
            };
    otherwise
        error('Undefined files');
end

[m,n] = size(filenames);

mezera_znacky = 4;
% Frame error rate (FER) PSDU and coded data throughput
for i = 1:m
    load(files{i});
        
    figure(2)
    semilogy(SNR, results.fer_frames_PSDU,'LineWidth',1.2)
    hold on, grid on
    %
    figure(3)
    plot(SNR, results.throughput_coded_data,'LineWidth',1.2)
    hold on, grid on
    
end



fig1 = figure(1);
varianta = 1;
ii = 1;
for i = 1:m
    load(filenames{i});
    switch varianta
        case 1 % dle modulace
            % barvy a znacky
            if i >= 1 && i < 6 % BPSK
                znacka = '^';
                barva = [0, 0.4470, 0.7410];
            elseif i >= 6 && i < 11 % QPSK
                znacka = 'o';
                barva = [0.8500, 0.3250, 0.0980];
            elseif i >= 11 && i < 16 % 16QAM
                znacka = 'd';
                barva = [0.4660, 0.6740, 0.1880];
            elseif i >= 16 % 64QAM
                znacka = 's';
                barva = [0.4940, 0.1840, 0.5560];
            end
            
            % nekodovane
            if ((i == 2) || (i == 6) || (i == 11) || (i == 16) && (m == 19))
                semilogy(SNR, results.ber_uncoded_data,'-.','LineWidth',1.3,'Color',barva);
                h1(ii, 1) = semilogy(-100, 0.5,'-','LineWidth',1.3,'Color',barva); % pro vykresleni legendy
                ii = ii +1;
                
            end
            semilogy(SNR, results.ber_PSDU,'-','LineWidth',1.2,'Color',barva);
            hold on, grid on
            
        case 2 % dle MCS
            h2(i,1) = semilogy(SNR, results.ber_PSDU,'-','LineWidth',1.2);
            hold on, grid on
    end
    
    
end


ad_MCS_vec = [1:9, 9.1, 10:12, 12.1:0.1:12.6].'; % for SC
if varianta == 1
    legend(h1, 'BPSK','QPSK','16QAM','64QAM');
else
    legend(h2, num2str(ad_MCS_vec));
end
xlim([-10 30]), ylim([1e-4 1])
xlabel('SNR [dB]')
ylabel('BER [-]')
print(fig1, ['figure1_',num2str(varianta),'.eps'],'-depsc');
system(['epstopdf ','figure1_',num2str(varianta),'.eps'])

fig2 = figure(2);
ad_MCS_vec = [1:9, 9.1, 10:12, 12.1:0.1:12.6].'; % for SC
legend(num2str(ad_MCS_vec))
xlim([-10 30]), ylim([1e-2 1])
xlabel('SNR [dB]')
ylabel('FER [-]')
print(fig2, 'figure2.eps','-depsc');
system(['epstopdf ','figure2.eps'])


fig3 = figure(3);
ad_MCS_vec = [1:9, 9.1, 10:12, 12.1:0.1:12.6].'; % for SC
legend(num2str(ad_MCS_vec),'Location','northwest')
xlim([-10 30])
xlabel('SNR [dB]')
ylabel('Coded data throughput [b/s]')
print(fig3, 'figure3.eps','-depsc');
system(['epstopdf ','figure3.eps'])
