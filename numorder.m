function n = numorder( val, base )
% Order of magnitude of number for specified base. Default base is 10.
% order(0.002) will return -3., order(1.3e6) will return 6.
% 
% Author: Ivar Eskerud Smith
% URL: https://www.mathworks.com/matlabcentral/fileexchange/28559-order-of-magnitude-of-number?s_tid=prof_contriblnk
% 

if nargin < 2
    base = 10;
end
n = floor(log(abs(val))./log(base));