function [r,k,x]=newton(fv,df,x0,n,tol)
%df是fv的导数
x(1)=x0; b=1; k=1;
while or(k==1,abs(b)>tol*abs(x(k)))
    x(k+1)=x(k)-feval(fv,x(k))/feval(df,x(k));
    b=x(k+1)-x(k);
    k=k+1;
    if(k>n)
        error('Error: Reached maximum iteration times');
    end
end
r=x(k-1);
