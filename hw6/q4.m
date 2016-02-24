Op = 4000*pi; Os = 6000*pi; Rp = 0.8; As = 25;
e = sqrt((10^(0.1*Rp))-1); A = 10 ^ (As/20); 
Or = Os/Op; g = sqrt((A^2 - 1)/(e^2));
N = ceil(log10(g + sqrt((g^2) - 1))/log10(Or + sqrt((Or^2) -1)));

al = 1/e + (1 + 1/e^2)^(1/2)
min = 1/2*(al^(1/N) - al^(-1/N));
maj = 1/2*(al^(1/N) + al^(-1/N));
k = (0:N-1)';
ok(:,1) = min*Op*cos((pi/2)+(2*k+1)*pi/(2*N))
ok(:,2) = maj*Op*sin((pi/2)+(2*k+1)*pi/(2*N))
p = ok(:,1) + 1i*ok(:,2)
zplane(0,p)
a = poly(p);
b = prod(p); % N is odd so K = product of poles
[db,mag,pha,w] = freqs_m(b, a, Os);

% Plot results
figure;
subplot(2,1,1);plot(db); grid; axis([0, 500, -30, 2]);
title('Log Magnitude Response'); xlabel('frequency (pi)');
ylabel('Decibels');

subplot(2,1,2); plot(pha/pi); axis([0, 500, -pi, pi]);
title('Phase Response'); grid
xlabel('frequency (pi)'); ylabel('Radians')