%% Question 4
Rp=1.1; As=51;
wp1 = 0.5*pi; ws1 = 0.56*pi; ws2 = 0.82*pi; wp2 = 0.88*pi;
[d1,d2] = db2delta(Rp,As);
weights = [d2/d1 1 d2/d1];
delta_f = min(abs(ws2-wp2)/(2*pi), abs(wp1-ws1)/(2*pi));
M = ceil((-20*log10(sqrt(d1*d2))-13)/(14.6*delta_f)+1);
M = 60;
l = 0:M;
f = [0 wp1 ws1 ws2 wp2 1*pi]./pi;
m = [1 1 0 0 1 1];

% Create Filter
h = firpm(M-1,f,m, weights);
[db,mag,pha,grd,w] = freqz_m(h,1);
[Hr,ww,a,L] = hr_type1(h);

% Check specs
delta_w = 2*pi/1000;
RpImpl = -min(db(1:1:wp1/delta_w)) % Actual Passband Ripple
AsImpl = -round(max(db(ws1/delta_w+1:1:ws2/delta_w))) % Min Stopband Attenuation 

%% Plots
subplot(4,1,1);plot(f,m); 
axis([0,1,-0.1,1.1]); title('Bandstop');
xlabel('frequency (pi)'); ylabel('Hr(k)'); grid;
subplot(4,1,2); stem(l,h); 
title('Impulse Response'); xlabel('n'); ylabel('h(n)');
subplot(4,1,3); plot(ww/pi,Hr); title('Amplitude Response');
xlabel('frequency in pi units'); ylabel('Hr(w)'); grid;
subplot(4,1,4);plot(w/pi,db);  grid;  hold on;
plot([0 1], -1.*[As As], '--r');
str1 = 'As = 52'; text(0.1,-40,str1);
title('Magnitude Response'); xlabel('frequency (pi)'); ylabel('dB');

%% Error Function
hrw = [ones(1,251) zeros(1,190) ones(1,60)]';
error = Hr-hrw; error(252:1:281) = NaN; error(411:1:441) = NaN;
figure; plot(ww/pi,error); hold on
axis([0,1,-0.1,0.1]); title('Error');
xlabel('frequency (pi)'); ylabel('H_d_r(w) - H_r(w)'); grid;