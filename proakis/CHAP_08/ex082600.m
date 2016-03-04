% Chapter 8: Example 8.26

%            Chebyshev-1 Highpass Filter Design:

%                Use of the ZMAPPING function

%

% Digital Lowpass Filter Specifications:
fs  = 8000;
wp = 3200*2*pi/fs;
ws = 3800*2*pi/fs;                % digital Stopband freq in Hz

  Rp = 1;                              % Passband ripple in dB

  As = 15;                             % Stopband attenuation in dB



% Analog Prototype Specifications: Inverse mapping for frequencies

T = 1; Fs = 1/T;                       % Set T=1

OmegaP = (2/T)*tan(wplp/2);            % Prewarp Prototype Passband freq

OmegaS = (2/T)*tan(wslp/2);            % Prewarp Prototype Stopband freq

ep = sqrt(10^(Rp/10)-1);               % Passband Ripple parameter

Ripple = sqrt(1/(1+ep*ep));            % Passband Ripple

Attn = 1/(10^(As/20));                 % Stopband Attenuation



% Analog Chebyshev Prototype Filter Calculation:

[cs,ds] = afd_chb1(OmegaP,OmegaS,Rp,As);

%%*** Chebyshev-1 Filter Order =  4 



% Bilinear transformation:

[blp,alp] = bilinear(cs,ds,T);






% Plotting

figure(1); subplot(1,1,1)

[dbl,magl,phal,grdl,w] = freqz_m(blp,alp);
subplot(2,2,1); plot(w/pi,magl); title('Lowpass Filter Magnitude Response')
xlabel('frequency in pi units'); ylabel('|H|'); axis([0,1,0,1]);
set(gca,'XTickMode','manual','XTick',[0,0.2,1]);
set(gca,'YTickMode','manual','YTick',[0,Ripple,1]);grid
subplot(2,2,2); plot(w/pi,dbl); title('Lowpass Filter Magnitude in dB');
xlabel('frequency in pi units'); ylabel('decibels'); axis([0 1 -30 0]);
set(gca,'XTickMode','manual','XTick',[0,0.2,1])
set(gca,'YTickMode','manual','YTick',[-30,-Rp,0]);grid
set(gca,'YTickLabelMode','manual','YTickLabels',['30';' 1';' 0']);
