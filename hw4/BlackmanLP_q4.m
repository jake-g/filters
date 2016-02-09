%% Question 4.1 
% You can't use Hamming since it has a min stopband attenuation of 53dB, 
% which is less than the specified 66dB

%% Blackman LP Filter (Question 4.2)
% Input parameters
wp = 0.4*pi; ws = 0.6*pi;
tr_width = ws - wp
M = ceil(11*pi/tr_width) + 1
n=0:M-1;
wc = (ws+wp)/2

% Create Filter
hd = ideal_lp(wc,M);
w_blk = blackman(M)';
h = hd .* w_blk;
[db,mag,pha,grd,w] = freqz_m(h, 1);
delta_w = 2*pi/1000;

%% Plots
subplot(2,1,1); stem(n, h); title('Impulse Response')
xlabel('n'); ylabel('h(n)')

subplot(2,1,2); plot(w/pi,db);
title('Magnitude Response (Blackman Window)'); grid;
xlabel('Frequency (rad/s)'); ylabel('dB')
axis([0 1 -100 10]);

%% Question 4.3
% Even since M is even (M = 56) and the impulse response is symmetrical 


%% Question 4.5
% Check Properties
Rp = -(min(db(1:1:wp/delta_w+1)))        % Passband Ripple
As = -round(max(db(ws/delta_w+1:1:501))) % Min Stopband attenuation
disp('Rp is < 0.7dB and As is > 66dB, so this filter meets spec')