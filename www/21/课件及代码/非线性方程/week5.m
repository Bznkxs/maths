clear,clc,close all
fun1 = @(x) sin(x)-0.5*x.^2;
fun1d=@(x) cos(x)-x;
PHI=@(x) x-(sin(x)-x.^2/2)./(cos(x)-x)-((sin(x)-x.^2/2).^2.*(-sin(x)-1))./(2*(cos(x)-x).^3);
FI=@(I) (15e4-1e3/I).*(1+I).^180+1e3./I;
FI2=@(I) (50e4-4500/I).*(1+I).^180+4500./I;
FI3=@(I) (50e4-45e3/I).*(1+I).^20+45e3./I;

%% fzero
iter=zeros(1,198);
sol=zeros(1,198);
options = ...
    optimset('FunValCheck','on','Display','final','TolX',1e-10);
for x0=-5:0.1:14.7
    fprintf('Xo=%.1f',x0);
    [x,fval,exitflag,output]=fzero(fun1,x0,options);
    fprintf('iter:%d\nsol=%.3f\n-------------------\n',output.iterations,x);
    iter(round((x0+5)/0.1+1))=output.iterations;
    sol(round((x0+5)/0.1+1))=x;
end

figure,stairs(-5:0.1:14.7,iter),
hold on,stairs(-5:0.1:14.7,sol),
legend('iter','sol'),ylim([-2 15])
%% fsolve
span=[2,1e7:1e7:1e9];
iter=zeros(1,101);
sol=zeros(1,101);
options = ...
    optimoptions('fsolve','FunValCheck','on','Display','off','OptimalityTolerance',1e-10);
index=0;
for x0=span
    index=index+1;
    fprintf('Xo=%.1f\n',x0);
    [x,fval,exitflag,output]=fsolve(fun1,x0,options);
    fprintf('iter:%d\nsol=%.3f\n-------------------\n',output.iterations,x);
    iter(index)=output.iterations;
    sol(index)=x;
end

figure,stairs(span,iter),
hold on,stairs(span,sol-sol(1)),
legend('iter','sol')%,ylim([-2 15])
%% test
clc
for x0=[-2:0.1:2]
    %     index=index+1;
    fprintf('Xo=%.1f\n',x0);
    [x,fval,exitflag,output]=fsolve(fun1,x0,options);
    fprintf('iter:%d\nsol=%.3f\n-------------------\n',output.iterations,x);
    %     iter(index)=output.iterations;
    %     sol(index)=x;
end

%% DIY
span=-10:0.1:10;
itera=zeros(1,length(span));
sol=zeros(1,length(span));
index=1;
for x0=span
    fprintf('Xo=%.1f, ',x0);
    xold=x0;flag=0;delta=1;iter=0;
    while(delta>1e-11)
        if flag
            xold=xnew;
        end
        xnew=feval(PHI,xold);
        delta=abs(xnew-xold);
        flag=1;
        iter=iter+1;
    end
    fprintf('iter=%d, x=%.3f\n------------------\n',iter,xnew);
    itera(index)=iter;
    sol(index)=xnew;
    index=index+1;
end
figure,stairs(span,itera),hold on,
stairs(span,sol)
%% Newton
span=-10:0.1:10;
iterN=zeros(1,length(span));
solN=zeros(1,length(span));
index=1;
for x0=span
    fprintf('Xo=%.1f, ',x0);
    [r,k]=newton(fun1,fun1d,x0,1e5,1e-10);
    fprintf('iter=%d, x=%.3f\n------------------\n',k,r);
    iterN(index)=k;
    solN(index)=r;
    index=index+1;
end
figure(1),stairs(span,iterN),stairs(span,solN),
legend('iter-mod','sol-mod','iter-Newton','sol-Newton'),
ylim([-2 14])
%% 3
span=0.05;
iter=zeros(1,length(span));
sol=zeros(1,length(span));
options = ...
    optimoptions('fsolve','FunValCheck','on','Display','off','OptimalityTolerance',1e-10);
index=0;
for x0=span
    index=index+1;
    fprintf('Xo=%.2f\n',x0);
    [x,fval,exitflag,output]=fsolve(FI,x0,options);
    fprintf('iter:%d\nsol=%.3f\n-------------------\n',output.iterations,x);
    iter(index)=output.iterations;
    sol(index)=x;
end
%% 3b
span=0.05;
iter=zeros(1,length(span));
sol=zeros(1,length(span));
options = ...
    optimoptions('fsolve','FunValCheck','on','Display','off','OptimalityTolerance',1e-10);
index=0;
for x0=span
    index=index+1;
    fprintf('Xo=%.2f\n',x0);
    [x,fval,exitflag,output]=fsolve(FI2,x0,options);
    fprintf('iter:%d\nsol=%.3f\n-------------------\n',output.iterations,x);
    iter(index)=output.iterations;
    sol(index)=x;
end
for x0=span
    index=index+1;
    fprintf('Xo=%.2f\n',x0);
    [x,fval,exitflag,output]=fsolve(FI3,x0,options);
    fprintf('iter:%d\nsol=%.3f\n-------------------\n',output.iterations,x);
    iter(index)=output.iterations;
    sol(index)=x;
end
%% 4
clear,clc,close all
L=25.4;r=2;
Vset=[10 50 100];
% alpha=@(x0) acos(x0./r);
index=0;
iter=zeros(1,length(Vset));
sol=zeros(1,length(Vset));
for V=Vset
    index=index+1;
    func=@(x0) L.*r.^2.*(pi/2-acos(x0./r)+...
        0.5*sin(2.*acos(x0./r)))+V-0.5*pi*r.^2.*L;
    
    span=1;
    options = ...
        optimoptions('fsolve','FunValCheck','on','Algorithm','levenberg-marquardt',...
        'Display','off','OptimalityTolerance',1e-10);
    
    for x0=span
        
        fprintf('Xo=%.2f\n',x0);
        [x,fval,exitflag,output]=fsolve(func,x0,options);
        fprintf('iter:%d\nsol=%.3f\n-------------------\n',output.iterations,x);
        iter(index)=output.iterations;
        sol(index)=x;
    end
end










