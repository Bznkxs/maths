function [p,time,err]=MCp(nn,xis,n)
%nn:矩阵阶数几十
%n：计算次数, xis：0~1稀疏度

A=rand(nn)>xis;
tic;
p(1)=Nperm(A);
time(1)=toc;
err(1)=0;

% GG estimator
tic;
for k=1:n
    C=rand(nn)>0.5;  C=2*C-1;
    B=A.*C;
    gg(k)=det(B)^2;
end
p(2)=mean(gg); 
time(2)=toc;
err(2)=(p(2)-p(1))/p(1)*100;

% KKLLL estimator
clear i;
tic;
for k=1:n
    C=rand(nn);
    C1=(-1/2+1i*sqrt(3)/2)*(C>2/3);
    C2=(-1/2-1i*sqrt(3)/2)*(C<1/3);
    CC=C1+C2+((C>1/3).*(C<2/3));
    B=A.*CC;
    kk(k)=abs(det(B))^2;
end
p(3)=mean(kk);
time(3)=toc;
err(3)=(p(3)-p(1))/p(1)*100;

end

