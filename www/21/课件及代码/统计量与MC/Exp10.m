% 柜台数据
clear
X =[100  110  136  97  104  100  95  120  119  99 ...  
       126  113  115  108  93  116  102  122  121  122 ...
       118  117  114  106  110  119  127  119  125  119 ...
       105  95  117  109  140  121  122  131  108  120 ...
       115  112  130  116  119  134  124  128  115  110];
[N,Y]=hist(X);                                % 频数表
hist(X)                                       % 直方图
x(1)=mean(X);      x(2)=median(X);            % 各个统计量
x(3)=range(X);     x(4)=std(X);
x(5)=skewness(X);  x(6)=kurtosis(X);

% 甲乙两个班的成绩
clear; close;
a1=[92,69,88,86,85,88,92,78,95,79,79,68,84,88,87,87,88,55,65,93,93,...
    79,73,85,88,90,87,53,94,99,80,81];
a2=[84,83,82,85,82,81,82,90,84,78,75,83,78,85,84,79,85,73,90,77,...
    81,82,82,80,86,83,77,78];
subplot(1,2,1); hist(a1,6);axis([40 100 0 14])
subplot(1,2,2); hist(a2,3);axis([40 100 0 16])
x(1,1)=skewness(a1);  x(1,2)=kurtosis(a1);
x(2,1)=skewness(a2);  x(2,2)=kurtosis(a2);

% 常用分布的概率函数
y=normpdf(1.5,1,2)
y=normcdf([-1 0 1.5],0,2)
[m,v]=fstat(3,5)
x=tinv(0.3,10)

% f分布举例
doc fpdf
clear; close
x=0:0.01:5; y=fpdf(x,5,3); plot(x,y);

% 二项分布举例
x=binopdf(0:20,20,0.7); plot(x,'.')


% 随机数的生成，泊松分布举例
close; r=poissrnd(3,1,100); hist(r)

% 指数分布举例
close; a=2; n=1000; m=50; r=exprnd(a,1,n); 
[h1,h2]=hist(r,m);  hist(r,m);
hold on; 
x=0:0.01:max(r); y=exppdf(x,a); 
s=sum((h2(2)-h2(1))*h1);
plot(x,s*y,'r')



% Monte Carlo Method
% Calculate Pi = 3.14159...， 
% 1/4单位圆的面积， 在单位正方形中随机撒点，计算落在1/4单位圆内的比例
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

%讲义23页的MC算积分的例子
n=10000;
x=rand(n,2);
y=1-sqrt(x(:,1).*(2-x(:,1)));
m=sum(x(:,2)<y);

f=inline('1-sqrt(x.*(2-x))');  % inline object

[m/n, quad(f,0,1), 1-pi/4]



%炮弹命中率概率
a=1.2; b=0.8; sx=0.6;sy=0.4;
n=1e5; x1=(randn(n,2).^2)*[(0.6/a)^2;(0.4/b)^2]; p1=sum(x1<1)/n;

n=1e5;sx=0.6;sy=0.4;
x=unifrnd(0,a,1,n); y=unifrnd(0,b,1,n);
z=exp(-0.5*(x.^2/sx^2+y.^2/sy^2));
u=(x.^2/a^2+y.^2/b^2)<1;
p2=4*a*b*sum(z.*u)/2/pi/sx/sy/n;

% MC for permanent
nn=10;  %  the order of the matrix 
A=rand(nn)>0.4;
p(1)=Nperm(A);
n=1000;

% GG estimator
for k=1:n
    C=rand(nn)>0.5;  C=2*C-1;
    B=A.*C;
    gg(k)=det(B)^2;
end
p(2)=mean(gg); 

% KKLLL estimator
clear i;
for k=1:n
    C=rand(nn);
    C1=(-1/2+i*sqrt(3)/2)*(C>2/3);
    C2=(-1/2-i*sqrt(3)/2)*(C<1/3);
    CC=C1+C2+((C>1/3).*(C<2/3));
    B=A.*CC;
    kk(k)=abs(det(B))^2;
end
p(3)=mean(kk); p


