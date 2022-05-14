%% ECE3141 Project - PSK
% Amalesh Mamachan 32503318 
% Yanqing Li 31492398

%% Constants
clc; clear all;close all
M = 8;                % No. of symbols [2 4 8]
fc = 100000;                  % carrier frequency
eb = 1;                       % energy per bit
T = 0.0001;                   % symbol duration
t = linspace(0, T, 1000);     % time vector
symbol_length = log2(M);      % bits/symbol
symbol_plot = 4;              % how many symbols to include in PSK plot


%% Time domain plot of PSK modulated waveform
for M = [2, 4, 8]

    es = eb*log2(M); % energy per symbol

    % random 1024 bits
    bit_frame = randi([0, 1],1,1024);
    
    % 1024 bits converted into symbols
    symbol_frame = encoder(bit_frame, M);
    
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

    subplot(3, 1, log2(M))
    plot(1000*signal_length,transmitted_signal)
    title(sprintf('%d-PSK Modulation', M))

    %xlim([0 T])
end




%% Plotting Bit/Symbol probability vs Eb/N0
ebn0_db = 0:1:10;
ebn0_lin = 10.^(ebn0_db/10);

q = @(x) 0.5*erfc(x/sqrt(2));

% 2PSK Pb = 2PSK Ps = 4PSK Pb
pb2 = q(sqrt(2*ebn0_lin));

% 4PSD Ps
ps4 = erfc(sqrt(ebn0_lin));

% 8PSK error probability
ps8 = 2*q(sqrt(2*log2(M)*ebn0_lin)*sin(pi/M));
pb8 = ps8/log2(M);

figure(3)
plot(ebn0_db, log10(pb2), ebn0_db, log10(ps4), ebn0_db, log10(ps8), ebn0_db, log10(pb8));
legend('2PSK Pb = 2PSK Ps = 4PSK Pb', '4PSK Ps', '8PSK Pb', '8PSK Ps');
xlabel('Eb/N0 (dB)')
ylabel('Error probability (log10(P))')
title('Error probability vs Eb/N0 for various PSK modulation schemes')


%% Error probability
% adding noise
SNR = 5;

transmitted_signal2 = awgn(transmitted_signal,SNR);
figure(2)
plot(signal_length,transmitted_signal2)
hold on
xlim([0 symbol_plot*T])


%simulating signal modulation, white noise interference and demodulating 
symbol_frame=(symbol_frame-1)';
txsig = pskmod(symbol_frame,M,pi/M);%modulate
rxsig = awgn(txsig,SNR);%add noise
%note that the noise produced here does not correspond to the time domain
%noise plot
symbolsReceived = pskdemod(rxsig,M,pi/M);%demodulate
symbolErrors = symerr(symbol_frame,symbolsReceived);%count errors
decoded_frame = decoder(symbolsReceived',M);
bitErrors = symerr(decoded_frame,bit_frame);%count errors

if M == 8
    bitErrors = bitErrors -1;%the last bit is dropped so it is not considered as an error
end
    
formatSpec = '%4.0f symbol errors out of %4.0f symbols sent\n';
fprintf(formatSpec,symbolErrors,length(symbol_frame))

formatSpec = '%4.0f bit errors out of 1024 bits sent\n';
fprintf(formatSpec,bitErrors)

scatterplot(rxsig);

