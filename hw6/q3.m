
Rp = 1; As = 50; Om_p = 10; Om_s = 15
[N,Omega_c]=cheb1ord(Om_p/100, Om_s/100, Rp, As);
[b, a]=u_chb1ap(N,Rp, Om_p);

% Calculation of Frequency Response:
[db,mag,pha,w] = freqs_m(b,a, Om_s);

% Plots
subplot(4,1,1); plot(mag);title('Magnitude Response')
xlabel('Frequency (pi)'); ylabel('|H|'); xlim([0, 500])

subplot(4,1,2); plot(db);title('Magnitude in dB')
xlabel('Frequency (pi)'); ylabel('dB'); ; xlim([0, 500])

subplot(4,1,3); plot(pha); title('Phase Response')
xlabel('Frequency (pi)'); ylabel('rad'); ; xlim([0, 500])

subplot(4,1,4); impulse(b,a);; title('Impulse Response')
xlabel('time (s)'); ylabel('ha(t)');