function [output_codeword] = LDPC_enc(wifi_params, u_input)
% LDPC_enc Performs LDPC encoding according to IEEE 802.11n-2012 standard
% -------------------------------------------------------------------------
%
% Author: J. Milos, DREL FEEC BUT, 2018
%
% Simple method of LDPC encoding process is described in:
% Cai, Z; Hao, J.; Tan, P. H.; et al. "Efficient encoding of IEEE 802.11n
% LDPC codes", IEEE Electronic Letters, 2006, vol. 42, no. 25.
%
% Adapted according to: "A MATLAB implementation of the 802.11n LDPC encoder and
% decoder", www: https://github.com/simgunz/802.11n-ldpc
% for other documentation, see: https://github.com/simgunz/802.11n-ldpc/tree/master/doc
% 
% TO DO: optimize and rewrite to mex

%% Extract useful parameters
u_input = u_input'; % transform to row vector

H = full(wifi_params.coding.UsedLDPC_matrix);
%
N_avbits = wifi_params.coding.N_avbits;
N_pld = wifi_params.coding.N_pld; % number of bits in the PSDU and SERVICE field
Z = wifi_params.coding.Z; % size of a base subblock
CR = wifi_params.coding.CR;
L_ldpc = wifi_params.coding.L_ldpc; % codeword length (n = L_ldpc)
N_bpcw = wifi_params.coding.N_bpcw; % number of bits per codeword (k = N_bpcw ???)
N_cw = wifi_params.coding.N_cw; % number of LDPC codewords
m_u_input = length(u_input); % number of input bits = N_pld
N_pad = N_cw*N_bpcw - m_u_input; % same as: N_pad = wifi_params.coding.shortening.N_shrt
N_shrt_cw = wifi_params.coding.shortening.n_shrt_cw; % number of shortening bits in each cw
N_bitwoshrt_cw = wifi_params.coding.shortening.n_bitwoshrt_cw;
N_pld_cw = N_pld/N_cw;
%% Define some auxiliary variables

%% Encoding
if numel(L_ldpc)>1
    disp('length(L_ldpc) > 1')    
end

% N_avbits/N_cw
% N_shrt_cw
% N_bitwoshrt_cw
% encoding by backsubstitution
% c = zeros(N_avbits/N_cw, N_cw);
c = cell(1,N_cw);
H1 = H(:,1:N_bpcw);
H2 = H(:,N_bpcw+1:N_bpcw+Z);

if sum(N_bitwoshrt_cw) ~= numel(u_input)
    error('File "LDPC_enc.m": Incorrect number of input bits');
end

for i=1:N_cw
    % pick up single codeword data
    u_in = u_input(1:N_bitwoshrt_cw(i));
    u_input(1:N_bitwoshrt_cw(i)) = []; % forget of picked data bits
    payload = [u_in.'; zeros(N_shrt_cw(i), 1)]; % single codeword data + shortening bits N_shrt_cw
    % encoding
    s = H1 * payload;
    s = reshape(s,Z,(L_ldpc-N_bpcw)/Z);
    p1 = mod(sum(s,2),2);
    temp = H2 * p1;
    temp = reshape(temp,Z,(L_ldpc-N_bpcw)/Z);
    stilda = mod(s + temp,2);
    prevp2 = 0;
    ll = length(stilda(1,:)) - 1;
    p2 = zeros(ll*Z,1);
    for j=1:ll
        prevp2 = mod(stilda(:,j) + prevp2,2);
        p2((j-1)*Z+1:j*Z) = prevp2;
    end
    % shortening payload bits:
    payload_shortened = payload(1:wifi_params.coding.shortening.n_bitwoshrt_cw(i));
    
    % puncturing parity bits:
    parity = [payload; p1; p2]; % concatenate parity bits and payload
    punctured_parity = parity(wifi_params.coding.puncturing.parity_ind(i,:)); % punctured parity bits
    
    % concatenate shortened payload bits and punctured parity bits:
    c_temp = [payload_shortened; punctured_parity];
    
    % add repeated bits (not performed in all cases):
    c_temp = [c_temp; c_temp(1:wifi_params.coding.repeating.n_rep_cw(i))];
    
    c{i} = c_temp;
end

cc = vertcat(c{:}); % concatenate all codewords
d = cc(:)'; % parallel to serial

output_codeword = d;
end

