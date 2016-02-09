%% Kaiser BS Filter (Question 5)
%% Part 1
%Since M is computed to be odd, the type must be 1 or 3. Since the impulse
% response is symmetric, it must be Type 1.

%% Part 2
% Input parameters
stop1 = 0.4*pi; pass1 = 0.35*pi;
pass2 = 0.75*pi; stop2 = 0.7*pi;
wc1 = (stop1+pass1)/2; wc2 = (pass2+stop2)/2;
Rp = 0.7; As = 58;
tr_width = min((stop1-pass1),(pass2-stop2))

M = ceil((As-7.95)/(14.36*tr_width/(2*pi))+1); % kaiser ideal M value

n= 0:M-1;
beta = 0.1102*(As-8.7)

% Create Filter
hd = ideal_lp(wc1,M) + ideal_lp(pi,M) - ideal_lp(wc2,M);
w_kai = (kaiser(M,beta))';
h = hd .* w_kai;
[db, mag, pha, grd ,w] = freqz_m(h, 1);
delta_w = 2*pi/1000;
% 
Rp_verify = max(db(pass2/delta_w+1:501));
As_verify = -round(min(db(pass1/delta_w + 1:pass2/delta_w))) % Min Stopband Attenuation

%% Plots
subplot(2,1,1); stem(n, h); title('Impulse Response')
xlabel('n'); ylabel('h(n)')

subplot(2,1,2); plot(w/pi,db);
title('Magnitude BR Response (Kaiser Window)'); grid;
xlabel('Frequency (rad/s)'); ylabel('dB')
axis([0 1 -100 10]);

%% Part 3
n = 0:1023;
x = cos(0.18*pi*n) + sin(0.77*p*n) + cos(0.53*pi*n);
[db2,mag,pha,grd,w] = freqz_m(x, 1);

d
 

