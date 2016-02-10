%% Question 1
ls = 0.3*pi;    us = 0.7*pi;
lp = 0.4*pi;    up = 0.6*pi;
As = 40;        Rp = 0.5;

Fs = (lp - ls)/2;
BW = (up - lp)/Fs +1;
M = ceil(2*pi/(Fs));
alpha = (M-1)/2; 
l = 0:M-1; wl = (2*pi/M)*l;
T1 = 0.405;

Hrs = [zeros(1,ls/Fs+1), T1, ones(1, BW), T1];
Hrs = repmat([Hrs, zeros(1, (M/2 - length(Hrs)))], [1,2]);
Hdr = [0,0,1,1,0,0]; wdl = [0,0.3,0.4,0.6,0.7,1];

% check
k1 = 0:floor((M-1)/2); k2 = floor((M-1)/2)+1:M-1;
angH = [-alpha*(2*pi)/M*k1, alpha*(2*pi)/M*(M-k2)];
H = Hrs.*exp(1i*angH); h = real(ifft(H,M));
[db,mag,pha,grd,w] = freqz_m(h,1);
[Hr,ww,a,L] = hr_type2(h);

% Check Properties
delta_w = 2*pi/1000;
Rp = -min(db(lp/delta_w + 1:up/delta_w)) % Actual Passband Ripple
As = -round(max(db(us/delta_w+1:501))) % Min Stopband Attenuation

%% Plot 
% subplot(1,1,1)
subplot(4,1,1);plot(wl(1:M/2 +1)/pi,Hrs(1:M/2 +1),'o',wdl,Hdr); 
axis([0,1,-0.1,1.1]); title('Bandpass Filter')
xlabel('frequency in pi units'); ylabel('Hr(k)')
set(gca,'XTickMode','manual','XTick',[0,0.2,0.35,0.65,0.8,1])
% set(gca,'YTickMode','manual','YTick',[0,0.59,0.109,1]); grid

subplot(4,1,2); stem(l,h); axis([-1,M,-0.4,0.4])
title('Impulse Response'); xlabel('n'); ylabel('h(n)');
subplot(4,1,3); plot(ww/pi,Hr,wl(1:M/2 +1)/pi,Hrs(1:M/2 +1),'o');
axis([0,1,-0.1,1.1]); title('Amplitude Response')
xlabel('frequency in pi units'); ylabel('Hr(w)')
set(gca,'XTickMode','manual','XTick',[0,0.2,0.35,0.65,0.8,1])
% set(gca,'YTickMode','manual','YTick',[0,0.59,0.109,1]); grid

subplot(4,1,4);plot(w/pi,db); axis([0,1,-100,10]); grid
title('Magnitude Response'); xlabel('frequency in pi units');
ylabel('Decibels');
set(gca,'XTickMode','Manual','XTick',[0,0.2,0.35,0.65,0.8,1]);
set(gca,'YTickMode','Manual','YTick',[-60;0]);
set(gca,'YTickLabelMode','manual','YTickLabels',['60';' 0'])

%