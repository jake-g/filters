% Use the Parks-McClellan algorithm to design an FIR bandpass filter of order 
% 17. Specify normalized stopband frequencies of  $0.3\pi$ and  $0.7\pi$ 
% rad/sample and normalized passband frequencies of  $0.4\pi$ and  $0.6\pi$
% rad/sample. Plot the ideal and actual magnitude responses.

f = [0, 0.5, 0.56, 0.82 0.88, 1];
a = [1 1 0 0 1 1];
b = firpm(20,f,a);

[h,w] = freqz(b,1,512);
plot(f,a,w/pi,abs(h))
legend('Ideal','firpm Design')
xlabel 'Radian Frequency (\omega/\pi)', ylabel 'Magnitude'