%% Question 2

ws1=0.8*pi; wp1=0.4*pi; wp2=0.5*pi; wp3=0.7*pi;
M = 40; alpha = (M-1)/2; l = 0:M-1; wl = (2*pi/M)*l;
 d1 = 0.1; d2 = 0.05;
[Rp,As] = delta2db(d1,d2);
weights = [d2/d1 d2/d1 1];
delta_f = min(abs(wp1-wp2)/(2*pi), abs(wp3-ws1)/(2*pi));
M = ceil((-20*log10(sqrt(d1*d2))-13)/(14.6*delta_f)+1);
f = [0 wp1 wp2 wp3 ws1 1*pi]./pi;
m = [0.45 0.45 1 1 0 0];
h = remez(M-1,f,m,weights);
l = 0:M-1;
[db,mag,pha,grd,w] = freqz_m(h,1);
[Hr,ww,a,L] = hr_type1(h);
delta_w = 2*pi/1000;
M

%% Plots
subplot(4,1,1);plot(f,m); 
axis([0,1,-0.1,1.1]); title('Multi Band Filter');
xlabel('frequency in pi units'); ylabel('Hr(k)'); grid;
subplot(4,1,2); stem(l,h); axis([-1,M,-0.3,0.8])
title('Impulse Response'); xlabel('n'); ylabel('h(n)');
subplot(4,1,3); plot(ww/pi,Hr);
axis([0,1,-0.1,1.1]); title('Amplitude Response');
xlabel('frequency in pi units'); ylabel('Hr(w)'); grid;
subplot(4,1,4);plot(w/pi,db); axis([0,1,-100,10]); grid;
title('Magnitude Response'); xlabel('frequency in pi units');
ylabel('Decibels');