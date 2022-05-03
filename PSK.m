%% ECE3141 Project - PSK
% Amalesh Mamachan 32503318 
% Yanqing Li 31492398

%% Constants
M = 2; 
fc = 100000;          % carrier frequency
eb = 1;               % energy per bit
es = eb*log(M);       % energy per symbol
T = 0.0001;           % symbol duration
t = 0:1e-6:0.0001;    % time steps
i = 1; % s_i using phi_i probably have to be created in a loop
phi = 2*pi.*i/M;

% random 1024 bits
frame = randi([0, 1],[1024,1]);

% creating the signal array
psk_signal = sqrt(2*es/T)*cos(2*pi*fc.*t - phi);