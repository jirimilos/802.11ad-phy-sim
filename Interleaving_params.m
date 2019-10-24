function [interleaving] = Interleaving_params(coding_type,wifi_params,i_mcs)
% BCC interleaving params generation
%
% Author:	Jiri Milos, DREL FEEC BUT, 2018
%

MCS = wifi_params.MCS(i_mcs);

N_bpsc = log2(MCS.M);
N_cbps = MCS.N_cbps;

N_bpscs(1:MCS.N_ss) = N_bpsc;
N_cbpss(1:MCS.N_ss) = N_cbps;

interleaving.N_bpscs = N_bpscs;
interleaving.N_cbpss = N_cbpss;

switch wifi_params.general.standard
    case '802dot11g'
        k = cell(1,MCS.N_ss); i = k; j = i; r = i;
        inv_j = i; inv_i = i; inv_k = i;
        
        for i_ss = 1:MCS.N_ss
            s = max([N_bpsc/2, 1]);
            % forward
            k{i_ss} = 0:N_cbps-1;
            i{i_ss} = (N_cbps/16)*(mod(k{i_ss},16))+floor(k{i_ss}/16);
            
            i1 = 0:N_cbps-1;
            j{i_ss} = s*floor(i1/s)+mod(i1+N_cbps-floor(16*(i1/N_cbps)),s);
            
            j1 = 0:N_cbps-1;
            r{i_ss} = j1;
            % reverse (information purposes only)
            inv_r1 = 0:N_cbps-1;
            inv_j{i_ss} = inv_r1;
            
            inv_j1 = 0:N_cbps-1;
            inv_i{i_ss} = s*floor(inv_j1/s)+mod(inv_j1+floor(16*(inv_j1/N_cbps)),s);
            
            inv_i1 = 0:N_cbps-1;
            inv_k{i_ss} = 16*inv_i1-(N_cbps-1)*floor(16*(inv_i1/N_cbps));
            % quick check
            if sum(k{i_ss}-inv_k{i_ss}) ~= 0
                error('Wrong permutation matrix');
            end
        end
        interleaving.k = k;
        interleaving.i = i;
        interleaving.j = j;
        interleaving.r = r;
        interleaving.inv_j = inv_j;
        interleaving.inv_i = inv_i;
        interleaving.inv_k = inv_k;
        
    case {'802dot11n','802dot11ac','802dot11af','802dot11ah'}
        
        switch coding_type
            case 'BCC'
                switch wifi_params.mapping.bandwidth
                    case 1e6
                        n_col = 8;
                        n_row = 3*N_bpscs;
                        n_rot = 2;
                    case {2e6, 20e6}
                        n_col = 13;
                        n_row = 4*N_bpscs;
                        n_rot = 11;
                    case {4e6, 40e6}
                        n_col = 18;
                        n_row = 6*N_bpscs;
                        n_rot = 29;
                    case {8e6, 80e6, 160e6}
                        n_col = 26;
                        n_row = 9*N_bpscs;
                        n_rot = 58;
                    otherwise
                        error('Wrong bandwidth');
                end
                
                k = cell(1,MCS.N_ss); i = k; j = i; r = i;
                inv_j = i; inv_i = i; inv_k = i;
                
                for i_ss = 1:MCS.N_ss
                    s = max([N_bpscs(i_ss)/2,1]);
                    % forward
                    k{i_ss} = 0:N_cbpss(i_ss)-1;
                    i{i_ss} = n_row*mod(k{i_ss},n_col)+floor(k{i_ss}/n_col);
                    
                    i1 = 0:N_cbpss(i_ss)-1;
                    j{i_ss} = (s*floor(i1/s))+mod(i1+N_cbpss(i_ss)-floor((n_col*i1)/N_cbpss(i_ss)),s);
                    
                    j1 = 0:N_cbpss(i_ss)-1;
                    r{i_ss} = mod(j1-(mod((i_ss-1)*2,3))+3*floor((i_ss-1)/3)*n_rot*N_bpscs(i_ss),N_cbpss(i_ss));
                    % reverse (information purposes only)
                    inv_r1 = 0:N_cbpss(i_ss)-1;
                    inv_j{i_ss} = mod(inv_r1+(mod((i_ss-1)*2,3))+3*floor((i_ss-1)/3)*n_rot*N_bpscs(i_ss),N_cbpss(i_ss));
                    
                    inv_j1 = 0:N_cbpss(i_ss)-1;
                    inv_i{i_ss} = (s*floor(inv_j1/s))+mod(inv_j1+floor(n_col*inv_j1/N_cbpss(i_ss)),s);
                    
                    inv_i1 = 0:N_cbpss(i_ss)-1;
                    inv_k{i_ss} = (n_col*inv_i1)-((N_cbpss(i_ss)-1)*floor(inv_i1/n_row));
                    % quick check
                    if sum(k{i_ss}-inv_k{i_ss}) ~= 0
                        error('Wrong permutation matrix');
                    end
                end
                interleaving.k = k;
                interleaving.i = i;
                interleaving.j = j;
                interleaving.r = r;
                interleaving.inv_j = inv_j;
                interleaving.inv_i = inv_i;
                interleaving.inv_k = inv_k;
            case 'LDPC'
                interleaving = []; % to be defined according to standard
            otherwise
                error('Wrong channel coding type');
        end
        
    case '802dot11ax'
        nRU = 242; % test case
        switch coding_type
            case 'BCC'
                switch wifi_params.mapping.bandwidth
                    case 20e6
                        switch nRU
                            case 26
                                n_col = 4;
                                n_row = 3*N_bpscs;
                                n_rot = 2;
                            case 52
                                n_col = 8;
                                n_row = 3*N_bpscs;
                                n_rot = 2;
                            case 106
                                n_col = 17;
                                n_row = 3*N_bpscs;
                                n_rot = 11;
                            case 242
                                n_col = 26; %13;
                                n_row = 9*N_bpscs;
                                n_rot = 58; %29;
                        end
                    otherwise
                        error('Wrong bandwidth');
                end
                
                k = cell(1,MCS.N_ss); i = k; j = i; r = i;
                inv_j = i; inv_i = i; inv_k = i;
                
                for i_ss = 1:MCS.N_ss
                    s = max([N_bpscs(i_ss)/2,1]);
                    % forward
                    k{i_ss} = 0:N_cbpss(i_ss)-1;
                    i{i_ss} = n_row*mod(k{i_ss},n_col)+floor(k{i_ss}/n_col);
                    
                    i1 = 0:N_cbpss(i_ss)-1;
                    j{i_ss} = (s*floor(i1/s))+mod(i1+N_cbpss(i_ss)-floor((n_col*i1)/N_cbpss(i_ss)),s);
                    
                    j1 = 0:N_cbpss(i_ss)-1;
                    r{i_ss} = mod(j1-(mod((i_ss-1)*2,3))+3*floor((i_ss-1)/3)*n_rot*N_bpscs(i_ss),N_cbpss(i_ss));
                    % reverse (information purposes only)
                    inv_r1 = 0:N_cbpss(i_ss)-1;
                    inv_j{i_ss} = mod(inv_r1+(mod((i_ss-1)*2,3))+3*floor((i_ss-1)/3)*n_rot*N_bpscs(i_ss),N_cbpss(i_ss));
                    
                    inv_j1 = 0:N_cbpss(i_ss)-1;
                    inv_i{i_ss} = (s*floor(inv_j1/s))+mod(inv_j1+floor(n_col*inv_j1/N_cbpss(i_ss)),s);
                    
                    inv_i1 = 0:N_cbpss(i_ss)-1;
                    inv_k{i_ss} = (n_col*inv_i1)-((N_cbpss(i_ss)-1)*floor(inv_i1/n_row));
                    % quick check
                    if sum(k{i_ss}-inv_k{i_ss}) ~= 0
                        error('Wrong permutation matrix');
                    end
                end
                interleaving.k = k;
                interleaving.i = i;
                interleaving.j = j;
                interleaving.r = r;
                interleaving.inv_j = inv_j;
                interleaving.inv_i = inv_i;
                interleaving.inv_k = inv_k;
            case 'LDPC'
                interleaving = []; % to be defined according to standard
            otherwise
                error('Wrong channel coding type');
        end
    case '802dot11ad'
        % TBD
    otherwise
        error('Wrong IEEE 802.11 standard')
end


end