Os = 2000; Op = 500; As = 50; Rp = 0.25;

[N, Om_c] = buttord(wp, ws, Rp, As, 's')
[b, a] = u_buttap(N, Om_c);
% Calculation of Frequency Response:
[db,mag,pha,w] = freqs_m(b,a, ws);

% Plots
subplot(4,1,1); plot(mag);title('Magnitude Response')
xlabel('Frequency (pi)'); ylabel('|H|'); xlim([0, 500])

subplot(4,1,2); plot(db);title('Magnitude in dB')
xlabel('Frequency (pi)'); ylabel('dB'); ; xlim([0, 500])

subplot(4,1,3); plot(pha); title('Phase Response')
xlabel('Frequency (pi)'); ylabel('rad'); ; xlim([0, 500])

subplot(4,1,4); impulse(b,a); title('Impulse Response')
xlabel('time (s)'); ylabel('ha(t)');

b
a
disp('transfer function num and den')