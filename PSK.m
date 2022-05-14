%% ECE3141 Project - PSK
% Amalesh Mamachan 32503318 
% Yanqing Li 31492398

%% Constants
clc; clear all;close all
M = 2;                % No. of symbols
fc = 100000;                  % carrier frequency
eb = 1;                       % energy per bit
es = eb*log2(M);              % energy per symbol
T = 0.0001;                   % symbol duration
t = linspace(0, T, 1000);     % time vector
symbol_length = log2(M);      % bits/symbol
symbol_plot = 4;              % how many symbols to include in PSK plot


%% Message frame encoding
% random 1024 bits
bit_frame = randi([0, 1],1,1024);

% 1024 bits converted into symbols
symbol_frame = encoder(bit_frame, M);


%% Time domain plot of PSK modulated waveform
transmitted_signal = [];%composite of all symbols
signal_length = [];%total time vector

% look at only first few symbols
for j = 1:symbol_plot
    
    % determine phase of symbol
    i = symbol_frame(j); % s_i using phi_i 
    phi = 2*pi.*i/M;

    % waveform of one symbol
    pskSignal = sqrt(2*es/T)*cos(2*pi*fc.*t - phi); 

    % adding the symbol to the final output signal
    transmitted_signal = [transmitted_signal, pskSignal]; 
end

%scale signal down
transmitted_signal = transmitted_signal * 0.01;

%total signal length = (1024/symbol_length) * 1*10^-4 s

signal_length = linspace(0, symbol_plot*T, 1000*symbol_plot);
plot(signal_length,transmitted_signal)
hold on
xlim([0 symbol_plot*T])


%% Error probability
% adding noise
SNR = 20;

transmitted_signal2 = awgn(transmitted_signal,SNR);
figure(2)
plot(signal_length,transmitted_signal2)
hold on
xlim([0 symbol_plot*T])

txsig = pskmod((symbol_frame-1)',M,pi/M);
rxsig = awgn(txsig,SNR);
symbolsReceived = pskdemod(rxsig',M,pi/M);
symbolErrors = symerr(symbol_frame,symbolsReceived);

scatterplot(rxsig);

