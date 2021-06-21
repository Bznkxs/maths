clear,clc,close all

%% 2
A1=[1e-13,1;2,3];
b=sum(A1,2);
[L1,U1]=lu1(A1);
x1=inv(U1)*inv(L1)*b
x2=A1\b

%% 2b
A2=[1e-13,1,2;2,1e-13,3;2,1,1e-13];
b2=sum(A2,2);
[L2,U2]=lu1(A2);
x1=inv(U2)*inv(L2)*b2
x2=A2\b2




