%% Hamming LP Filter (Question 3a)
wp = 0.48*pi; ws = 0.54*pi;
tr_width = ws - wp;
M = ceil(6.6*pi/tr_width) + 1;
n = 0:M-1;
wc = (ws+wp)/2;

% Create Filter
hd = ideal_lp(wc,M);
w_ham = hamming(M)';
h = hd .* w_ham;
[db,mag,pha,grd,w] = freqz_m(h,[1]);
delta_w = 2*pi/1000;

% Check Properties
Rp = -(min(db(1:wp/delta_w+1)))        % Passband Ripple
As = -round(max(db(ws/delta_w+1:501))) % Min Stopband attenuation

%% Plots
figure
subplot(2,1,1); stem(n, h); title('Impulse Response')
xlabel('n'); ylabel('h(n)')

subplot(2,1,2); plot(w/pi,db);
title('Magnitude Response  (Hamming Window)'); grid;
xlabel('Frequency (rad/s)'); ylabel('dB')


%% Sampling method (Question 3b)
wp = 0.48*pi;   
ws = 0.54*pi;    

Fs = (ws - wp)/2;
BW = ceil((wp)/Fs + 1);
M = floor(2*pi/(Fs));
alpha = (M-1)/2; 
l = 0:M-1; wl = (2*pi/M)*l;
T1 = 0.36983;

Hrs = [ones(1, BW), T1];
Hrs = [Hrs, zeros(1, (M/2 - length(Hrs)))];
Hrs = [Hrs Hrs];
Hdr = [1,1,0,0]; 
wdl = [0,wp,ws,1];

% % check
k1 = 0:floor((M-1)/2); k2 = floor((M-1)/2)+1:M-1;
angH = [-alpha*(2*pi)/M*k1, alpha*(2*pi)/M*(M-k2)];
H = Hrs.*exp(1i*angH); 
h = real(ifft(H,M));
% [d,~,~,~,~] = freqz_m(h,1);
[Hr,ww,a,L] = hr_type2(h);

% Check Properties
delta_w = 2*pi/1000;
Rp = -min(db(0/delta_w + 1:wp/delta_w)) % Actual Passband Ripple
As = -round(max(db(wp/delta_w+1:1:501))) % Min Stopband Attenuation

%% Plot 
figure

subplot(2,1,1); stem(l,h); axis([-1,M,-0.4,0.4])
title('Impulse Response'); xlabel('n'); ylabel('h(n)');

subplot(2,1,2);plot(w/pi,db); axis([0,1,-100,10]); grid
title('Magnitude Response'); xlabel('frequency in pi units');
ylabel('Decibels');


