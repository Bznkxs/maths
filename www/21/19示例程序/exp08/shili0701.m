x0=[50,70];
x1=fminunc(@shili0701fun,x0),
z1=-shili0701fun(x1)

x2=fminsearch(@shili0701fun,x0),
z2=-shili0701fun(x2)

x0=[200,200];
x3=fminunc(@shili0701fun,x0),
z3=-shili0701fun(x3)

x4=fminsearch(@shili0701fun,x0),
z4=-shili0701fun(x4)
