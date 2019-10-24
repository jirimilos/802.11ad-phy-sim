function [decoded_codeword, error_vec] = LDPC_LLR_decoder(coding, input_llr_vec, max_iter, min_sum)
% LDPC LLR decoding function
% Adapted by:	Jiri Milos, DREL FEEC BUT, 2018
%
% Original source: C and MATLAB implementation for LDPC encoding and decoding
% URL: https://github.com/tavildar/LDPC
%
H = coding.UsedLDPC_matrix;
M = size(H, 1);
N = size(H, 2);

% other necessary variables
col_weight_vec = sum(H, 1);
row_weight_vec = sum(H, 2);
max_col_weight  = max(col_weight_vec);
max_row_weight  = max(row_weight_vec);
col_mat = zeros(N, max_col_weight);
row_mat = zeros(M, max_row_weight);

for i_row = 1:M
    index = 1;
    for i_col = 1:N
        if H(i_row, i_col)
            row_mat(i_row, index) = i_col;
            index = index + 1;
        end
    end
end

for i_col = 1:N
    index = 1;
    for i_row = 1:M
        if H(i_row, i_col)
            col_mat(i_col, index) = i_row;
            index = index + 1;
        end
    end
end

% some preallocations
eta = zeros(M, N);
lasteta = zeros(M, N);
updated_llr_vec = input_llr_vec;
error_vec = zeros(max_iter, 1);

% individual iterations
for iter = 1:max_iter
    
    for i_m = 1:M
        for i_n1 = 1: row_weight_vec(i_m)
            n1 = row_mat(i_m, i_n1);
            if min_sum
                pr = 100;
            else
                pr = 1;
            end
            for  i_n2 = 1:row_weight_vec(i_m)
                if i_n1 == i_n2
                    continue;
                end
                n2 = row_mat(i_m, i_n2);
                l1 = (updated_llr_vec(n2) - lasteta(i_m, n2));
                l1 = min(l1, 20);
                l1 = max(l1, -20);
                if min_sum
                    pr = sign(pr)*sign(l1)*min(abs(l1), abs(pr));
                else
                    pr = pr*tanh(l1/2);
                end
            end
            if min_sum
                eta(i_m, n1) = pr;
            else
                eta(i_m, n1) = 2*atanh(pr);
            end
            
        end
    end
    
    lasteta = eta;
    
    for i_n = 1:N
        updated_llr_vec(i_n) = input_llr_vec(i_n);
        for i_m = 1:col_weight_vec(i_n)
            m = col_mat(i_n, i_m);
            updated_llr_vec(i_n) = updated_llr_vec(i_n) + eta(m,i_n);
        end
    end
    
    decoded_codeword = (updated_llr_vec < 0);
    if check_codeword(decoded_codeword, M, row_weight_vec, row_mat)
        return;
    else
        error_vec(iter) = 1;
    end
end

end

function [b] = check_codeword(x, M, row_weight_vec, row_mat)
b = 1;
for i_check = 1:M
    c = 0;
    for i_n = 1:row_weight_vec(i_check)
        c = c + x(row_mat(i_check, i_n));
    end
    if mod(c, 2) == 1
        b = 0;
        break;
    end
end
end