% function of C(x)
function y=zhaoming_fun(x)
p1=2;p2=3;h1=5;h2=6;s=20;
y=p1*h1./((h1^2+x.^2).^(3/2))+p2*h2./((h2^2+(s-x).^2).^(3/2));

