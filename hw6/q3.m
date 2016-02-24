Rp = 1; As = 50; Op = 10; Os = 15;
e = sqrt((10^0.1*Rp)-1); A = 10 ^ (As/20); 
Or = Os/Op; g = sqrt((A^2 - 1)/(e^2));
N = ceil(log10(g + sqrt((g^2) - 1))/log10(Or + sqrt((Or^2) -1)));
[b, a]=u_chb1ap(N,Rp, Op);
[db,mag,pha,w] = freqs_m(b,a, Os);
[gd, wd] = grpdelay(b, a, N);

%% Plots
subplot(4,1,1); plot(mag);title('Magnitude Response')
xlabel('Frequency (pi)'); ylabel('|H|'); xlim([0, 500])
subplot(4,1,2); plot(db);title('Magnitude in dB')
xlabel('Frequency (pi)'); ylabel('dB'); xlim([0, 500])
subplot(4,1,3); plot(wd, gd); title('Group Delay')
xlabel('Frequency (pi)'); ylabel('rad');
subplot(4,1,4); impulse(b,a); title('Impulse Response'); ylabel('ha(t)');