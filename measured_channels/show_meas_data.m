%% Script shows emasured channel characteristics 
% for further relevant information see:
% 
% 
% Author: Jiri Blumenstein, DREL FEEC BUT, 2019
%
clearvars
close all
clc

N_p = 1001;         % number of measured frequency points
T_r = 1/10e9;       % time resolution given by BW
dist_res = 100*3e8*T_r;               % distance resolution
dist_vec = 0:dist_res:dist_res*N_p-1; % distance vector

for dataset=1:2
    
    if dataset==1
        load('CIR.mat')
        load('CTF.mat')
    end
    
    if dataset==2
        load('CIR2.mat')
        load('CTF2.mat')
    end
    
    f_vec = 55:0.01:65;
    
    k=1;
    for i=1:4
        for j=1:4
            figure(dataset);hold on;plot(dist_vec,(20*log10(squeeze(abs(CIR_mat(i,j,:))))));
            xlabel('dist [cm]');ylabel('|CIR| [dB]');title('CIR \forall paths')
            
            maxima(k) = max(20*log10(abs(CIR_mat(i,j,:))));
            k=k+1;
        end
    end
    %
    k=1;
    for i=1:4
        for j=1:4
            figure(dataset*20+k);
            plot(f_vec,20*log10(squeeze(real(CTF_mat(i,j,:)))));
            title(['h ',num2str([i,j]),'(f)']);
            xlabel('f [GHz]');
            ylabel('20*log10(|h(f)|) [dB]');
            hold on; 
            plot(f_vec,20*log10(squeeze(imag(CTF_mat(i,j,:)))),'r');
            legend('real','imag');
            k=k+1;
        end
    end
end