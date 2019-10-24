function output_llr = demodulator(input_symbols, M, wifi_params, SNR_dB)
%DEMODULATOR is function for demodulation/demapping of received symbols which
% utilizes the essential functions Demod2D() and Somap() from Coded
% Modulation Library (CML) developed by Iterative Solutions.
%
% The Iterative Solutions Coded Modulation Library is free software; you
% can redistribute it and/or modify it under the terms of the GNU Lesser
% General Public License as published by the Free Software Foundation;
% either version 2.1 of the License, or (at your option) any later version.
%
% Author of non CML parts: Jiri Milos, DREL FEEC BUT, 2019
%
% -input:
%           input_symbols   = complex, modulated symbols
%           M               = number of symbols of constellation
%           wifi_params     = comprehensive simulator parameters including
%                             relevant modem parameters
%           SNR_dB          = Signal-to-noise ratio in dB used in the WLAN
%                             simulator
%
% -output:
%           output_llr      = demapped llr of received bits
% =========================================================================

k = log2(M); % number of bits per modulation symbol
SNR_lin = 10^(SNR_dB/20);

modNorm = wifi_params.modulation(k).hMod_factor;
SymbolConstellation = wifi_params.modulation(k).hMod.constellation*modNorm;

% wifi_params.modulation(k).hMod.constellation
switch k
    case 1
        SymbolMappingDecimal = [0; 1];
    otherwise
        SymbolMappingDecimal = wifi_params.modulation(k).hMod.CustomSymbolMapping;
        % rearrange order if they are not in order from 0 to M-1
        SCtemp = zeros(size(SymbolConstellation));
        
        SCtemp(SymbolMappingDecimal+1) = SymbolConstellation;
        SymbolConstellation = SCtemp;
        if size(SymbolConstellation, 1) > 1
            SymbolConstellation = SymbolConstellation.';
        end
end

switch wifi_params.general.standard
    case '802dot11n'
        Tsym = 1/wifi_params.mapping.df;%+wifi_params.cprefix.t_cp; % asi není korektní
        Fsamp = wifi_params.Fs;
        
        EsNo_dB = 10*log10(Tsym*Fsamp)+SNR_dB;
        warning('demodulator');
    case '802dot11ad'
        Tsym = wifi_params.mapping.Tchip;
        Fsamp = wifi_params.Fs;
        
        EsNo_dB = 10*log10(Tsym*Fsamp)+SNR_dB;
    otherwise
        error('Undefined yet');
end


% EsNo_lin = 10^(EsNo_dB/10);
if EsNo_dB >= 1000
    EsNo_lin = 10^(100/10);
else
    EsNo_lin = 10^(EsNo_dB/10);
end

sym_likelihood = Demod2D( input_symbols, SymbolConstellation, SNR_lin ); % demod ~ front end
% sym_likelihood = Demod2D( input_symbols, SymbolConstellation, EsNo_lin ); % demod ~ front end
llr = Somap( sym_likelihood ); % back end of demod

output_llr = -llr;

end