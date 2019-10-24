%% Script to diplay basic information about current simulation and switching 
% either single computing or parallel computing
%
% Author:	Jiri Milos, DREL FEEC BUT, 2018
%

disp(' ')
disp(' *******************************************************************')
disp(' *                                                                 *')
disp(' *               WLAN Physical Layer Simulator                     *')
disp(' *                                                                 *')
disp(' *                    ver. 1.02 (02/2019)                          *')
disp(' *                                                                 *')
disp(' *    Copyright:      Department of Radio Electronics              *')
disp(' *                    Brno University of Technology                *')
disp(' *                                                                 *')
disp(' *******************************************************************')
disp(' ');
disp([' IEEE ',wifi_standard,' > ',coding_type,', ',wifi_params.MCS(i_mcs).MCS,', M = ',num2str(wifi_params.MCS(i_mcs).M),', CR = ',sprintf('%2.2f',wifi_params.MCS(i_mcs).CR),', ',num2str(wifi_params.MCS(i_mcs).N_ss),' Spatial stream(s):']);
disp(' ');
disp(user_data_rate_str);
if ~strcmp(wifi_params.general.standard,'802dot11ad')
    disp(PSDU_data_rate_str);
end
disp(' ');
disp(' -------------------------------------------------------------------');


singleSim = true; % no parallel computing (for now)

if singleSim
    sim_main_single;
else
%     sim_main_parallel;
end