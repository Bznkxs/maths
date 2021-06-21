clear
% 柜台数据
X =[100  110  136  97  104  100  95  120  119  99 ...  
       126  113  115  108  93  116  102  122  121  122 ...
       118  117  114  106  110  119  127  119  125  119 ...
       105  95  117  109  140  121  122  131  108  120 ...
       115  112  130  116  119  134  124  128  115  110];
[N,Y]=hist(X)                                 % 频数表
hist(X),                                      % 直方图
x(1)=mean(X),x(2)=median(X)                       % 各个统计量
x(3)=range(X),x(4)=std(X)
x(5)=skewness(X),x(6)=kurtosis(X)



% 常用分布的概率函数
% f分布
doc fpdf
clear; close
x=0:0.01:5; y=fpdf(x,5,3); plot(x,y);

% 二项分布
x=binopdf(0:20,20,0.7); plot(x,'.')


% 随机数的生成
close; r=poissrnd(3,1,100); hist(r)

% 指数分布
close; a=2; n=1000; m=50; r=exprnd(a,1,n); [h1,h2]=hist(r,m);  hist(r,m);
hold on; x=0:0.01:max(r); y=exppdf(x,a); 
s=sum((h2(2)-h2(1))*h1);
plot(x,s*y,'r')



% Monte Carlo Method
% Calculate Pi = 3.14159...
clear all;
n=10000;
x=rand(2,n);
k=0;
for i=1:n
    if x(1,i)^2+x(2,i)^2<=1
        k=k+1;
    end
end
p=4*k/n


a=1.2; b=0.8; sx=0.6;sy=0.4;
n=100000;m=0;z=0; 
x=unifrnd(0,1.2,1,n);  y=unifrnd(0,0.8,1,n);
for i=1:n  
   u=0;
   if x(i)^2/a^2+y(i)^2/b^2<=1
      u=exp(-0.5*(x(i)^2/sx^2+y(i)^2/sy^2));
      z=z+u;   m=m+1;
   end
end
P=4*a*b*z/2/pi/sx/sy/n

clear
a=1.2; b=0.8; sx=0.6;sy=0.4;
n=100000;m=0;z=0; 
x=unifrnd(0,1.2,1,n);  y=unifrnd(0,0.8,1,n);
z=exp(-0.5*(x.^2/sx^2+y.^2/sy^2));  u=(x.^2/a^2+y.^2/b^2)<1;
P=4*a*b*sum(z.*u)/2/pi/sx/sy/n





