% ��1��min 3sinx+x;
clear all;clc;
x1=1;x2=8;
f=inline('3*sin(x)+x');
[x,fv]=fminbnd(f,x1,x2);
[x1,fv1,ef,out]=fminbnd('3*sin(x)+x',1,8);
[x,x1;fv,fv1]

options = optimset('Display','iter');
[x2,fv2]=fminbnd(inline('3*sin(x)+x'),1,8,options); %��ʾ��������
%[x,fval,exitflag,output]=fminbnd('3*sin(x)+x',1,8);

% ��2�� min x^2/2+y^2/2;
a=2; b=2; x0=[1,1];
[x1,f1,e1,out1]=fminunc(@exam0702fun,x0,[],a,b)
% fminsearch: Find minimum of unconstrained multivariable 
% function using derivative-free method
[x2,f2,e2,out2]=fminsearch(@exam0702fun,x0,[],a,b)

% ������4�� min x^2/10+y^2; ���ƾ���
clear all
a=10;b=1;x0=[1,1]; %��ʼֵ
opt=optimset('fminunc'); % ����fminuncȱʡ�Ŀ��Ʋ���
opt=optimset(opt,'Disp','iter'); %�趨����м���
opt=optimset(opt,'tolx',1e-8,'tolf',1e-8); %�趨���ƾ���
% opt=optimset(opt,'LargeScale','off', 'MaxFunEvals',1000,'HessUpdate','steepdesc');
[x,f,ef,out]=fminunc(@exam0702fun,x0,opt,a,b)


% ������5��Rosenbrock����
% ��ͼ����άͼ��ȸ���ͼ
[x,y]=meshgrid(-2:0.05:2,-1:0.05:3);
z=10*(y-x.^2).^2+(1-x).^2;
subplot(1,2,1); mesh(x,y,z)
subplot(1,2,2); contour(x,y,z,50)

% ��ֵ�ݶ�
% comparing different algorithms: without using gradient vector
format short e
x0=[-1.9,2];
'---case1: bfgs, hybrid 2,3 poly-------'
opt1=optimset('LargeScale','off', 'MaxFunEvals',1000);
%opt1=optimset(opt1,'tolx',1e-8,'tolf',1e-8);
[x1,v1,exit1,out1]=fminunc(@exam0705fun,x0,opt1)
pause
'---case2:  dfp, hybrid 2,3 poly-------'
fopt=optimset(opt1,'HessUpdate','dfp');
[x2,v2,exit2,out2]=fminunc(@exam0705fun,x0,fopt)
pause
'---case3: steep, hybrid 2,3 poly-------'
fopt=optimset(opt1,'HessUpdate','steepdesc');
[x3,v3,exit3,out3]=fminunc(@exam0705fun,x0,fopt)
pause
'++++    results of solutions ++++++'
solutions=[x1;x2;x3];
funvalues=[v1;v2;v3];
iterations=[out1.funcCount;out2.funcCount;out3.funcCount];
rr1=[solutions,funvalues,iterations]

% ��5 Rosenbrock������⣬���÷�������������ȷ�ݶ�
% comparing different algorithms: using gradient vector
format short e
x0=[-1.9,2];
'---case1: bfgs, hybrid 2,3 poly-------'
opt1=optimset('LargeScale','off', 'MaxFunEvals',1000,'GradObj','on');
[x1,v1,exit1,out1]=fminunc(@exam0705grad,x0,opt1)
pause
'---case2:  dfp, hybrid 2,3 poly-------'
fopt=optimset(opt1,'HessUpdate','dfp');
[x2,v2,exit2,out2]=fminunc(@exam0705grad,x0,fopt)
pause
'---case3: steep, hybrid 2,3 poly-------'
fopt=optimset(opt1,'HessUpdate','steepdesc');
[x3,v3,exit3,out3]=fminunc(@exam0705grad,x0,fopt)
solutions=[x1;x2;x3];
funvalues=[v1;v2;v3];
iterations=[out1.funcCount;out2.funcCount;out3.funcCount];
rr2=[solutions,funvalues,iterations]

%Լ���Ż�
% ��1
H=[4 -3; -3 6];  c=[-3 1];
A1=[-2 1;1 -3]; b1=[3 3];
A2=[1 2]; b2=3; v1=[2,-Inf]; v2=[Inf,0];
[x,fv,ef,out,lag] = quadprog(H,c,A1,b1,A2,b2,v1,v2)
lag_eq=lag.eqlin
lag_ineq=lag.ineqlin
lag_low=lag.lower
lag_up=lag.upper


clear all;clc
x0=[1,-1];%��ʼ��;
%x0=[-1,1];%��ʼ��;
opt1=optimoptions('fmincon','Algorithm','active-set','MaxFunEvals',20000,'MaxIter',3000);
%opt1=optimoptions('fmincon','Algorithm','interior-point','MaxFunEvals',20000,'MaxIter',3000);
%opt1=optimoptions('fmincon','MaxFunEvals',20000,'MaxIter',3000);
[x1,fv1,ef1,out1,lag1,grad1,hess1]=fmincon(@exam0902fun,x0,[],[],[],[],[],[],@exam0902con,opt1),
[c1,c2]=exam0902con(x1)
pause
opt2=optimoptions(opt1,'GradObj','on','GradConstr','on','DerivativeCheck','on');
[x2,fv2,ef2,out2,lag2,grad2,hess2]=fmincon(@exam0902fun,x0,[],[],[],[],[],[],@exam0902con,opt2),
[c3,c4]=exam0902con(x2),


% Ͷ�����
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
	REV(i)=-c*x;                          % ������������
STD(i)=sqrt(x'*H0*x/2);          % ������գ������
end
plot(REV,STD)                          % ��Ԥ������;�����ͼ��
xlabel('Ԥ������/��Ԫ')
ylabel('������/��Ԫ')

