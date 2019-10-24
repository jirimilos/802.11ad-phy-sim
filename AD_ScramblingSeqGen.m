function [scrambling_sequence] = AD_ScramblingSeqGen(len_scramblerIn, scr_seed)
%AD_ScramblingSeqGen - Function which generates scrambling sequence for
% IEEE 802.11ad - see std. IEEE 802.11-2016, ch. 20.3.9
%
% Author:	Jiri Milos, DREL FEEC BUT, 2019
%

scrambling_sequence = nan(len_scramblerIn, 1);
Register = scr_seed;

warning('Check according to IEEE 802.11ad - see std. IEEE 802.11-2016, ch. 20.3.9')

for i_scr = 1:len_scramblerIn
    scrambling_sequence(i_scr) = xor(Register(1),Register(4));
    Register = circshift(Register,[0 -1]);
    Register(7) = scrambling_sequence(i_scr);
end

end

