%% ECE3141 Project - PSK
% Amalesh Mamachan 32503318 
% Yanqing Li 31492398

%% Constants
clc; clear all;
M = 2;                % No. of symbols
fc = 100000;          % carrier frequency
eb = 1;               % energy per bit
es = eb*log(M);       % energy per symbol
T = 0.0001;           % symbol duration
t = 0:1e-6:0.0001;    % time steps
symbol_length = log2(M); %bits/symbol

% random 1024 bits
frame = randi([0, 1],1,1024);


%convert frame into binary words
frame_encoded = [];%bits grouped into symbol_length in i values
for j = 1:symbol_length:1024
    
    word = [];
    for k = j:1:symbol_length
        
        word = [word, frame(k)];
    
    end
    frame_encoded = [frame_encoded,sum(word)+1];

end



%total signal length = (1024/symbol_length) * 1*10^-4 s

i = 1; % s_i using phi_i probably have to be created in a loop
phi = 2*pi.*i/M;

final_signal = [];%composite of all symbols

psk_signal = sqrt(2*es/T)*cos(2*pi*fc.*t - phi);% creating the signal array

