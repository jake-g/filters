fs = 8000;              % sampling rate
f0 = (1:3).*1000;     % notch frequency
fr = f0/fs;             % ratio of notch freq. to Nyquist freq.
nw = 0.2;               % width of the notch

zeros = [exp( 2*1i*pi*fr ), exp( -2*1i*pi*fr )]; % Compute zeros
poles = (1- nw) * zeros; % Compute poles

b = poly(zeros); % average filter coefficients
a = poly(poles); % autoregressive filter coefficients

[H, w] = freqz(b,a,fs);
mag = abs(H);
db = 20*log10((mag+eps)/max(mag))+1;
pha = angle(H);
max(db)

%% Plot Zeros and Magnitude and Phase
figure; % zero plot
zplane(zeros.', poles.');
figure; % mag, phase plot
subplot(211); plot(w/pi,db)
title('Magnitude Response'); xlabel('n'); ylabel('|h(n)|');
ylim([-50, 10])
subplot(212); plot(w/pi, pha)
title('Phase Response'); xlabel('n'); ylabel('<h(n)');

%% Filter Signal
load handel
%load splat
%load laughter
%load train
%load gong
% load chirp

% Add Spectral Noise
t= (1:1:length(y));
spectral = sum(cos(2*pi*fr(:)*t));
y_noise = y + spectral.';
filtered = filter(b,a,y_noise);

figure
subplot(311); plot(y)
title('Original'); xlabel('hz'); ylabel('h(n)'); ylim([-1, 1]);
subplot(312); plot(y_noise)
title('Added Noise'); xlabel('hz'); ylabel('h(n)');
subplot(313); plot(filtered)
title('Filtered'); xlabel('hz'); ylabel('h(n)'); ylim([-1, 1]);

%% Play Sound
% soundsc(y, Fs); pause() % original
soundsc(y_noise, Fs); pause()   % dirty
soundsc(filtered, Fs);  % clean

%% Spectral Plot
nwin = 512; % samples
noverlap = 256; %samples
nfft = 512; %samples

figure
subplot(311); spectrogram(y, nwin, noverlap, nfft); colormap(cool);
title('Original'); xlabel('hz'); ylabel('h(n)');
subplot(312); spectrogram(y_noise, nwin, noverlap, nfft); colormap(cool);
title('Added Noise'); xlabel('hz'); ylabel('h(n)');
subplot(313); spectrogram(filtered, nwin, noverlap, nfft); colormap(cool);
title('After Filtering'); xlabel('hz'); ylabel('h(n)');


