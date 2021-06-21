clear;clc
syms x
f1(x)=exp(3.*x).*sin(2.*x);
f1d=diff(f1);
f1dd=diff(f1d);
f1ddd=diff(f1dd);
f1dddd=diff(f1ddd);

f2(x)=sqrt(1+x.^2);
f2d=diff(f2);
f2dd=diff(f2d);
f2ddd=diff(f2dd);
f2dddd=diff(f2ddd);
max(double(f1dd(0:1e-3:2)))
max(double(f1dddd(0:1e-3:2)))
max(double(f2dd(0:1e-3:2)))
max(double(f2dddd(0:1e-3:2)))

