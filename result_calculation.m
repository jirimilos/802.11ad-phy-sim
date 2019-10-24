function results = result_calculation(results,txObj,rxObj,i_snr,i_loop,n_frames)
%
% Author:	Jiri Milos, DREL FEEC BUT, 2018
%

results.err_PSDU(i_loop,i_snr) = sum(xor(txObj.output.PSDU,rxObj.output.PSDU));
results.num_PSDU(i_loop,i_snr) = numel(txObj.output.PSDU);

atest1 = txObj.output;
fields_atest1 = fieldnames(atest1);

if sum(strcmp(fields_atest1, 'PSDU_plus_service')) > 0
    results.err_PSDU_plus_service(i_loop,i_snr) = sum(xor(txObj.output.PSDU_plus_service,rxObj.output.PSDU_plus_service));
    results.num_PSDU_plus_service(i_loop,i_snr) = numel(txObj.output.PSDU_plus_service);
else
    results.err_PSDU_padded(i_loop,i_snr) = sum(xor(txObj.output.PSDU_padded,rxObj.output.PSDU_padded));
    results.num_PSDU_padded(i_loop,i_snr) = numel(txObj.output.PSDU_padded);    
end


results.err_coded_data(i_loop,i_snr) = sum(xor(txObj.output.coded_data,rxObj.output.coded_data));
results.num_coded_data(i_loop,i_snr) = numel(txObj.output.coded_data);

results.err_uncoded_data(i_loop,i_snr) = sum(xor(txObj.output.uncoded_data,rxObj.output.uncoded_data));
results.num_uncoded_data(i_loop,i_snr) = numel(txObj.output.uncoded_data);

results.err_frames_PSDU(i_loop,i_snr) = sum(xor(txObj.output.PSDU,rxObj.output.PSDU)) ~= 0;
results.num_frames_PSDU(1,i_snr) = n_frames;

results.err_frames_coded_data(i_loop,i_snr) = sum(xor(txObj.output.coded_data,rxObj.output.coded_data)) ~= 0;
results.num_frames_coded_data(1,i_snr) = n_frames;


end