% Christina Hsu
% EE 442 Homework 7
% Question 2

clear all; close all; clc;

% Use the bilinear transformation technique and the bilinear function

% Design a Chebyshev-I lowpass filter
fs = 8000; % Hz
wp = 2*pi*3200/fs; % rad/sec
ws = 2*pi*3800/fs; % rad/sec
Rp = 0.5; % dB
As = 45; % dB
T = 1; % commonly chosen for simplicity
Fs = 1/T;

% Prewarp to reduce the nonlinear compression effect of analog to digital
% mapping
OmegaP = (2/T)*tan(wp/2);
OmegaS = (2/T)*tan(ws/2);

% Analog Chebyshev-I prototype filter calculation
[cs, ds] = afd_chb1(OmegaP, OmegaS, Rp, As);

% Apply the bilinear function
[b, a] = bilinear(cs, ds,Fs);
[C, B, A] = dir2cas(b, a);

[db,mag,pha,grd,w] = freqz_m(b,a);

% Plot the log-magnitude response in dB
figure;
plot(db, w); grid;
title('Log Magnitude Response'); xlabel('frequency in pi units');
ylabel('Decibels');

