clear,clc
%% MC direct
n=1e5;rho=0.4;sx=80;sy=50;R=100;
rrr=mvnrnd([0,0],[sx^2,rho*sx*sy;rho*sx*sy,sy^2],n);
x1=(rrr.^2)*[1;1];
p1=sum(x1<R^2)/n;
%% MC integral
pfun=@(x,y) ((x.^2+y.^2)<R.^2).*1./(2.*pi.*sx.*sy.*sqrt(1-rho.^2)).*...
    exp(-0.5./(1-rho.^2).*...
    (x.^2./sx.^2+y.^2./sy.^2-2.*rho.*x.*y./sx./sy));
x=unifrnd(-R,R,1,n); y=unifrnd(-R,R,1,n);
z=feval(pfun,x,y);
u=(x.^2+y.^2)<R^2;
p2=4*R^2*sum(z.*u)/n;


%% integral
p3=integral2(pfun,-R,R,-R,R,'RelTol',1e-4);
% p3a=integral2(pfun,0,R,0,R,'RelTol',1e-4);
% p3b=integral2(pfun,0,R,-R,0,'RelTol',1e-4);
% p3c=integral2(pfun,-R,0,0,R,'RelTol',1e-4);
% p3d=integral2(pfun,-R,0,-R,0,'RelTol',1e-4);







