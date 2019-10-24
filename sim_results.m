classdef sim_results < handle
    % sim_results class for store an simulation results based on modeling
    % level
    %
    % Author:	Jiri Milos, DREL FEEC BUT, 2018
    %
    
    properties
        rx_specific = [];        % single receiver specific trace (intra system, link level)
        %         ssid_specific      % single ssid specific trace (intra system, system level - at least two WIFI working on the same carrier frequency)
        %         area_specific      % whole area specific trace (inter system, system level - WIFI and other systems working on the same area)
        snr_vec
        n_symbols
        nTX
        nRX
    end
    
    methods
        function obj = sim_results(nTX,nRX,snr_vec,n_symbols) % class constructor, preallocate space
            if nargin ~= 0
                obj.n_symbols = n_symbols; % or n_symbols or 12*symb ??
                obj.snr_vec = snr_vec;
                obj.nTX = nTX;
                obj.nRX = nRX;
                %                 obj.rx_specific(nTX,nRX) = rx_specific_traces(snr_vec,n_symbols);
                for ii_tx = 1:nTX
                    for ii_rx = 1:nRX
                        obj.rx_specific(ii_tx,ii_rx) = rx_specific_traces(snr_vec,n_symbols);
                    end
                end
            end
        end
        
        function save_loop_results(obj,TXout,RXout,i_symb,i_snr) % save simulation results within single step
            %             for ii_tx = 1:obj.nTX
            %                 for ii_rx = 1:obj.nRX
            obj.rx_specific(1,1).err_data(i_symb,i_snr) = sum(xor(TXout,RXout));
            %                 end
            %             end
        end
    end
    
end

