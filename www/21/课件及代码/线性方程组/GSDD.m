function [xG,k,XX,rho]=GSDD(A,b,m,tol)
% Gauss-Seidel iteration
n=length(A);  D=diag(diag(A));
L=tril(A);  U=-(triu(A)-D);

fG=L\b;   
BG=L\U;  % Gauss-Seidel 迭代矩阵
rho=max(abs(eig(BG)));

xG=ones(n,1); XX=xG;

k=0;
while norm(A*xG-b)/norm(b)>tol && k<m  % 设置精度要求 
    k=k+1;  % 记录迭代次数
    xG=BG*xG+fG;
    XX=[XX,xG];
end

