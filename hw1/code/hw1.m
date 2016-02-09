clear all; close all

%% Part 1
figure(1)
n = 0:20;
x = (0.9).^n;
n = -20:0;
y = (0.8).^-n;
% rxx
rxx = conv_m(x, n, fliplr(x), n);
plot(rxx); hold on
% rxy
ryy = conv_m(x, n, fliplr(y), n);
plot(ryy)

title('r_x_x and r_y_y correlation')
xlabel('n')
ylabel('correlation')

%% Part 2
figure(2)
w = -pi:0.00001:pi;
H = 0.9*exp(1i*w)./(1-0.9*exp(1i*w)) + 1./(1-0.9*exp(-1i*w));
subplot(2,1,1); plot(abs(H), 'b')
title('Magnitude and Phase of H(e^j^w))')
ylabel('Magnitude')
subplot(2,1,2); plot(angle(H), 'r')
ylabel('Phase')
xlabel('Frequency (rad/sec)')

%% Part 3
syms n
z_tran = ztrans(2*dirac(n-2) + 3*heaviside(n-3));

N = [0 0 2 1]; 
D = [1 -1 0 0]
[ z, p, k ] = pz(N, D)

%% Part 4
N = [1 1];
D = [1 -0.5];
[ z, p, k ] = pz(N, D)


%% Part 5

figure(3)
n= -100:0.1:100;
w = 100*n*2*pi/length(n);
x = heaviside(n)-heaviside(n-50);
x_shif = x.*exp(1i*pi/3*n);
x_shif2 = x.*exp(1i*pi/3*n);

% plots
subplot(5,1,1); plot(n, x)
title('Shifting rect in frequency domain')
xlabel('n')
ylabel('Magnitude')
subplot(5,1,2); plot(n, x_shif)
xlabel('n (times exp)')
ylabel('Magnitude')

X = fftshift(fft(x));
X_shif = fftshift(fft(x_shif));
X_shif2 = fftshift(fft(x_shif2));

% plots
subplot(5,1,3); plot(w, abs(X))
xlabel('w')
xlim([-2*pi, 2*pi])
ylabel('Magnitude')
subplot(5,1,4); plot(w, abs(X_shif));
xlabel('w (shifted pi/3')
xlim([-2*pi, 2*pi])
ylabel('Magnitude')
subplot(5,1,5); plot(w, abs(X_shif));
xlabel('w (shifted 11*pi/3)')
xlim([-2*pi, 2*pi])
ylabel('Magnitude')


