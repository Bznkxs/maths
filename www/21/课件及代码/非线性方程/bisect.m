function [x,k,r]=bisect(ff,a,b,err)
% ���ַ���� ff(x)=0
% x:���ƽ⣻ k�����ִ����� r�����ֹ���

k=0;
r=[];
 
while b-a>err
    f1=feval(ff,a); f2=feval(ff,b);
    r=[r;[a,b,f1,f2]];
    c=(a+b)/2; f3=feval(ff,c);  k=k+1;
    if  f1*f3<0    
        b=c;    
    else
        a=c;   
    end
end
 
x=(a+b)/2;