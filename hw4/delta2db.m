%% delta2db (Question 1.1)

function [Rp, As] = delta2db(delta1, delta2)
    % Converts asbsolute specs deltga1 and delta2 into dB specs Rp and As
    % [Rp, As] = delta2db(delta1, delta2)
    
    Rp = -20*log10((1-delta1)/(1+delta1));
    As = -20*log10((delta2)/(1+delta1));

end

% 
% [R, A] = delta2db(0.0144, 0.0032)
% 
% R =
% 
%     0.2502
% 
% 
% A =
% 
%     0.0556
% Rp = Passband ripple

% As = Stopband attenuation

% d1 = Passband tolerance

% d2 = Stopband tolerance
