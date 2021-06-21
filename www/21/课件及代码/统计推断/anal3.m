clc,close all

x1=[14.6,14.7,15.1,14.9,14.8,15.0,15.1,15.2,14.8];
x2=[15.2,15.1,15.4,14.9,15.3,15.0,15.2,14.8,15.7,15.0];

figure,histogram(x1,5),
figure,histogram(x2,5)

alpha=0.1;
y=(std(x1)/std(x2))^2;
fcdf(y,8,9)
finv(alpha/2,8,9)
finv(1-alpha/2,8,9)

m=9;n=10;
ss2=((m-1)*std(x1)^2+(n-1)*std(x2)^2)/(m+n-2);
tt=(mean(x1)-mean(x2))/(sqrt(1/m+1/n))/sqrt(ss2);

tinv(1-alpha,m+n-2)
tinv(alpha,m+n-2)
tinv(1-alpha/2,m+n-2)



