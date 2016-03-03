% Christina Hsu
% EE 442 Homework 7
% Question 3


% Initialize
w1p = 0.2*pi; w1s = 0.3*pi; 
w2s = 0.7*pi; w2p = 0.8*pi;
w0 = (w1s + w2s)/2; bw = w2p - w1p ; % bandwidth and center
Rp = 1; As = 50; 

% Build cheb filter
[N, Wc] = cheb1ord([0.2 0.8], [0.3 0.7], Rp, As, 's');
[Z, P, K] = cheb1ap(N, Rp);
[num,den] = zp2tf(Z,P,K);
[numt, dent] = lp2bs(num, den, w0, bw);

% Bilinear transformation
[nt, dt] = bilinear(numt, dent, 1);
[db,mag,pha,grd,w] = freqz_m(nt,dt);

% Plot
figure;
subplot(3,1,1); plot(w, mag); axis([0 pi 0 1]);
title('Magnitude Response'); grid;
xlabel('frequency in pi units'); ylabel('Magnitude');
subplot(3,1,2); plot(pha); axis([0 500 -pi pi]);
title('Phase Response'); grid
xlabel('w'); ylabel('Radians')
subplot(3,1,3);plot(db); grid; axis([0 500 -300 50]);
title('Log Magnitude Response'); xlabel('frequency in pi units');
ylabel('Decibels');


