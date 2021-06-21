function [L,U]=lu1(A)
% Gaussian Elimination
n=length(A); U=A; L=eye(n); kk=1;
for k=1:n-1
    if U(k,k)~=0
        b=U(k+1:n,k)/U(k,k);
        U(k+1:n,k:n)=U(k+1:n,k:n)-b*U(k,k:n);
        L(k+1:n,k)=b;
    else
       kk=0; disp('A is singular'); ; L=0; U=0;
       return;
    end
end
if U(n,n)==0
    disp('A is singular'); L=0; U=0;
end
    