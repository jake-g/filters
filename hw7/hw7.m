
%% Homework 7


%% Q1 : Impulse Invariance

% Initialize
T = [1 1/8000]; % part 1 and part 2
fs  = 8000;
wp = 3200*2*pi/fs;
ws = 3800*2*pi/fs;
Rp = 0.5;
As = 45;

% loop through different T values
for i = 1:length(T)
    Op = wp/T(i)
    Os = ws/T(i)

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
%------------------------- compare diffs

%% Q2 : Bilinear Transform
% Initialize
Op = (2/T(1))*tan(wp/2);
Os = (2/T(1))*tan(ws/2);

% Build cheb filter and bilinear transformation
[cs, ds] = afd_chb1(Op, Os, Rp, As);
[b, a] = bilinear(cs, ds, 1/T(1));
[db,mag,pha,grd,w] = freqz_m(b, a);

% Plots
figure; 
% subplot(4,1,3); 
plot(db, w); grid;
title('Log Magnitude Response'); xlabel('frequency in pi units');
ylabel('Decibels');

%----------------------------------compare to analog

%% Q3 : 
% Initialize
w1p = 0.2*pi; w1s = 0.3*pi; 
w2s = 0.7*pi; w2p = 0.8*pi;
w0 = (w1s + w2s)/2; bw = w2p - w1p ; % bandwidth and center
Rp = 1; As = 50; 

% Build cheb filter and bilinear transformation
[N, Wc] = cheb1ord([w1p w2p]./pi, [w1s w2s]./pi, Rp, As, 's');
[Z, P, K] = cheb1ap(N, Rp);
[num,den] = zp2tf(Z,P,K);
[numt, dent] = lp2bs(num, den, w0, bw);
[nt, dt] = bilinear(num, den, 1);
[db,mag,pha,grd,w] = freqz_m(nt,dt);

% Plot
figure;
subplot(3,1,1); plot(w, mag); axis([0 pi 0 1]);
title('Magnitude Response'); grid;
xlabel('frequency in pi units'); ylabel('Magnitude');
subplot(3,1,2); plot(pha); axis([0 500 -pi pi]);
title('Phase Response'); grid
xlabel('w'); ylabel('Radians')
subplot(3,1,3); plot(db); grid; axis([0 500 -300 50]);
title('Log Magnitude Response'); xlabel('frequency in pi units');
ylabel('Decibels');




