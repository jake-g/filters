% Chapter 8: Example 8.12
%            Impulse Invariance Transformation
%                  Chebyshev-1 Lowpass Filter Design
%

% Digital Filter Specifications:
fs  = 8;
wp = 3.2*2*pi/fs;
ws = 3.8*2*pi/fs;
Rp = 0.5; % dB
As = 45; % dB

% Analog Prototype Specifications: Inverse mapping for frequencies
T = 1;                               % Set T=1
OmegaP1 = wp/T1;
OmegaS1 = ws/T1;

% Analog Chebyshev-1 Prototype Filter Calculation:
[cs,ds] = afd_chb1(OmegaP,OmegaS,Rp,As);
%%*** Chebyshev-1 Filter Order =  4 

% Impulse Invariance transformation:
[b,a] = imp_invr(cs,ds,T);
[C,B,A] = dir2par(b,a)

% Plotting
figure(1); subplot(1,1,1)
[db,mag,pha,grd,w] = freqz_m(b,a);
subplot(2,2,1); plot(w/pi,mag); title('Magnitude Response')
xlabel('frequency in pi units'); ylabel('|H|'); axis([0,1,0,1.1])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[0,Attn,Ripple,1]); grid
subplot(2,2,3); plot(w/pi,db); title('Magnitude in dB');
xlabel('frequency in pi units'); ylabel('decibels'); axis([0,1,-40,5]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[-50,-15,-1,0]); grid
set(gca,'YTickLabelMode','manual','YTickLabels',['50';'15';' 1';' 0'])
subplot(2,2,2); plot(w/pi,pha/pi); title('Phase Response')
xlabel('frequency in pi units'); ylabel('pi units'); axis([0,1,-1,1]);
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[-1,0,1]); grid
subplot(2,2,4); plot(w/pi,grd); title('Group Delay')
xlabel('frequency in pi units'); ylabel('Samples'); axis([0,1,0,15])
set(gca,'XTickMode','manual','XTick',[0,0.2,0.3,1]);
set(gca,'YTickmode','manual','YTick',[0:5:15]); grid
