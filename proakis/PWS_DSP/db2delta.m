%% db2delta (Question 1.2)
function [d1,d2] = db2delta(Rp,As)

% Converts dB specs Rp and As into absolute specs delta11 and delta2
% [delta1, delta2] = db2delta(Rp, As)

K = 10^(Rp/20);
d1 = (K-1)/(K+1);
d2 = (1+d1)*(10^(-As/20));

