% 例1
H=[4 -3; -3 6];  c=[-3 1];
A1=[-2 1;1 -3]; b1=[3 3];
A2=[1 2]; b2=3; v1=[2,-Inf]; v2=[Inf,0];
[x,fv,ef,out,lag] = quadprog(H,c,A1,b1,A2,b2,v1,v2)
lag_eq=lag.eqlin
lag_ineq=lag.ineqlin
lag_low=lag.lower
lag_up=lag.upper


clear all;clc
x0=[1,-1];%初始点;
% x0=[-1,1];%初始点;
% opt1=optimoptions('fmincon','Algorithm','active-set','MaxFunEvals',20000,'MaxIter',3000);
% opt1=optimoptions('fmincon','Algorithm','interior-point','MaxFunEvals',20000,'MaxIter',3000);
opt1=optimoptions('fmincon','MaxFunEvals',20000,'MaxIter',3000);
[x,fv,ef,out,lag,grad,hess]=fmincon(@exam0902fun,x0,[],[],[],[],[],[],@exam0902con,opt1),
[c1,c2]=exam0902con(x)
pause
opt2=optimoptions(opt1,'GradObj','on','GradConstr','on','DerivativeCheck','on');
[x,fv,ef,out,lag,grad,hess]=fmincon(@exam0902fun,x0,[],[],[],[],[],[],@exam0902con,opt2),
[c1,c2]=exam0902con(x),


% 投资组合
clear; clc;
H0=[8 5 -20;5 72 -30;-20 -30 200];
A=[20 25 30;-5 -8 -10];
b=[5000 -1000];
x=quadprog(H0,[0 0 0],A,b)

clear; close;
H0=[8 5 -20;5 72 -30;-20 -30 200];
c=[-5 -8 -10];
A=[20 25 30];
b=5000;
opts=optimoptions('quadprog','Algorithm','interior-point-convex','Display','off');
for i=1:1000,
   beta=0.0001*i;
	H=beta*H0;
	x=quadprog(H,c,A,b,[],[],[0,0,0],[],[],opts);
	REV(i)=-c*x;                          % 计算期望收益
STD(i)=sqrt(x'*H0*x/2);          % 计算风险（均方差）
end
plot(REV,STD)                          % 画预期收益和均方差图形
xlabel('预期收益/百元')
ylabel('均方差/百元')
