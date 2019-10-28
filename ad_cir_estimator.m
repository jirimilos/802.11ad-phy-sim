function est_h = ad_cir_estimator(y_rx_cef, wifi_params)
%ad_cir_estimator Channel impulse response estimator based on Golay COmplementary sequences
% Author: Jiri Milos, DREL FEEC BUT
% Date: 2019/05/25
verze = 1;


% add -pi/2 rotation
modulated_CEF_symbol_index_k = (0:length(y_rx_cef)-1);
y_rx_cef_derotated = y_rx_cef.*exp(-1j*pi*modulated_CEF_symbol_index_k/2);
% y_rx_cef_derotated = y_rx_cef;

% simple Golay method to estimate CIR
Ga128 = wifi_params.spreading.Golay_Seq.Ga_128;
Gb128 = wifi_params.spreading.Golay_Seq.Gb_128;

Ga256 = [Ga128, Gb128];
Gb256 = [Ga128, -Gb128];

% Gu512 = [-Gb128, -Ga128, +Gb128, -Ga128];
% Gv512 = [-Gb128, +Ga128, -Gb128, -Ga128];
% Gv128 = -Gb128;
% CEF = [Gu512, Gv512, Gv128];

y_rx_cef_128_derotated = reshape(y_rx_cef_derotated,[],9).';

switch verze
    case 1 % puvodni (ziskana delka odezvy = 128 vzorku)
        
        R1 = xcorr(y_rx_cef_128_derotated(1,:), -Gb128);
        R2 = xcorr(y_rx_cef_128_derotated(2,:), -Ga128);
        R3 = xcorr(y_rx_cef_128_derotated(3,:), +Gb128);
        R4 = xcorr(y_rx_cef_128_derotated(4,:), -Ga128);
        R5 = xcorr(y_rx_cef_128_derotated(5,:), -Gb128);
        R6 = xcorr(y_rx_cef_128_derotated(6,:), +Ga128);
        R7 = xcorr(y_rx_cef_128_derotated(7,:), -Gb128);
        R8 = xcorr(y_rx_cef_128_derotated(8,:), -Ga128);
        R9 = xcorr(y_rx_cef_128_derotated(9,:), -Gb128);
        
        R12 = R1 + R2;
        R23 = R2 + R3;
        R34 = R3 + R4;
        R45 = R4 + R5;
        R56 = R5 + R6;
        R67 = R6 + R7;
        R78 = R7 + R8;
        R89 = R8 + R9;
        
        Rab = (1/(2*length(Ga128)))*(sum([R12; R23; R34; R45; R56; R67; R78; R89],1)/8);
        est_h = Rab(length(Ga128):end);
        
        % figure(5)
        % subplot(241)
        % stem(R12), grid on;
        % subplot(242)
        % stem(R23), grid on;
        % subplot(243)
        % stem(R34), grid on;
        % subplot(244)
        % stem(R45), grid on;
        % subplot(245)
        % stem(R56), grid on;
        % subplot(246)
        % stem(R67), grid on;
        % subplot(247)
        % stem(R78), grid on;
        % subplot(248)
        % stem(R89), grid on;
        %
        % figure(6)
        % stem(Rab)
        % hold on
        % stem(128,0,'rx')
    case 2 % pokus o ziskani prodlouzene verze zretezenim Ga a Gb z CES field, pr. Ga256 = [Ga128, Gb128], Gb256 = [Ga128, -Gb128]
        R1signMap = [-1*ones(1, 128), +1*ones(1, 128)];
        R2signMap = [-1*ones(1, 128), +1*ones(1, 128)];
        R3signMap = [+1*ones(1, 128), -1*ones(1, 128)];
        R4signMap = [-1*ones(1, 128), +1*ones(1, 128)];
        
        R1 = xcorr([y_rx_cef_128_derotated(2,:), y_rx_cef_128_derotated(3,:)].*R1signMap, Ga256.*R1signMap);
        R2 = xcorr([y_rx_cef_128_derotated(4,:), y_rx_cef_128_derotated(5,:)].*R2signMap, Gb256.*R2signMap);
        R3 = xcorr([y_rx_cef_128_derotated(6,:), y_rx_cef_128_derotated(7,:)].*R3signMap, Ga256.*R3signMap);
        R4 = xcorr([y_rx_cef_128_derotated(8,:), y_rx_cef_128_derotated(9,:)].*R4signMap, Gb256.*R4signMap);
        
        R12 = R1 + R2;
        R34 = R3 + R4;
        
        Rab = (1/(2*length(Ga256)))*(sum([R12; R34],1)/2);
        est_h = Rab(length(Ga256):end);
        
    otherwise
        error('Dosud nedefinovany typ odhadu');
end



end

