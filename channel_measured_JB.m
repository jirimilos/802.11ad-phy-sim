function [chanMod] = channel(wifi_params,nTX,nRX)
% Channel function for creating awgn or fading channel matrix
%
% Author:	Jiri Milos, DREL FEEC BUT, 2018
%

n_fft = wifi_params.mapping.n_fft;
n_gi = wifi_params.mapping.N_GI;
% n_sf = wifi_params.mapping.n_sf;
% n_sf = wifi_params.coexistence.N_available_symbols;
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
    
elseif strcmp(wifi_params.channel.type,'fad')
    
    % powerdB = [0 -8 -17 -21 -25];
    
%     powerdB = [0 -7 -10 -13.01];
    powerdB = [0 -17];
%     powerdB = [0 -100];

    % powerdB = wifi_params.channel.powerdB;
    % powerdB = [1 0.2 -0.1 1]; % test
    
    powerlin = 10.^(powerdB/10);
    normalize_factor_h = sqrt(sum(10.^powerdB/10));
    
    
    % Delay = [0 3 5 6 12]; % channel delay sample
    delayTime = wifi_params.channel.delayTime; % channel delay sample
    %     delay = unique(round(delayTime*Fs));
    
    delay = [0 7 8 11];% test
    delay = [0 4];% test
    
    Ntap = length(powerdB); % channel tap number
    Lch = delay(end)+1;
    
    
    g_rand = (randn(1,Ntap)+1j*randn(1,Ntap))/sqrt(2);
    
    h = zeros(1,Lch);
    
    for i_tap = 1:length(delay)
        h(1, delay(i_tap)+1) = sqrt(powerlin(i_tap))*g_rand(1, i_tap);
    end
    
    h = h/normalize_factor_h;
    
    %% 
%     h=[h,0 0 0 0 0 0 0 0 0 0 0 0];
%     h=interp(h,7);
    
    
    %%
%     h=[1,zeros(1,127)];
    h_length = length(h);
    
    % for perfect channel knowledge
    H = fft([h, zeros(1, n_fft-h_length-n_gi)]);
    H2 = fft([h, zeros(1, n_fft-h_length)]);
    %     h = zeros(1,Lch,nTX,nRX);
    %     for i_tx = 1:nTX
    %         for i_rx = 1:nRX
    %             chanRand = (randn(1,Ntap)+1j*randn(1,Ntap)).*sqrt(powerlin/2);
    %             h_tmp = zeros(1,Lch);
    %             h_tmp(delay+1) = chanRand; % cir: channel impulse response
    %
    %             H_tmp = fft([h_tmp, zeros(1,n_fft-Lch)]); % channel frequency response
    %             H_tmp = H_tmp.';
    %
    %             h(:,:,i_tx,i_rx) = h_tmp;
    %             H(:,:,i_tx,i_rx) = H_tmp;
    %
    %         end
    %     end
%     figure();plot((abs(h)))
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
    
elseif strcmp(wifi_params.channel.type,'fad_meas')
    cd measured_channel;
    
%     load(['CIR_',num2str(randi(3)),'.mat']);
    load(['CIR_',num2str(1),'.mat']);
    velikost=size(CIR_mat);
    
    a=randi(velikost(1));
    b=randi(velikost(2));
    
    h = squeeze(CIR_mat(a,b,1:end-1)); % FUNGUJE
%     h_reduced = squeeze(CIR_mat(1,1,1:5:end-1)); % FUNGUJE
%     h_reduced = h_reduced(1:128);
%     
%     h=h.*1/max(h);        
    h_length=length(h);
%     
% %% BW reduction 10 GHz -> 2 GHz
iii=1;
for ii=1:5:h_length-5
    h_reduced(iii) = sum(h(ii:ii+5));
    iii=iii+1;
end
h_reduced = h_reduced(1:128);


% iii=1;
% for ii=1:50:h_length-50
%     h_reduced(iii) = sum(h(ii:ii+5));
%     iii=iii+1;
% end

h_reduced=h_reduced.*1/max(abs(h_reduced));
% h_reduced=[1,zeros(1,127)];

% figure();plot(abs(h));
% figure();plot(abs(h_reduced));

%%
%     H = fft([conj(h)', zeros(1, n_fft-h_length-n_gi)]);      
%     H2 = fft([conj(h)', zeros(1, n_fft-h_length)]);
 h_length=length(h_reduced);
     
%     H_reduced = fft([conj(h_reduced)', zeros(1, n_fft-h_length-n_gi)]);      
%     H2_reduced = fft([conj(h_reduced)', zeros(1, n_fft-h_length)]);

H_reduced = fft([h_reduced, zeros(1, n_fft-h_length-n_gi)]);      
H2_reduced = fft([h_reduced, zeros(1, n_fft-h_length)]);
    
    %     figure();plot(abs(H_reduced));hold on;plot(real(H_reduced),'r');plot(imag(H_reduced),'m');

%     figure();plot(20*log10(abs(H)));hold on;plot(20*log10(abs(interp(H_reduced,5))),'r')
%     figure();plot(abs(h));hold on;plot((abs(interp(h_reduced,5))),'r')
%     figure();plot((abs(h_reduced)))
    
   
    
    Lch = [];
    Ntap = [];
    normalize_factor_h = 1;
%     h_length = 1;
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
    
    cd ..
end



end