
%% Homework 7

% Initialize
T = [1 1/8000]; % part 1 and part 2
fs  = 8000;
wp = 3200*2*pi/fs;
ws = 3800*2*pi/fs;
Rp = 0.5;
As = 45;

%% Q1 : Impulse Invariance


% loop through different T values
for i = 1:length(T)
    Op = wp/T(i);
    Os = ws/T(i);

    % Build cheb filter and bilinear transformation
    [cs, ds] = afd_chb1(Op, Os, Rp, As);
    [b, a] = imp_invr(cs, ds, T(i));
    [db, mag, pha, grd, w] = freqz_m(b, a);

    % Plot
    figure;
    subplot(3,1,1); plot(mag); 
    title('Magnitude Response'); grid;
    xlabel('frequency (pi)'); ylabel('Magnitude');
    subplot(3,1,2); plot(pha); 
    title('Phase Response'); grid
    xlabel('w'); ylabel('Rad')
    subplot(3,1,3);plot(db); axis([0 500 -50 5]); grid;
    title('Log Magnitude Response'); xlabel('frequency (pi)');
    ylabel('Decibels');
end

%% Q2 : Bilinear Transform
% Initialize
Op = (2/T(1))*tan(wp/2);
Os = (2/T(1))*tan(ws/2);

% Build cheb filter and bilinear transformation
[cs, ds] = afd_chb1(Op, Os, Rp, As);
[b, a] = bilinear(cs, ds, T(1));
[dbl,magl,phal,grdl,w] = freqz_m(b,a);

% Plots
figure; 
plot(w/pi,dbl); title('Lowpass Digital Filter Magnitude in dB');
xlabel('frequency (pi)'); ylabel('dB'); axis([0 1 -30 5]);
figure; subplot(2, 1, 1); plot(impulse(tf(b, a))); title('Digital Impulse')
xlabel('time (n)'); ylabel('Amplitude');
subplot(2, 1, 2); plot(impulse(tf(cs, ds))); title('Analog Impulse')
xlabel('time (t)'); ylabel('Amplitude');


%% Q3 : 
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
xlabel('frequency (pi)'); ylabel('Magnitude');
subplot(3,1,2); plot(pha); axis([0 500 -pi pi]);
title('Phase Response'); grid
xlabel('w'); ylabel('Rad')
subplot(3,1,3); plot(db); grid; axis([0 500 -300 50]);
title('Log Magnitude Response'); xlabel('frequency (pi)');
ylabel('dB');




