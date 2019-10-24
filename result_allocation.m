function obj = result_allocation(snr_vec,n_frames,wifi_params)
%
% Author:	Jiri Milos, DREL FEEC BUT, 2018
%
snr_vec_length = length(snr_vec);

% user traffic data without overhead
obj.err_PSDU = zeros(n_frames,snr_vec_length); % preallocation
obj.num_PSDU = zeros(n_frames,snr_vec_length);
obj.ber_PSDU = zeros(1,snr_vec_length);

% user traffic data + SERVICE zeros field but without overhead
if ~strcmp(wifi_params.general.standard,'802dot11ad')
    obj.err_PSDU_plus_service = zeros(n_frames,snr_vec_length); % preallocation
    obj.num_PSDU_plus_service = zeros(n_frames,snr_vec_length);
    obj.ber_PSDU_plus_service = zeros(1,snr_vec_length);
else
    obj.err_PSDU_padded = zeros(n_frames,snr_vec_length); % preallocation
    obj.num_PSDU_padded = zeros(n_frames,snr_vec_length);
    obj.ber_PSDU_padded = zeros(1,snr_vec_length);
end
% encoder input = [SERVICE, DATA, PAD_BITS, TAIL] (BCC)
%               = [] (LDPC)
obj.err_coded_data = zeros(n_frames,snr_vec_length); % preallocation
obj.num_coded_data = zeros(n_frames,snr_vec_length);
obj.ber_coded_data = zeros(1,snr_vec_length);

% interleaver output or modulator input (raw data)
obj.err_uncoded_data = zeros(n_frames,snr_vec_length); % preallocation
obj.num_uncoded_data = zeros(n_frames,snr_vec_length);
obj.ber_uncoded_data = zeros(1,snr_vec_length);

% throughput - user traffic data without overhead - only for information purposes
obj.throughput_PSDU = zeros(1,snr_vec_length); % *
% throughput - encoder input (commonly presented throughput)
obj.throughput_coded_data = zeros(1,snr_vec_length); % **

if ~strcmp(wifi_params.general.standard,'802dot11ad')
    obj.data_rate_PSDU = wifi_params.data_rate_PSDU;
end

obj.data_rate = wifi_params.data_rate;

% frame error rate (whole PSDU) - only for information purposes
obj.err_frames_PSDU = zeros(n_frames,snr_vec_length); % *
obj.num_frames_PSDU = zeros(1,snr_vec_length);
obj.fer_frames_PSDU = zeros(1,snr_vec_length);

% frame error rate - encoder input (commonly presented frame error rate)
obj.err_frames_coded_data = zeros(n_frames,snr_vec_length); % **
obj.num_frames_coded_data = zeros(1,snr_vec_length);
obj.fer_frames_coded_data = zeros(1,snr_vec_length);

end