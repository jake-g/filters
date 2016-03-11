clear all; close all; clc
n = 50;
x = rand(n,1)*4 - 2;
P =  mean(x.^2);
Ns = [8 16 32];
deltas = 1./(10.*Ns.*P);

%% Create Black Box Filter
% Black Box
b = [1 4 -1];
a = [1 -0.3 0.1];
d = filter(b,a,x);

% Plots
% figure
% freqz(b,a)
% title('Filter Response')
figure
n_plts = 2+2*length(deltas);
subplot(n_plts,1,1); plot(x)
title('Random Input Data (x)'); grid;
xlabel('n'); ylabel('Amplitude');
subplot(n_plts,1,2); plot(d)
title('Unknown Filtered Data (d)'); grid;
xlabel('n'); ylabel('Amplitude');

%% Try each N for Adaptive Filter
for i = 1:length(Ns)
        N = Ns(i);
        del = deltas(i);
        
        %LMS Adaptive Filter
        h=zeros(N,1); %inital values: 0
        M=length(x); %number of samples of the input signal
        e = zeros(N,1);
        for n=N:M
            xvec=x(n:-1:n-N+1);
            e(n) = d(n) - h' * xvec;
            h=h + del * xvec * conj(e(n));
        end
        d_aprx = filter(h,1,x);

        % Error
        e = e(e~=0); % clean up 0s
        mse = immse(d,d_aprx);

%% Plots
subplot(n_plts,1,2+i*2-1); plot(d_aprx)
title(sprintf('Adaptive Filtered Data for N = %d, delta = %0.2d', N, del)); grid;
xlabel('n'); ylabel('Amplitude');

subplot(n_plts,1,2+i*2); plot(e.^2)
title(sprintf('Adaptive Filter Squared Error for N = %d, mse = %0.2d', N, mse)); grid;
xlabel('n'); ylabel('e^2');
end
