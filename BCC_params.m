function [coding] = BCC_params(wifi_params, m_stbc, mcs_ind)
% Function for computing convolutional coding parameters
%
% Author:	Jiri Milos, DREL FEEC BUT, 2018
%

coding.type = 'BCC';

LENGTH = wifi_params.general.LENGTH;
service_length = wifi_params.mapping.service_length;

MCS = wifi_params.MCS(mcs_ind);

switch wifi_params.general.standard
    case '802dot11ah'
        % single user operation
        coding.N_sym = m_stbc*ceil((8*LENGTH+service_length+6*MCS.N_es)/(m_stbc*MCS.N_dbps));
        coding.N_pad_bits = coding.N_sym*MCS.N_dbps-(8*LENGTH)-service_length-(6*MCS.N_es);
        % multi user opration is not defined yet
    otherwise
        coding.N_sym = m_stbc*ceil((8*LENGTH+service_length+6*MCS.N_es)/(m_stbc*MCS.N_dbps));
        coding.N_pad_bits = coding.N_sym*MCS.N_dbps-(8*LENGTH)-service_length-(6*MCS.N_es);
end

coding.K = 7;
coding.trellis = poly2trellis(7,[133, 171]);
coding.tail_length = 6;
% set puncturing patterns '0' signify punctured bit
coding.puncturing(1).CRstr = '1/2';
coding.puncturing(1).CR = 1/2;
coding.puncturing(1).pattern = [1 1];

coding.puncturing(2).CRstr = '2/3';
coding.puncturing(2).CR = 2/3;
coding.puncturing(2).pattern = [1 1 1 0];

coding.puncturing(3).CRstr = '3/4';
coding.puncturing(3).CR = 3/4;
coding.puncturing(3).pattern = [1 1 1 0 0 1];

coding.puncturing(4).CRstr = '5/6';
coding.puncturing(4).CR = 5/6;
coding.puncturing(4).pattern = [1 1 1 0 0 1 1 0 0 1];

% save other useful parameters
coding.CR = MCS.CR;

end

