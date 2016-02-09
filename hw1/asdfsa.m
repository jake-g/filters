clc;
T = 1/10000; % samplefreq
t = 0:T:50; % time-axes
N = length(t);

% time-signal
y = heaviside(t)-heaviside(t-50);

% frequency-axes 1
freq1 = 1/T * (0:N-1) ./ N;

% frequency-axes 2
f = freq1(1:N/2)';
freq2 = [-1*flipud(f)' f(2:end)'];

% FFT
Y = abs(fft(y, N)); % fft
Z = fftshift(Y); % shiften

subplot(3,1,1)
plot(t,y);
title('Time Domain');
xlabel('time in sec');
ylabel('V');
grid on;

subplot(3,1,2)
plot(freq1, Y);
title('Frequency Domain');
xlabel('Freq in Hz');
ylabel('[Vs]');
grid on;

subplot(3,1,3)
plot(freq2, Z(2:end));
title('Frequency Domain shifted');
xlabel('Freq in Hz');
ylabel('[Vs]');
grid on;