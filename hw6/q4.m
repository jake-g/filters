Op = 4000*pi; Os = 6000*pi; Rp = 0.8; As = 25;
e = sqrt((10^0.1*Rp)-1); A = 10 ^ (As/20); 
Or = Os/Op; g = sqrt((A^2 - 1)/(e^2));
N = ceil(log10(g + sqrt((g^2) - 1))/log10(Or + sqrt((Or^2) -1)));

[b, a]=u_chb1ap(N,Rp, Op);
[db,mag,pha,w] = freqs_m(b,a, Os);

al = 1/e + (1 + 1/e^2)^(1/2)
min = 1/2*(al^(1/N) - al^(-1/N));
maj = 1/2*(al^(1/N) + al^(-1/N));
k = (0:N-1)';
ok(:,1) = min*Op*cos((pi/2)+(2*k+1)*pi/(2*N))
ok(:,2) = maj*Op*sin((pi/2)+(2*k+1)*pi/(2*N))
p = ok(:,1) + 1i*ok(:,2)
zplane(0,p)
a2 = real(poly(p));
% b = 1/sqrt(1 + e^2);
% [db,mag,pha,w] = freqs_m(b,a, Os);
%% Plots
subplot(4,1,1); plot(mag);title('Magnitude Response')
xlabel('Frequency (pi)'); ylabel('|H|'); xlim([0, 500])
subplot(4,1,2); plot(db);title('Magnitude in dB')
xlabel('Frequency (pi)'); ylabel('dB'); xlim([0, 500])
subplot(4,1,3); plot(pha); title('Phase Response')
xlabel('Frequency (pi)'); ylabel('rad'); xlim([0, 500])
subplot(4,1,4); impulse(b,a); title('Impulse Response')
xlabel('time (s)'); ylabel('ha(t)');