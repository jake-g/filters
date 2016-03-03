% Christina Hsu
% EE 442 Homework 7
% Question 1

% clear all; close all; clc;

% Design a Chebyshev-I lowpass filter
fs = 8000; % Hz
wp = 2*pi*3200/fs; % rad/sec
ws = 2*pi*3800/fs; % rad/sec
Rp = 0.5; % dB
As = 45; % dB

%% Part 1: Use the impulse invariance transformation with T = 1 sec
T1 = 1;
OmegaP1 = wp/T1;
OmegaS1 = ws/T1;

[cs1, ds1] = afd_chb1(OmegaP1, OmegaS1, Rp, As);

[b1, a1] = imp_invr(cs1, ds1, T1);
[C1, B1, A1] = dir2par(b1, a1)

[db,mag,pha,grd,w] = freqz_m(b1,a1);

% Plot results
figure;
subplot(3,1,1);
plot(mag); %axis([0 1 0 1]);
title('Magnitude Response'); grid;
xlabel('frequency in pi units'); ylabel('Magnitude');

subplot(3,1,2); plot(pha); 
title('Phase Response'); grid
xlabel('w'); ylabel('Radians')

subplot(3,1,3);plot(db); axis([0 500 -50 5]); grid;
title('Log Magnitude Response'); xlabel('frequency in pi units');
ylabel('Decibels');


%% Part 2: Use the impulse invariance transformation with T = 1/8000 sec
T2 = 1/8000;
OmegaP2 = wp*T2;
OmegaS2 = ws*T2;

[cs2, ds2] = afd_chb1(OmegaP2, OmegaS2, Rp, As);

[b2, a2] = imp_invr(cs2, ds2, T2);
[C2, B2, A2] = dir2par(b2, a2);

[db2,mag2,pha2,grd2,w2] = freqz_m(b2,a2);


% Plot results
figure;
subplot(3,1,1);
plot(mag2); %axis([0 1 0 1]);
title('Magnitude Response'); grid;
xlabel('frequency in pi units'); ylabel('Magnitude');

subplot(3,1,2); plot(pha2); 
title('Phase Response'); grid
xlabel('w'); ylabel('Radians')

subplot(3,1,3);plot(db2); axis([0 500 -50 5]); grid;
title('Log Magnitude Response'); xlabel('frequency in pi units');
ylabel('Decibels');
