%% Question 3
%% Hamming LP Filter (Question 3a)
wp = 0.48*pi; ws = 0.54*pi;
tr_width = abs(ws - wp);
M = ceil(6.6*pi/tr_width) + 1;
n = 0:M-1;
wc = (ws+wp)/2;

% Create Filter
hd = ideal_lp(wc,M);
w_ham = hamming(M)';
h = hd .* w_ham;
[db,mag,pha,grd,w] = freqz_m(h,1);
delta_w = 2*pi/1000;

% Check Properties
Rp = -(min(db(1:wp/delta_w+1)))        % Passband Ripple
As = -round(max(db(ws/delta_w+1:501))) % Min Stopband attenuation

%% Plots
figure
subplot(3,1,1); stem(n, h); title('Impulse Response')
xlabel('n'); ylabel('h(n)')

subplot(3,1,2); plot(w/pi,db);
title('Magnitude Response  (Hamming Window)'); grid;
xlabel('frequency (pi)'); ylabel('dB')

subplot(3,1,3); plot(angle(h(1:40))); 
title('Phase Response'); xlabel('phase (pi)'); ylabel('phase h(n)');

%% Sampling method (Question 3b)
M = 33; alpha = (M-1)/2; 
l = 0:M-1; wl = (2*pi/M)*l;
T1 = 0.39039917;

% Create filter
Hrs = [ones(1,8),T1,zeros(1,16),T1,ones(1,7)];
Hdr = [1,1,0,0]; wdl = [0,0.48,0.54,1];
k1 = 0:floor((M-1)/2); k2 = floor((M-1)/2)+1:M-1;
angH = [-alpha*(2*pi)/M*k1, alpha*(2*pi)/M*(M-k2)];
H = Hrs.*exp(1i*angH); h = real(ifft(H,M));
[db,mag,pha,grd,w] = freqz_m(h,1);
[Hr,ww,a,L] = hr_type1(h);

%% Plots
figure
subplot(3,1,1); stem(l,h); 
title('Impulse Response'); xlabel('n'); ylabel('h(n)');
subplot(3,1,2);plot(w/pi,db); grid;
title('Magnitude Response (Sampling)'); xlabel('frequency (pi)')
subplot(3,1,3); plot(angle(h)); 
title('Phase Response'); xlabel('phase (pi)'); ylabel('phase h(n)');