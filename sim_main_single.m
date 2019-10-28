%% Script with main simulation loops (single processing/simulation)
%
% Author:	Jiri Milos, DREL FEEC BUT, 2018
%

for i_snr = 1:length(SNR) % outer loop - SNR loop
    disp([' SNR = ',num2str(SNR(i_snr)),' dB | ',num2str(i_snr),'/',num2str(length(SNR)),' SNR values']);
    
    for i_loop = 1:N_frames % inner loop - number of frames within the loop
        if mod(i_loop,1000) == 0
            disp(['Part ',num2str(i_loop/1000),'/',num2str(N_frames/1000)]);
        end
        
        %% Transmitter ----------------------------------------------------
        txObj = WIFI_TX_ad(wifi_params,txObj,i_mcs); % perform transmitter operations
        
        %% Channel model, noise and impairments
        channelObj = channel(wifi_params, txObj.nTXant, rxObj.nRXant, i_snr);
        %         channelObj = channel_measured_JB(wifi_params,txObj.nTXant,rxObj.nRXant);
        
        x_s_filt = zeros(1, length(txObj.output.x_s)+channelObj.h_length-1);
        x_s_filt(1,1:end) = conv(txObj.output.x_s,channelObj.h); % puvodni
        
        channelObj.x_h = x_s_filt(1:length(txObj.output.x_s)); % useknuti konce
        
        channelObj.SNR = SNR(i_snr);
        
        % adding noise
        %         s = RandStream('mt19937ar','Seed',1);
        %         RandStream.setGlobalStream(s);
        %         rng(12345)
        
        n = 10^(-SNR(i_snr)/20)*((randn(size(channelObj.x_h))+1j*(randn(size(channelObj.x_h))))/sqrt(2));
        v = sqrt(wifi_params.mapping.n_fft/wifi_params.mapping.n_tot) * n;
        %
        % awgn or fading channel + white noise
        channelObj.x_hn = channelObj.x_h+v;
        %% Receiver -------------------------------------------------------
        rxObj = WIFI_RX_ad(wifi_params,rxObj,channelObj, channelObj.x_hn,i_mcs, SNR(i_snr), txObj, var(v), var(txObj.output.x_s));
        
        results = result_calculation(results,txObj,rxObj,i_snr,i_loop,N_frames);
        
    end % inner loop
    
end % outer loop