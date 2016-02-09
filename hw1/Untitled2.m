
syms n z a w

f=dirac(n);
ztrans(f,z)

f=heaviside(n) 
ztrans(f,z)

ztrans(n,z)

F=z/(z-a);
f=iztrans(F,n)

f=n*a^n;
ztrans(f,z)

f=cos(w*n)
ztrans(f,z)

f=sin(w*n);
ztrans(f,z)

f=(a^n)*cos(w*n)
ztrans(f,z)
simplify(ans)

f=(a^n)*sin(w*n);
ztrans(f,z)
simplify(ans)