clear,clc,close all

%% test
A=hilb(5);
[L,U,P]=lu(A);
[norm(L*U-A), norm(L*U-P*A)]

[norm(A), norm(A,1), norm(A,inf)]  %norm-1:元素之和最大的列 -inf:最大的行
[cond(A), cond(A,1), cond(A,inf)]   %A的范数乘以A逆的范数
eig(A)

b=A*ones(5,1);
A\b

%% test solve
n=100; A=hilb(n); b=A*ones(n,1);
norm(pcg(A,b)-ones(n,1))
norm(A\b-ones(n,1))

%% 2
clear,clc,close all
A1=[1 -9 -10;-9 1 5;8 7 1];
b1=[1;0;4];
A2=[5 -1 -3;-1 2 4;-3 4 15];
b2=[-1;0;4];
A3=[10 4 5;4 10 7;5 7 10];
b3=[-1;0;4];

tol=1e-4;
m=1e4;
[xJ1,kJ1,XXJ1,rhoJ1]=JacDD(A1,b1,m,tol);
[xG1,kG1,XXG1,rhoG1]=GSDD(A1,b1,m,tol);
xGL1=A1\b1;

[xJ2,kJ2,XXJ2,rhoJ2]=JacDD(A2,b2,m,tol);
[xG2,kG2,XXG2,rhoG2]=GSDD(A2,b2,m,tol);
xP2 = pcg(A2,b2,1e-4,100);
xGL2=A2\b2;

[xJ3,kJ3,XXJ3,rhoJ3]=JacDD(A3,b3,m,tol);
[xG3,kG3,XXG3,rhoG3]=GSDD(A3,b3,m,tol);
xP3 = pcg(A3,b3,1e-4,100);
xGL3=A3\b3;

figure,plot(1:length(XXG1),XXG1),legend;
figure,plot(1:length(XXG2),XXG2),hold on,
plot(1:length(XXJ2),XXJ2),legend('G1','G2','G3','J1','J2','J3');
figure,plot(1:length(XXG3),XXG3),
legend('G1','G2','G3');

%% 3
clear,clc,close all
A=[-4 1 1 1;1 -4 1 1;1 1 -4 1;1 1 1 -4];
b=ones(4,1);
m=1e3;
tol=1e-6;
w=[0.75 1 1.25 1.5];
xa=A\b;
[xS1,k1,XX1]=SORDD(A,b,m,tol,w(1));
[xS2,k2,XX2]=SORDD(A,b,m,tol,w(2));
[xS3,k3,XX3]=SORDD(A,b,m,tol,w(3));
[xS4,k4,XX4]=SORDD(A,b,m,tol,w(3));

for i=1:4
    figure,plot(1:length(XX1),XX1(i,:)),hold on,
    plot(1:length(XX2),XX2(i,:)),
    plot(1:length(XX3),XX3(i,:)),
    plot(1:length(XX4),XX4(i,:)),
    legend('\omega=0.75','\omega=1',...
        '\omega=1.25','\omega=1.5');
end









