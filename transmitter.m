classdef transmitter
    % transmitter class for IEEE 802.11 tx
    %
    % Author:	Jiri Milos, DREL FEEC BUT, 2018
    %
    
    properties
        nTXant = 1;         % number transmitting antennas
        fc = [];
        scheme = [];        % MCS
        output = [];
        genie = [];
    end
    
    methods
        function obj = transmitter(nTX,nTXant,fc,scheme,wifiMode) % class constructor
            if nargin ~= 0
                obj(nTX) = transmitter;
                for ii = 1:nTX
                    obj(ii).nTXant = nTXant;        % number of transmitting antennas is the same, we suppose only a single AP
                    obj(ii).fc = fc;                % carrier frequency should be the same for all transmitters and receivers
                    obj(ii).scheme = scheme;        % MCS should be the same for all transmitters and receivers
                end
            end
        end
        
        
    end
end