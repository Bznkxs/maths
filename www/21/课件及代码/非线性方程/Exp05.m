% 显示函数
clear; close;
fplot(@(x)x.^6-2.*x.^4-6.*x.^3-13.*x.^2+8.*x+12,[-2,2.5])
hold on
fplot(@(t)0*ones(size(t)),[-2,2.5])
grid on

% 二分法，Newton法，牛顿割线法
%ff=x^6-2*x^4-6*x^3-13*x^2+8*x+12;
[x1,k1,r1]=bisect(@(x) x^6-2*x^4-6*x^3-13*x^2+8*x+12,-2,-1.5,1e-8);
[x2,k2,r2]=newton(@(x) x^6-2*x^4-6*x^3-13*x^2+8*x+12,@(x) 6*x^5-8*x^3-18*x^2-26*x+8,-2,10,1e-8);
[x3,k3,r3]=secant(@(x) x^6-2*x^4-6*x^3-13*x^2+8*x+12,-2,-1.9,10, 1e-8);
[x1;x2;x3]

[x1,k1,r1]=bisect(@(x) x.^2-5,2,3,1e-8);
[x2,k2,r2]=newton(@(x) x^2-5,@(x) 2*x,2,10,1e-8);
[x3,k3,r3]=secant(@(x) x^2-5,2,2.1,10, 1e-8);
[x1;x2;x3]


%fzero的实例

% 以下均可以得到实根2.0946
fzero(inline('x^3-2*x-5'),0)       % 初值取0
fzero(inline('x^3-2*x-5'),[1,3])	% 有根区间取[1，3]（区间端点必须异号）

%对于不连续的函数，这个点很可能只是一个间断点（且在该点两边，函数值异号）
fzero(@tan,[-1,1])         %将得到正切函数的零点（0）。但是，如果输入
fzero(@tan,[1,2])          %得到近似间断点1.5708(即pi/2).

%即使函数是连续函数而且有零点，但如果在该零点附近函数值没有变号，则fzero也找不到这个零点（除非输入的初值就是零点）。例如，
fzero(inline('x^2'),1)      %得到的输出为“NaN”。
	
%在输出列表中，’x’是变号点的近似值，’fv’是x点所对应的函数值，’ef’是程序停止运行的原因，
%’out’是一个结构变量，其中包含程序运行和停止时的一些相关信息。例如，
[x,fv,ef,out]=fzero(inline('x^3-2*x-5'),0)


% Newton法解非线性方程组
x=[1;1];
for k=1:5
    jx=2*[[x(1,k), x(2,k)]; [x(1,k), -x(2,k)]];
    fx=[x(1,k)^2+x(2,k)^2-4; x(1,k)^2-x(2,k)^2-1];
    dx=-jx\fx;
    x(:,k+1)=x(:,k)+dx;
end
x'


%解方程组的fsolve实例
x0=[1;1];                    % 初始值
[x,fv,ef,out,jac]=fsolve(@duoyuanfun,x0)

x0=[2,2];                     % 初始值
[x,fv,ef,out,jac]=fsolve(@duoyuanfun,x0)

opt=optimset('MaxIter',2);
[x2,fv2,ef2,out2,jac2]=fsolve(@duoyuanfun,x0,opt)


% 路灯照明
% plot the figures for C(x) and C'(x)
clear all
fplot(@zhaoming_fun,[0,20]);
grid;gtext('C(x)','Fontsize',20);
pause;
fplot(@zhaoming,[0,20]);
hold on;plot(0:0.01:20,0,'r');hold off;
grid;gtext('C''(x)','Fontsize',20);
pause;

x0=[0,10,20];xl=0;xr=20;
for k=1:3
	x(k)=fzero(@zhaoming,x0(k));
	c(k)=feval(@zhaoming_fun,x(k));
end
cl=zhaoming_fun(xl);
cr=zhaoming_fun(xr);
[xl,x,xr;cl,c,cr]



% 均相共沸例题
n=3;
P=760;
a=[16.388,16.268,18.607]';
b=[2787.50,2665.54,3643.31]';
c=[229.66,219.73,239.73]';
Q=[1.0    0.48   0.768
   1.55   1.0    0.544
   0.566  0.65   1.0];
XT0=[0.333,0.333,50];
[XT,Y]=fsolve(@junxiangfun,XT0,[],n,P,a,b,c,Q)


%种群增长（差分模型）
r=[0.3, 1.8, 2.2, 2.5, 2.55, 2.7];
x=0.1*ones(1,6)
for k=2:200  
    x(k,:)=x(k-1,:)+r.*x(k-1,:).*(1-x(k-1,:)); 
end
plot(x(:,5))

%混沌演示
chaos(@chaositer,0.5,[2,4,0.01],[100,200])


