
%% Homework 7
T = [1 1/8000]; % part 1 and part 2
fs  = 8000;
wp = 3200*2*pi/fs;
ws = 3800*2*pi/fs;
Rp = 0.5;
As = 45;

%% Q1 : Impulse Invariance
for i = 1:length(T)
    Op = wp/T(i)
    Os = ws/T(i)

    [cs, ds] = afd_chb1(Op, Os, Rp, As);
    [b, a] = imp_invr(cs, ds, T(i));
    [C, B, A] = dir2par(b, a);
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
Op = (2/T(1))*tan(wp/2);
Os = (2/T(1))*tan(ws/2);

[cs, ds] = afd_chb1(Op, Os, Rp, As);
[b, a] = bilinear(cs, ds, 1/T(1));
[C, B, A] = dir2cas(b, a);
[db,mag,pha,grd,w] = freqz_m(b, a);

%% Plots
figure; 
% subplot(4,1,3); 
plot(db, w); grid;
title('Log Magnitude Response'); xlabel('frequency in pi units');
ylabel('Decibels');

%----------------------------------compare to analog