function ldpcMatrix = BuildLDPCmatrixFromTemplate(template, P0)
% Function builds an LDPC matrix
%
% Author:	Jiri Milos, DREL FEEC BUT, 2018
%

P0size=size(P0);
ldpcMatrix = zeros(size(template).*P0size);

for r=1:size(template,1)
    for c=1:size(template, 2)
        ldpcMatrix( (r-1)*P0size(1)+1 : r*P0size(1) , (c-1)*P0size(2)+1 : c*P0size(2) ) = LDPC_P_shift(template(r,c), P0);
    end
end
ldpcMatrix = sparse(ldpcMatrix);