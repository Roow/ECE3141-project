%% Matlab example of pskmod usage
M = 4;
data = randi([0 M-1], 1000, 1);
txsig = pskmod(data,M,pi/M);
rxsig = awgn(txsig,20);
scatterplot(rxsig);