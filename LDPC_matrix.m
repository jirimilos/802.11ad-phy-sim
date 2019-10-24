function [ UsedLDPC_matrix , Z ] = LDPC_matrix(CR, L_ldpc)
% LDPC matrix generation
%
% Author:	Jiri Milos, DREL FEEC BUT, 2018
% Updated by: Jiri Milos, DREL FEEC BUT, 2019
%

switch L_ldpc
    case 648 % IEEE 802.11n/ac
        Z = 27; % subblock size
        %% Output length = 648
        % Coding rate R = 1/2
        FmR12_template = ...
            [...
            0   NaN NaN NaN 0   0   NaN NaN 0   NaN NaN 0   1   0   NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN ;
            22  0   NaN	NaN 17  NaN 0   0   12  NaN NaN NaN NaN 0   0   NaN NaN NaN NaN NaN NaN NaN NaN NaN ;
            6   NaN 0   NaN 10  NaN NaN NaN 24  NaN 0   NaN NaN NaN 0   0   NaN NaN NaN NaN NaN NaN NaN NaN ;
            2   NaN NaN 0   20  NaN NaN NaN 25  0   NaN NaN NaN NaN NaN 0   0   NaN NaN NaN NaN NaN NaN NaN ;
            23  NaN NaN NaN 3   NaN NaN NaN 0   NaN 9   11  NaN NaN NaN NaN 0   0   NaN NaN NaN NaN NaN NaN ;
            24  NaN 23  1   17  NaN 3   NaN 10  NaN NaN NaN NaN NaN NaN NaN NaN 0   0	NaN NaN NaN NaN NaN ;
            25  NaN NaN NaN 8   NaN NaN NaN 7   18  NaN NaN 0   NaN NaN NaN NaN NaN 0   0	NaN NaN NaN NaN ;
            13  24  NaN NaN 0   NaN 8   NaN 6   NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN 0   0	NaN NaN NaN ;
            7   20  NaN 16  22  10  NaN NaN 23  NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN 0   0   NaN NaN ;
            11  NaN NaN NaN 19  NaN NaN NaN 13  NaN 3   17  NaN NaN NaN NaN NaN NaN NaN NaN NaN 0   0   NaN ;
            25  NaN 8   NaN 23  18  NaN 14  9   NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN 0   0   ;
            3   NaN NaN NaN 16  NaN NaN 2   25  5   NaN NaN 1   NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN 0   ;
            ];
        % Coding rate R = 2/3
        FmR23_template = ...
            [...
            25  26  14  NaN 20  NaN 2   NaN 4   NaN NaN 8   NaN 16  NaN 18  1   0   NaN NaN NaN NaN NaN NaN ;
            10  9   15  11  NaN 0   NaN 1   NaN NaN 18  NaN 8   NaN 10  NaN NaN 0   0   NaN NaN NaN NaN NaN ;
            16  2   20  26  21  NaN 6   NaN 1   26  NaN 7   NaN NaN NaN NaN NaN NaN 0   0   NaN NaN NaN NaN ;
            10  13  5   0   NaN 3   NaN 7   NaN NaN 26  NaN NaN 13  NaN 16  NaN NaN NaN 0   0   NaN NaN NaN ;
            23  14  24  NaN 12  NaN 19  NaN 17  NaN NaN NaN 20  NaN 21  NaN 0   NaN NaN NaN 0   0   NaN NaN ;
            6   22  9   20  NaN 25  NaN 17  NaN 8   NaN 14 NaN 18  NaN NaN NaN NaN NaN NaN NaN 0   0   NaN ;
            14  23  21  11  20  NaN 24  NaN 18  NaN 19  NaN NaN NaN NaN 22  NaN NaN NaN NaN NaN NaN 0   0   ;
            17  11  11  20  NaN 21  NaN 26  NaN 3   NaN NaN 18  NaN 26  NaN 1   NaN NaN NaN NaN NaN NaN 0   ;
            ];
        % Coding rate R = 3/4
        FmR34_template = ...
            [...
            16  17  22  24  9   3   14  NaN 4   2   7   NaN 26  NaN 2   NaN 21  NaN 1   0   NaN NaN NaN NaN ;
            25  12  12  3   3   26  6   21  NaN 15  22  NaN 15  NaN 4   NaN NaN 16  NaN 0   0   NaN NaN NaN ;
            25  18  26  16  22  23  9   NaN 0   NaN 4   NaN 4   NaN 8   23  11  NaN NaN NaN 0   0   NaN NaN ;
            9   7   0   1   17  NaN NaN 7   3   NaN 3   23  NaN 16  NaN NaN 21  NaN 0   NaN NaN 0   0   NaN ;
            24  5   26  7   1   NaN NaN 15  24  15  NaN 8   NaN 13  NaN 13  NaN 11  NaN NaN NaN NaN 0   0   ;
            2   2   19  14  24  1   15  19  NaN 21  NaN 2   NaN 24  NaN 3   NaN 2   1   NaN NaN NaN NaN 0   ;
            ];
        % Coding rate R = 5/6
        FmR56_template = ...
            [...
            17  13  8   21  9   3   18  12  10  0   4   15  19  2   5   10  26  19  13  13  1   0   NaN NaN ;
            3   12  11  14  11  25  5   18  0   9   2   26  26  10  24  7   14  20  4   2   NaN 0   0   NaN ;
            22  16  4   3   10  21  12  5   21  14  19  5   NaN 8   5   18  11  5   5   15  0   NaN 0   0   ;
            7   7   14  14  4   16  16  24  24  10  1   7   15  6   10  26  8   18  21  14  1   NaN NaN 0   ;
            ];
        
    case 1296 % IEEE 802.11n/ac
        Z = 54; % subblock size
        %% Output length = 1296
        % Coding rate R = 1/2
        FmR12_template = ...
            [...
            40  NaN NaN NaN 22  NaN 49  23  43  NaN NaN NaN 1   0   NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN ;
            50  1   NaN NaN 48  35  NaN NaN 13  NaN 30  NaN NaN 0   0   NaN NaN NaN NaN NaN NaN NaN NaN NaN ;
            39  50  NaN NaN 4   NaN 2   NaN NaN NaN NaN 49  NaN NaN 0   0   NaN NaN NaN NaN NaN NaN NaN NaN ;
            33  NaN NaN 38  37  NaN NaN 4   1   NaN NaN NaN NaN NaN NaN 0   0   NaN NaN NaN NaN NaN NaN NaN ;
            45  NaN NaN NaN 0   22  NaN NaN 20  42  NaN NaN NaN NaN NaN NaN 0   0   NaN NaN NaN NaN NaN NaN ;
            51  NaN NaN 48  35  NaN NaN NaN 44  NaN 18  NaN NaN NaN NaN NaN NaN 0   0   NaN NaN NaN NaN NaN ;
            47  11  NaN NaN NaN 17  NaN NaN 51  NaN NaN NaN 0	NaN NaN NaN NaN NaN 0   0   NaN NaN NaN NaN ;
            5   NaN 25  NaN 6   NaN 45  NaN 13  40  NaN NaN NaN NaN NaN NaN NaN NaN NaN 0   0   NaN NaN NaN ;
            33  NaN NaN 34  24  NaN NaN NaN 23  NaN NaN 46  NaN NaN NaN NaN NaN NaN NaN NaN 0   0   NaN NaN ;
            1   NaN 27  NaN 1   NaN NaN NaN 38  NaN 44  NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN 0   0   NaN ;
            NaN 18  NaN NaN 23  NaN NaN 8   0   35  NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN 0   0   ;
            49  NaN 17  NaN 30  NaN NaN NaN 34  NaN NaN 19  1   NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN 0   ;
            ];
        % Coding rate R = 2/3
        FmR23_template = ...
            [...
            39  31  22  43  NaN 40  4   NaN 11  NaN NaN 50  NaN NaN NaN 6   1   0   NaN NaN NaN NaN NaN NaN ;
            25  52  41  2   6   NaN 14  NaN 34  NaN NaN NaN 24  NaN 37  NaN NaN 0   0   NaN NaN NaN NaN NaN ;
            43  31  29  0   21  NaN 28  NaN NaN 2   NaN NaN 7   NaN 17  NaN NaN NaN 0   0   NaN NaN NaN NaN ;
            20  33  48  NaN 4   13  NaN 26  NaN NaN 23  NaN NaN 46  42  NaN NaN NaN NaN 0   0   NaN NaN NaN ;
            45  7   18  51  12  25  NaN NaN NaN 50  NaN NaN 5   NaN NaN NaN 0   NaN NaN NaN 0   0   NaN NaN ;
            35  40  32  16  5   NaN NaN 18  NaN NaN 43  51  NaN 32  NaN NaN NaN NaN NaN NaN NaN 0   0   NaN ;
            9   24  13  22  28  NaN NaN 37  NaN NaN 25  NaN NaN 52  NaN 13  NaN NaN NaN NaN NaN NaN 0   0   ;
            32  22  4   21  16  NaN NaN NaN 27  28  NaN 38  NaN NaN NaN 8   1   NaN NaN NaN NaN NaN NaN 0   ;
            ];
        % Coding rate R = 3/4
        FmR34_template = ...
            [...
            39  40  51  41  3   29  8   36  NaN 14  NaN 6   NaN 33  NaN 11  NaN 4   1   0   NaN NaN NaN NaN ;
            48  21  47  9   48  35  51  NaN 38  NaN 28  NaN 34  NaN 50  NaN 50  NaN NaN 0   0   NaN NaN NaN ;
            30  39  28  42  50  39  5   17  NaN 6   NaN 18  NaN 20  NaN 15  NaN 40  NaN NaN 0   0   NaN NaN ;
            29  0   1   43  36  30  47  NaN 49  NaN 47  NaN 3   NaN 35  NaN 34  NaN 0   NaN NaN 0   0   NaN ;
            1   32  11  23  10  44  12  7   NaN 48  NaN 4   NaN 9   NaN 17  NaN 16  NaN NaN NaN NaN 0   0   ;
            13  7   15  47  23  16  47  NaN 43  NaN 29  NaN 52  NaN 2   NaN 53  NaN 1   NaN NaN NaN NaN 0   ;
            ];
        % Coding rate R = 5/6
        FmR56_template = ...
            [...
            48  29  37  52  2   16  6   14  53  31  34  5   18  42  53  31  45  NaN 46  52  1   0   NaN NaN ;
            17  4   30  7   43  11  24  6   14  21  6   39  17  40  47  7   15  41  19  NaN NaN 0   0   NaN ;
            7   2   51  31  46  23  16  11  53  40  10  7   46  53  33  35  NaN 25  35  38  0   NaN 0   0   ;
            19  48  41  1   10  7   36  47  5   29  52  52  31  10  26  6   3   2   NaN 51  1   NaN NaN 0   ;
            ];
        
    case 1944 % IEEE 802.11n/ac
        Z = 81; % subblock size
        %% Output length = 1944
        % Coding rate R = 1/2
        FmR12_template = ...
            [...
            57  NaN NaN NaN 50  NaN 11  NaN 50  NaN 79  NaN 1   0   NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN ;
            3   NaN 28  NaN 0   NaN NaN NaN 55  7   NaN NaN NaN 0   0   NaN NaN NaN NaN NaN NaN NaN NaN NaN ;
            30  NaN NaN NaN 24  37  NaN NaN 56  14  NaN NaN NaN NaN 0   0   NaN NaN NaN NaN NaN NaN NaN NaN ;
            62  53  NaN NaN 53  NaN NaN 3   35  NaN NaN NaN NaN NaN NaN 0   0   NaN NaN NaN NaN NaN NaN NaN ;
            40  NaN NaN 20  66  NaN NaN 22  28  NaN NaN NaN NaN NaN NaN NaN 0   0   NaN NaN NaN NaN NaN NaN ;
            0   NaN NaN NaN 8   NaN 42  NaN 50  NaN NaN 8   NaN NaN NaN NaN NaN 0   0   NaN NaN NaN NaN NaN ;
            69  79  79  NaN NaN NaN 56  NaN 52  NaN NaN NaN 0   NaN NaN NaN NaN NaN 0   0   NaN NaN NaN NaN ;
            65  NaN NaN NaN 38  57  NaN NaN 72  NaN 27  NaN NaN NaN NaN NaN NaN NaN NaN 0   0   NaN NaN NaN ;
            64  NaN NaN NaN 14  52  NaN NaN 30  NaN NaN 32  NaN NaN NaN NaN NaN NaN NaN NaN 0   0   NaN NaN ;
            NaN 45  NaN 70  0   NaN NaN NaN 77  9   NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN 0   0   NaN ;
            2   56  NaN 57  35  NaN NaN NaN NaN NaN 12  NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN 0   0   ;
            24  NaN 61  NaN 60  NaN NaN 27  51  NaN NaN 16  1   NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN 0   ;
            ];
        % Coding rate R = 2/3
        FmR23_template = ...
            [...
            61  75  4   63  56  NaN NaN NaN NaN NaN NaN 8   NaN 2   17  25  1   0   NaN NaN NaN NaN NaN NaN ;
            56  74  77  20  NaN NaN NaN 64  24  4   67  NaN 7   NaN NaN NaN NaN 0   0   NaN NaN NaN NaN NaN ;
            28  21  68  10  7   14  65  NaN NaN NaN 23  NaN NaN NaN 75  NaN NaN NaN 0   0   NaN NaN NaN NaN ;
            48  38  43  78  76  NaN NaN NaN NaN 5   36  NaN 15  72  NaN NaN NaN NaN NaN 0   0   NaN NaN NaN ;
            40  2   53  25  NaN 52  62  NaN 20  NaN NaN 44  NaN NaN NaN NaN 0   NaN NaN NaN 0   0   NaN NaN ;
            69  23  64  10  22  NaN 21  NaN NaN NaN NaN NaN 68  23  29  NaN NaN NaN NaN NaN NaN 0   0   NaN ;
            12  0   68  20  55  61  NaN 40  NaN NaN NaN 52  NaN NaN NaN 44  NaN NaN NaN NaN NaN NaN 0   0   ;
            58  8   34  64  78  NaN NaN 11  78  24  NaN NaN NaN NaN NaN 58  1   NaN NaN NaN NaN NaN NaN 0   ;
            ];
        % Coding rate R = 3/4
        FmR34_template = ...
            [...
            48  29  28  39  9   61  NaN NaN NaN 63  45  80  NaN NaN NaN 37  32  22  1   0   NaN NaN NaN NaN ;
            4   49  42  48  11  30  NaN NaN NaN 49  17  41  37  15  NaN 54  NaN NaN NaN 0   0   NaN NaN NaN ;
            35  76  78  51  37  35  21  NaN 17  64  NaN NaN NaN 59  7   NaN NaN 32  NaN NaN 0   0   NaN NaN ;
            9   65  44  9   54  56  73  34  42  NaN NaN NaN 35  NaN NaN NaN 46  39  0   NaN NaN 0   0   NaN ;
            3   62  7   80  68  26  NaN 80  55  NaN 36  NaN 26  NaN 9   NaN 72  NaN NaN NaN NaN NaN 0   0   ;
            26  75  33  21  69  59  3   38  NaN NaN NaN 35  NaN 62  36  26  NaN NaN 1   NaN NaN NaN NaN 0   ;
            ];
        % Coding rate R = 5/6
        FmR56_template = ...
            [...
            13  48  80  66  4   74  7   30  76  52  37  60  NaN 49  73  31  74  73  23  NaN 1   0   NaN NaN ;
            69  63  74  56  64  77  57  65  6   16  51  NaN 64  NaN 68  9   48  62  54  27  NaN 0   0   NaN ;
            51  15  0   80  24  25  42  54  44  71  71  9   67  35  NaN 58  NaN 29  NaN 53  0   NaN 0   0   ;
            16  29  36  41  44  56  59  37  50  24  NaN 65  4   65  52  NaN 4   NaN 73  52  1   NaN NaN 0   ;
            ];
    case 672 % IEEE 802.11ad
        Z = 42;
        % Coding rate R = 1/2
        FmR12_template = ...
            [...
            40  NaN 38  NaN 13  NaN 5   NaN 18  NaN NaN NaN NaN NaN NaN NaN ;
            34  NaN 35  NaN 27  NaN NaN 30  2   1   NaN NaN NaN NaN NaN NaN ;
            NaN 36  NaN 31  NaN 7   NaN 34  NaN 10  41  NaN NaN NaN NaN NaN ;
            NaN 27  NaN 18  NaN 12  20  NaN NaN NaN 15  6   NaN NaN NaN NaN ;
            35  NaN 41  NaN 40  NaN 39  NaN 28  NaN NaN 3   28  NaN NaN NaN ;
            29  NaN 0   NaN NaN 22  NaN 4   NaN 28  NaN 27  NaN 23  NaN NaN ;
            NaN 31  NaN 23  NaN 21  NaN 20  NaN NaN 12  NaN NaN 0   13  NaN ;
            NaN 22  NaN 34  31  NaN 14  NaN 4   NaN NaN NaN 13  NaN 22  24  ;
            ];
        
        % Coding rate R = 5/8
        FmR58_template = ...
            [...
            20  36  34  31  20  7   41  34  NaN 10  41  NaN NaN NaN NaN NaN ;
            30  27  NaN 18  NaN 12  20  14  2   25  15  6   NaN NaN NaN NaN ;
            35  NaN 41  NaN 40  NaN 39  NaN 28  NaN NaN 3   28  NaN NaN NaN ;
            29  NaN 0   NaN NaN 22  NaN 4   NaN 28  NaN 27  24  23  NaN NaN ;
            NaN 31  NaN 23  NaN 21  NaN 20  NaN 9   12  NaN NaN 0   13  NaN ;
            NaN 22  NaN 34  31  NaN 14  NaN 4   NaN NaN NaN NaN NaN 22  24  ;
            ];
        
        % Coding rate R = 3/4
        FmR34_template = ...
            [...
            35  19  41  22  40  41  39  6   28  18  17  3   28  NaN NaN NaN ;
            29  30  0   8   33  22  17  4   27  28  20  27  24  23  NaN NaN ;
            37  31  18  23  11  21  6   20  32  9   12  29  NaN 0   13  NaN ;
            25  22  4   34  31  3   14  15  4   NaN 14  18  13  13  22  24  ;
            ];
        
        % Coding rate R = 13/16
        FmR1316_template = ...
            [...
            29  30  0   8   33  22  17  4   27  28  20  27  24  23  NaN NaN ;
            37  31  18  23  11  21  6   20  32  9   12  29  10  0   13  NaN ;
            25  22  4   34  31  3   14  15  4   2   14  18  13  13  22  24  ;
            ];
    case 624 % IEEE 802.11ad, special case
        Z = 42;
        % Coding rate R = 7/8 utilizes punctured matrix for R = 13/16
        FmR1316_template = ...
            [...
            29  30  0   8   33  22  17  4   27  28  20  27  24  23  NaN NaN ;
            37  31  18  23  11  21  6   20  32  9   12  29  10  0   13  NaN ;
            25  22  4   34  31  3   14  15  4   2   14  18  13  13  22  24  ;
            ];
end

P0 = eye(Z); % Z x Z submatrix
%% Build LDPC matrices from template
switch CR
    case 1/2
        UsedLDPC_matrix = BuildLDPCmatrixFromTemplate(FmR12_template, P0);
    case 5/8
        UsedLDPC_matrix = BuildLDPCmatrixFromTemplate(FmR58_template, P0);
    case 2/3
        UsedLDPC_matrix = BuildLDPCmatrixFromTemplate(FmR23_template, P0);
    case 3/4
        UsedLDPC_matrix = BuildLDPCmatrixFromTemplate(FmR34_template, P0);
    case 13/16
        UsedLDPC_matrix = BuildLDPCmatrixFromTemplate(FmR1316_template, P0);
    case 5/6
        UsedLDPC_matrix = BuildLDPCmatrixFromTemplate(FmR56_template, P0);
    case 7/8
        UsedLDPC_matrix = BuildLDPCmatrixFromTemplate(FmR1316_template, P0); % IEEE 802.11ad; 48 parity bits punctured
    otherwise
        error('Wrong code rate');
end

