function Px = LDPC_P_shift(x, P0)
%
% Author:	Jiri Milos, DREL FEEC BUT, 2018
%

if (isnan(x) || x<0)
        Px = zeros(size(P0));
    else
%         Px = circshift(P0, x, 2);
        Px = circshift(P0,[ x, 2]);
    end

end