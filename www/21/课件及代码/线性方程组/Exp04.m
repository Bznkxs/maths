A=rand(4);
[L,U,P]=lu(A);  % L*U=P*A
[L1,U1]=lu(A);        % L1*U1=A,   L1=P'*L, U1=U;

% n=16000; A=rand(n); b=A*ones(n,1);
% tic; x=A\b; toc  151.229579s

A=hilb(5);
[norm(A), norm(A,1), norm(A,inf)]
[cond(A), cond(A,1), cond(A,inf)]
eig(A)

% 高斯消去求解病态方程
n=20; A=hilb(n); b=A*ones(n,1); 
norm(A\b-ones(n,1))

norm(pcg(A,b)-ones(n,1)),

n=100; A=hilb(n); b=A*ones(n,1);
norm(pcg(A,b)-ones(n,1))

%高斯消去对稀疏性的破坏
clear; close; n=400; 
A=rand(n).*(rand(n)>0.99);
subplot(1,2,1);spy(A)
[L,U,P]=lu(A);
subplot(1,2,2); spy(U)

% 迭代法的比较

A=[10 3 1; 2 -10 3; 1 3 10]; b=[14;-5;14];

A=[4 -2 1; -2 4 -1;1 -1 4]; m=3;
[x1,k1]=JacDD(A,b,m,1e-7);
[x2,k2]=GSDD(A,b,m,1e-7);

[x1,k1]=JacDD(A,b,100,1e-7);
[x2,k2]=GSDD(A,b,100,1e-7);
[x3,k3]=SORDD(A,b,100,1e-7,1.2);

A=[4 -2 1;-2 4 -1; 1 -1 4]; b=[3;3;11];
[x1,k1]=JacDD(A,b,3,1e-7);
[x2,k2]=GSDD(A,b,3,1e-7);
[x3,k3]=SORDD(A,b,3,1e-7,1.2);

% 松弛因子的影响
w=1:0.01:2;

for k=1:101
    [x,kn]=SORDD(A,b,100,1e-7,w(k));
    num(k)=kn;
end

plot(w,num)  % 达到1e-7 所需迭代步数与松弛因子的关系


% Hilbert矩阵条件数随阶数的增长
for k=1:10 
    c(k)=cond(hilb(k));
end
close; plot(1:10, log(c))


% 病态方程的计算， 以Hilbert矩阵为例
n=100; A=hilb(n); b=A*ones(n,1);

x1=A\b; [max(x1),min(x1)]
    
[x2,k]=JacDD(A,b,100,1e-2);  % 发散
[x3,k]=GSDD(A,b,100,1e-2);  [max(x3),min(x3)]  % 收敛
[x3,k]=GSDD(A,b,10000,1e-6);  [max(x3),min(x3)]
[x4,k]=SORDD(A,b,10000,1e-6,1.2);

[x,flag,res,k] = pcg(A,b,1e-6);  % 更有效的动态迭代方法


% 稀疏矩阵
n=4000;b=[1:n]';
a1=sparse(1:n,1:n,4,n,n);
a2=sparse(2:n,1:n-1,1,n,n);
a=a1+a2+a2';
m1=1000; m2=10;
tic;
for k=1:m1
    x=a\b;
end
t(1)=toc/m1;
aa=full(a);
tic;for k=1:m2 xx=aa\b; end; t(2)=toc/m2;
norm(x-xx,1)


% 投入产出分析
A=[0.159 0.047 0.08 0.008 0.054 0.002;
    0.171 0.512 0.502 0.257 0.238 0.226;
    0.002 0.001 0.001 0.013 0.01 0.023;
    0.021 0.031 0.045 0.104 0.029 0.027;
    0.027 0.045 0.049 0.027 0.056 0.05;
    0.05 0.076 0.095 0.143 0.094 0.1];
d=[1500 4200 3000 500 950 3000]';
B=eye(6)-A;
x=B\d
c=inv(B)


