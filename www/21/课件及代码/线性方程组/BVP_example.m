clear; close
h=0.01; x=1:h:2;
y0=1/2; yn=4+4*log(2);
%y0=1/2; yn=6;
n=length(x); n=n-1;
p=2./x; q=-6./(x.^2);
r=5-6*x+7*x.^2;

b=-2+h^2*q(2:n); 
a=1-h*p(2:n)/2; 
c=1+h*p(2:n)/2;
d=h^2*r(2:n);
d(1)=d(1)-a(1)*y0; 
d(n-1)=d(n-1)-c(n-1)*yn;

A=diag(b)+diag(a(2:n-1),-1)+diag(c(1:n-2),1);

y=[y0; A\d'; yn];  plot(x,y);

z=x.^2-x.^3+(x.^4)/2+(x.^2).*log(x);
hold on; plot(x,z,'r')