% C'(x), i.e., derivative of C(x)
function y=zhaoming(x)
p1=2;p2=3;h1=5;h2=6;s=20;
y=(-3*p1*h1.*x)./((h1^2+x.^2).^(5/2))+3*p2*h2.*(s-x)./((h2^2+(s-x).^2).^(5/2)); 
