%% Kaiser BP Filter (Question 3)
% The ideal M value is computed below to  b 47. This will meet the filter
% specs, while minimizing M

% Input parameters
stop1 = 0.25*pi; pass1 = 0.35*pi;
pass2 = 0.65*pi; stop2 = 0.75*pi;
stop_tol = 0.01;
pass_tol = 0.1;
tr_width = min((pass1-stop1),(stop2-pass2))
wc1 = (stop1+pass1)/2; wc2 = (pass2+stop2)/2;

[Rp, As] = delta2db(pass_tol, stop_tol);

M = ceil((As-7.95)/(14.36*tr_width/(2*pi))+1) % kaiser ideal M value
n= 0:M-1;
beta = 0.5842*(As -21)^0.4 + 0.07886*(As -21)

% Create Filter
hd = ideal_lp(wc2,M) - ideal_lp(wc1,M);
w_kai = (kaiser(M,beta))';
h = hd .* w_kai;
[db, mag, pha, grd ,w] = freqz_m(h, 1);
delta_w = 2*pi/1000;

Rp_verify = -min(db(pass1/delta_w + 1:pass2/delta_w)) % Actual Passband Ripple
As_verify = -round(max(db(stop2/delta_w+1:1:501))) % Min Stopband Attenuation
[pass_tol_verify, stop_tol_verify] = db2delta(Rp_verify, As_verify)

%% Plots
subplot(2,1,1); stem(n, h); title('Impulse Response')
xlabel('n'); ylabel('h(n)')

subplot(2,1,2); plot(w/pi,db);
title('Magnitude Response (Kaiser Window)'); grid;
xlabel('Frequency (rad/s)'); ylabel('dB')
axis([0 1 -100 10]);

%% Min length
% Min length is M = 47