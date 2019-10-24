function results = result_all(results)
%
% Author:	Jiri Milos, DREL FEEC BUT, 2018
%

results.ber_PSDU = sum(results.err_PSDU,1)./sum(results.num_PSDU,1);
atest1 = results;
fields_atest1 = fieldnames(atest1);

if sum(strcmp(fields_atest1, 'err_PSDU_plus_service')) > 0
    results.ber_PSDU_plus_service = sum(results.err_PSDU_plus_service,1)./sum(results.num_PSDU_plus_service,1);
    results.throughput_PSDU = results.data_rate_PSDU*(1-results.fer_frames_PSDU);
else
    results.ber_PSDU_padded = sum(results.err_PSDU_padded,1)./sum(results.num_PSDU_padded,1);
end

results.ber_coded_data = sum(results.err_coded_data,1)./sum(results.num_coded_data,1);
results.ber_uncoded_data = sum(results.err_uncoded_data,1)./sum(results.num_uncoded_data,1);

results.fer_frames_PSDU = sum(results.err_frames_PSDU,1)./results.num_frames_PSDU;
results.fer_frames_coded_data = sum(results.err_frames_coded_data,1)./results.num_frames_coded_data;


results.throughput_coded_data = results.data_rate*(1-results.fer_frames_coded_data);

end