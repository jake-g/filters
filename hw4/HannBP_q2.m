%% Hann BP Filter (Question 2)
% Input parameters
stop1 = 0.2*pi; pass1 = 0.35*pi;
pass2 = 0.55*pi; stop2 = 0.75*pi;
tr_width = min((pass1-stop1),(stop2-pass2))
wc1 = (stop1+pass1)/2; wc2 = (pass2+stop2)/2;
M = ceil(6.2*pi/tr_width) + 1 % hanning
n= 0:M-1;

% Create Filter
hd = ideal_lp(wc2,M) - ideal_lp(wc1,M);
w_hann = (hann(M))';
h = hd .* w_hann;
[db, mag, pha, grd ,w] = freqz_m(h, 1);
delta_w = 2*pi/1000;

% Check Properties
Rp = -min(db(pass1/delta_w + 1:pass2/delta_w)) % Actual Passband Ripple
As = -round(max(db(stop2/delta_w+1:1:501))) % Min Stopband Attenuation

%% Plots

subplot(2,1,1); stem(n, h); title('Impulse Response')
xlabel('n'); ylabel('h(n)')

subplot(2,1,2); plot(w/pi,db);
title('Magnitude Response  (Hanning Window)'); grid;
xlabel('Frequency (rad/s)'); ylabel('dB')

