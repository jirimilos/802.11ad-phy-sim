function [chanMod] = channel(wifi_params, nTX, nRX, i_snr)
% Channel function for creating awgn or fading channel matrix
%
% Authors:	Jiri Milos, DREL FEEC BUT, 2018--2019
%			Jiri Blumenstein, DREL FEEC BUT, 2019
%

n_fft = wifi_params.mapping.n_fft;
n_gi = wifi_params.mapping.N_GI;

Fs = wifi_params.Fs;
H = zeros(n_fft,1,nTX,nRX);

if strcmp(wifi_params.general.PHYlayer,'OFDM')
    Nsym = wifi_params.mapping.n_data_symbols_per_frame;
end

if strcmp(wifi_params.channel.type,'awgn')
    H = ones(n_fft,1,nTX,nRX); % no fading
    h = ones(1,1,nTX,nRX);
    Lch = [];
    Ntap = [];
    normalize_factor_h = 1;
    h_length = 1;
    powerdB = [];
    powerlin = [];
    delay = 0;
    H2 = H;
    
    chanMod.H = H; % only block fading
    chanMod.h = h;
    chanMod.normh = normalize_factor_h;
    chanMod.h_length = h_length;
    chanMod.nTX = nTX;
    chanMod.nRX = nRX;
    chanMod.Lch = Lch;
    chanMod.Ntap = Ntap;
    chanMod.genie.PDB_dB = powerdB;
    chanMod.genie.PDB_lin = powerlin;
    chanMod.genie.delay = delay;
    chanMod.genie.powlin_for_h_est = abs(h);
    chanMod.genie.H2 = H2;
    
elseif strcmp(wifi_params.channel.type,'fad') % fading
    
    powerdB = wifi_params.channel.powerdB;
    powerlin = 10.^(powerdB/10);
    
    normalize_factor_h = sqrt(sum(10.^powerdB/10));
    
    delayTime = wifi_params.channel.delayTime; % channel delay sample
    delay = unique(round(delayTime*Fs));
    
    Ntap = length(powerdB); % channel tap number
    Lch = delay(end)+1;
    
    g_rand = (randn(1,Ntap)+1j*randn(1,Ntap))/sqrt(2);
    
    h = zeros(1,Lch);
    
    for i_tap = 1:length(delay)
        h(1, delay(i_tap)+1) = sqrt(powerlin(i_tap))*g_rand(1, i_tap);
    end
    
    h = h/normalize_factor_h;
    h_length = length(h);
    
    % for perfect channel knowledge
    H = fft([h, zeros(1, n_fft-h_length-n_gi)]);
    H2 = fft([h, zeros(1, n_fft-h_length)]);
    
    chanMod.H = H; % only block fading
    chanMod.h = h;
    chanMod.normh = normalize_factor_h;
    chanMod.h_length = h_length;
    chanMod.nTX = nTX;
    chanMod.nRX = nRX;
    chanMod.Lch = Lch;
    chanMod.Ntap = Ntap;
    chanMod.genie.PDB_dB = powerdB;
    chanMod.genie.PDB_lin = powerlin;
    chanMod.genie.delay = delay;
    chanMod.genie.powlin_for_h_est = abs(h);
    chanMod.genie.H2 = H2;
    
elseif strcmp(wifi_params.channel.type,'fad_meas') % fading - measured channel
    
    load(['CIR.mat']);
%     load(['CIR2.mat']);
    velikost=size(CIR_mat);
        
    h = squeeze(CIR_mat(a,b,1:end-1)); % FUNGUJE
    [a,b]=max(h);
    
    h_LOS=h(b:end);
    
    % for decim = 5
    decim = i_snr+5;
    if decim > 9
        decim=decim+2;
    end
    
    N_p = 1001;         % number of measured frequency points
    T_r = 1/10e9;       % time resolution given by BW
    dist_res = 1*3e8*T_r;               % distance resolution
    dist_vec = 0:dist_res:dist_res*(N_p-1); % distance vector
    
    delay_res = T_r;
    delay_vec = 0:delay_res:delay_res*(N_p-1); % delay vector
    
    h_length=length(h_LOS);
    
    % decim = 20;
    iii=1;
    for ii=1:decim:h_length-decim
        h_reduced(iii) = 1/decim*sum(h_LOS(ii:ii+decim));
        iii=iii+1;
    end
    
    delay_vec_reduced = delay_vec(1:length(h_reduced));
    
    h_reduced=h_reduced.*1/max(abs(h_reduced));
    
    %% RMS delay spread
    % mean_delay = sum(delay_vec_reduced.*abs(h_reduced).^2)  /    sum(abs(h_reduced).^2);
    % for i=1:length(h_reduced)
    %     rms_delay_1(i) = (delay_vec_reduced(i)-mean_delay).^2  .*  abs(h_reduced(i)).^2;
    % end
    %     clc
    % mean_delay;
    %     rms_delay = sqrt(sum(rms_delay_1)/sum(abs(h_reduced).^2));
    % rms_delay_vec(decim) = sqrt(sum(rms_delay_1)/sum(abs(h_reduced).^2));
    
    h_length=length(h_reduced);
    
    H_reduced = fft([h_reduced, zeros(1, n_fft-h_length-n_gi)]);
    H2_reduced = fft([h_reduced, zeros(1, n_fft-h_length)]);
    
    Lch = [];
    Ntap = [];
    normalize_factor_h = 1;
    powerdB = [];
    powerlin = [];
    delay = 0;
    H2 = H;
    
    chanMod.H = H_reduced; % only block fading
    chanMod.H2 = H2_reduced;
    chanMod.h = h_reduced;
    chanMod.normh = normalize_factor_h;
    chanMod.h_length = h_length;
    chanMod.nTX = 1;
    chanMod.nRX = 1;
    chanMod.Lch = Lch;
    chanMod.Ntap = 5;
    chanMod.genie.PDB_dB = powerdB;
    chanMod.genie.PDB_lin = powerlin;
    chanMod.genie.delay = delay;
    chanMod.genie.powlin_for_h_est = abs(h_reduced);
    chanMod.genie.H2 = H2;
    
else
    error('Unsupported channel type (see channel.m)');
    
end

end