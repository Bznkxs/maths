close; clear;
n=30; 
m=n*n;  c=linspace(0,1,n+2); h=1/(n+1);
A=4*eye(m)+diag(-ones(m-1,1),1)+diag(-ones(m-1,1),-1)+...
    diag(-ones(m-n,1),n)+diag(-ones(m-n,1),-n);
for k=2:n-1
    A((k-1)*n+1,(k-1)*n)=0; 
    A(k*n,k*n+n)=0;
end
A(n*(n-1)+1,n*(n-1))=0;
A(n,n+n)=0;

xx=c(2:n+1)'*ones(1,n); 
yy=ones(n,1)*c(2:n+1); 
zz=2*pi.^2*sin(pi*xx).*sin(pi.*yy);
b=h^2*reshape(zz,m,1);

r=A\b; r=reshape(r,n,n); 
r=[zeros(1,n+2);zeros(n,1),r,zeros(n,1);zeros(1,n+2)];

[X,Y]=meshgrid(c, c);  
mesh(X,Y,r);
