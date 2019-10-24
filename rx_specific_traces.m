classdef rx_specific_traces
    % rx_specific_traces class for store rx specific simulation results
    %
    % Author:	Jiri Milos, DREL FEEC BUT, 2018
    %
    
    properties
        err_data = [];      % properties changing values every 12 symbols
        num_data = [];
        ber_data = [];
        
        err_uncoded_data = [];
        num_uncoded_data = [];
        ber_uncoded_data = [];
        
        err_frames = [];
        num_frames = [];
        fer_frames = [];
        
        err_uncoded_frames = [];
        num_uncoded_frames = [];
        fer_uncoded_frames = [];
    end
    
    methods
        function obj = rx_specific_traces(snr_vec,n_symbols) % class constructor
            snr_vec_length = length(snr_vec);
            obj.err_data = zeros(n_symbols,snr_vec_length); % preallocation
            obj.num_data = zeros(n_symbols,snr_vec_length);
            obj.ber_data = zeros(1,snr_vec_length);
            
            obj.err_uncoded_data = zeros(n_symbols,snr_vec_length); % preallocation
            obj.num_uncoded_data = zeros(n_symbols,snr_vec_length);
            obj.ber_uncoded_data = zeros(1,snr_vec_length);
            
            obj.err_frames = zeros(n_symbols/12,snr_vec_length); % preallocation
            obj.num_frames = zeros(n_symbols/12,snr_vec_length);
            obj.fer_frames = zeros(1,snr_vec_length);
            
            obj.err_uncoded_frames = zeros(n_symbols/12,snr_vec_length); % preallocation
            obj.num_uncoded_frames = zeros(n_symbols/12,snr_vec_length);
            obj.fer_uncoded_frames = zeros(1,snr_vec_length);
        end
    end
end