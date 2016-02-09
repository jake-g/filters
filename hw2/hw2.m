%% Question 1
n = -10:0.1:10;
x = (0.6).^(abs(n));
X = fft(x, length(n));

% Plot
subplot(3,1,1); plot(n, x)
title('FFT of x(n)')
ylabel('Amplitude x(n)'); xlabel('n (time)');
subplot(3,1,2); plot(n, fftshift(abs(X)))
ylabel('Magnitude X(n)'); xlabel('n');
subplot(3,1,3); plot(n, fftshift(angle(X)))
ylabel('Phase X(n)'); xlabel('n');

%% Question 2
x = [5 -4 3];
N = 8;
X = fft(x, N);
Y = [X(1)];

for k = 1:N-1
    temp = X(N-k+1);
    Y = [Y, exp(1i*10*pi*k/N)*temp];
end

y = ifft(Y);

%% Question 3
N = 5;
x1 = [1 -1 1 -1];
x2 = [1 0 -1 0];
x3 = cconv(x1,x2,N);
x4 = conv(x1,x2);
% e = x3 - x4;

x = {x1 x2 x3 x4};
titl = ['1' '2' '3' '4']
for i = 1:length(x)
    str = sprintf('Plot of  x%s',titl(i));
    subplot(length(x),1,i); stem(x{i})
    title(str); xlabel('n'); ylabel('value'); xlim([0, 10])
end

%% Question 4
% n = 0:6;
% x = (1/3).^n;
% stem(n,x)

n = 0:6
X = (1/3)^n * exp(1i*2*pi
%% Question 5
n = 0:639; length(n)
bin = 1024;
x = 3*sin(0.12*pi*n)+0.4*sin(0.39*pi*n)+0.6*sin(0.72*pi*n);
h = [-0.033505 , 0.056152, 0.055155, 0.066329, 0.081606, 0.097049, ...
    0.11043, 0.1204, 0.12551, 0.12551, 0.1204, 0.11043, 0.097049, ...
    0.081606, 0.066329, 0.055155, 0.056152, - 0.033505];
y_conv = conv(x,h);

diff = bin - length(x);
if (bin > 0)
    x = [x zeros(1, diff)];
end
      
N = length(x);
y = zeros(1, length(h) + N - 1);
for i = 1:N/bin
tmp = conv(x((i*bin-bin+1):i*bin), h);
tmp_fpad = [zeros(1, (i*bin-bin)) tmp];
tmp_bpad = [tmp_fpad zeros(1, length(y) - length(tmp_fpad))];
y = y + tmp_bpad;
end


% Plot Results
figure(3)
y = y(1:length(y_conv));
subplot(3,1,1); plot(y)
title('Comparison of convolution methods')
xlabel('n (using overlap and add)')
ylabel('Signal')
subplot(3,1,2); plot(y_conv)
xlabel('n (using conv)')
ylabel('Signal')
subplot(3,1,3); plot(abs(y_conv - y))
xlabel('n')
ylabel('Error')



