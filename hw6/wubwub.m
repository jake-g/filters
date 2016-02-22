fs = 8000;         
f0 = 2*[180 187];   
fr = f0/fs;           
t= (1:1:50000);

spectral = sum(cos(2*pi*fr(:)*t));
soundsc(spectral)