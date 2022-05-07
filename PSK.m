%% ECE3141 Project - PSK
% Amalesh Mamachan 32503318 
% Yanqing Li 31492398

%% Constants
clc; clear all;close all
M = 2;                % No. of symbols
fc = 100000;          % carrier frequency
eb = 1;               % energy per bit
es = eb*log(M);       % energy per symbol
T = 0.0001;           % symbol duration
t = 0:1e-6:0.0001;    % time steps
symbol_length = log2(M); %bits/symbol

% random 1024 bits
frame = randi([0, 1],1,1024);

% 1024 bits converted into symbols
frame_encoded = encoder(frame,M);


transmitted_signal = [];%composite of all symbols
for j = 1:length(frame_encoded)
    
    i = frame_encoded(j); % s_i using phi_i 
    phi = 2*pi.*i/M;

    pskSignal = sqrt(2*es/T)*cos(2*pi*fc.*t - phi);%waveform of one symbol
    transmitted_signal = [transmitted_signal,pskSignal];%adding the symbol to the final output signal

end

%transmitted_signal = transmitted_signal * 0.1;
%{
%total signal length = (1024/symbol_length) * 1*10^-4 s
signal_length = []
for i = 0:1022
    signal_length = [signal_length, 0+0.0001*i:1e-6:0.0001+0.0001*i;];
    
end
%}


