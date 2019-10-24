function [scrambling_sequence] = BCC_ScramblingSeqGen(scramblerIn, scr_seed)
% BCC_ScramblingSeqGen - Function which generates scrambling sequence for IEEE 802.11
%
% Author:	Jiri Milos, DREL FEEC BUT, 2018
%

scrambling_sequence = nan(size(scramblerIn));
Register = scr_seed;

for i_scr = 1:length(scramblerIn)
    scrambling_sequence(i_scr) = xor(Register(1),Register(4));
    Register = circshift(Register,[0 -1]);
    Register(7) = scrambling_sequence(i_scr);
end

end

