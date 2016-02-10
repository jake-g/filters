%% Question 4


Rp=1.1; As=51;
wp1 = 0.5; ws1 = 0.56; ws2 = 0.82; wp2 = 0.88;
[d1,d2] = db2delta(Rp,As);
d_max = max(d1,d2); d_min = min(d1,d2);
weights = [d2/d1 1 d2/d1];
M = length(h); l = 0:M-1;
f = [0 wp1 ws1 ws2 wp2 1];
a = [1 1 0 0 1 1];

% Create Filter
b = firpm(M-1,f,a, weights);
[db,mag,pha,grd,w] = freqz_m(b,1);
[Hr,ww,a,L] = hr_type1(h);

% Check specs
delta_w = 2*pi/1000;
RpImpl = -min(db(1:1:wp1/delta_w)) % Actual Passband Ripple
AsImpl = -round(max(db(ws1/delta_w+1:1:ws2/delta_w))) % Min Stopband Attenuation 

%% Plots
subplot(4,1,1);plot(f,m); 
axis([0,1,-0.1,1.1]); title('Lowpass: M=60,T1=0.39');
xlabel('frequency (pi)'); ylabel('Hr(k)'); grid;
subplot(4,1,2); stem(l,h); 
title('Impulse Response'); xlabel('n'); ylabel('h(n)');
subplot(4,1,3); plot(ww/pi,Hr); title('Amplitude Response');
xlabel('frequency in pi units'); ylabel('Hr(w)'); grid;
subplot(4,1,4);plot(w/pi,db);  grid;
title('Magnitude Response'); xlabel('frequency (pi)'); ylabel('dB');

%% Error Function
hrw = [ones(1,251) zeros(1,190) ones(1,60)]';
error = Hr-hrw; error(252:1:281) = NaN; error(411:1:441) = NaN;
figure; plot(ww/pi,error); hold on
axis([0,1,-0.1,0.1]); title('Error');
xlabel('frequency (pi)'); ylabel('H_d_r(w) - H_r(w)'); grid;