function [ z, p, k ] = pz( b, a )
%PZ Summary of this function goes here
%   Detailed explanation goes here

fvtool(b,a,'polezero')
[b,a] = eqtflength(b,a);
[z,p,k] = tf2zp(b,a);
text(real(z)+.1,imag(z),'Zero')
text(real(p)+.1,imag(p),'Pole')

end

