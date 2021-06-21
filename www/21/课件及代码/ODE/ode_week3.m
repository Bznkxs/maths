clear;close all;clc

%% 欧拉法
x=0:1e-3:1;
figure,subplot(2,2,1)
plot(x,3*exp(x)-2*x-2,'r');
hold on;
for h=[0.1,0.01]
    x=0:h:1; y(1)=1;
    for k=2:length(x)
        y(k)=y(k-1)+h*(y(k-1)+2*x(k-1));
    end
    if h>0.05,plot(x,y,'b-'),    else,plot(x,y,'g-'),    end
end
legend('real','Euler h=0.1','Euler h=0.01');
%% 改进欧拉法
y2(1)=1;
subplot(2,2,2),hold on
x=0:1e-3:1;
plot(x,3*exp(x)-2*x-2,'r')
for h=[0.1,0.01]
    x=0:h:1;n=length(x);
    for k=2:n
        yy=y2(k-1)+h*(y2(k-1)+2*x(k-1));
        y2(k)=y2(k-1)+h*(yy+y2(k-1)+4*x(k-1))/2;
    end
    if h>0.05,plot(x,y2,'b-'),    else,plot(x,y2,'g-'),    end
end
legend('real','New Euler h=0.1','New Euler h=0.01');
%% ode23
[xx,yy]=ode23(@odefun1,[0 1],1);
subplot(2,2,3),hold on,
x=0:1e-3:1;plot(x,3*exp(x)-2*x-2,'r');
plot(xx,yy,'b')
legend('real','ode23');


%% ode45
[xx,yy]=ode45(@odefun1,[0 1],1);
subplot(2,2,4),hold on,
x=0:1e-3:1;plot(x,3*exp(x)-2*x-2,'r');
plot(xx,yy,'b')
legend('real','ode45');


%% 2-欧拉法
clear;clc;
figure,subplot(2,2,1)
hold on;
for h=[0.1,0.01]
    x=0:h:1; y(1)=0;
    for k=2:length(x)
        y(k)=y(k-1)+h*(x(k-1).^2-y(k-1).^2);
    end
    if h>0.05,plot(x,y,'b-'),    else,plot(x,y,'g-'),    end
end
legend('Euler h=0.1','Euler h=0.01');
%% 改进欧拉法
y2(1)=0;
subplot(2,2,2),hold on
for h=[0.1,0.01]
    x=0:h:1;n=length(x);
    for k=2:n
        yy=y2(k-1)+h*(x(k-1).^2-y(k-1).^2);
        y2(k)=y2(k-1)+h*(2.*x(k-1).^2-y(k-1).^2-yy.^2)/2;
    end
    if h>0.05,plot(x,y2,'b-'),    else,plot(x,y2,'g-'),    end
end
legend('New Euler h=0.1','New Euler h=0.01');
%% ode23
[xx,yy]=ode23(@odefun2,[0 1],0);
subplot(2,2,3),hold on,
plot(xx,yy,'b')
legend('ode23');


%% ode45
[xx,yy]=ode45(@odefun2,[0 1],0);
subplot(2,2,4),hold on,
plot(xx,yy,'b')
legend('ode45');

%% fix
figure(2),subplot(2,2,1),hold on,plot(xx,yy,'r'),legend('Euler h=0.1','Euler h=0.01','ODE45')
subplot(2,2,2),hold on,plot(xx,yy,'r'),legend('New Euler h=0.1','New Euler h=0.01','ODE45')
%% rocket
tfinal=72;eps=1e-4;
opts = odeset('RelTol',1e-6,'AbsTol',1e-10);
[tt,vv]=ode45(@rocket315,0:eps:tfinal,0,opts);
ic=find(tt==60);
v_c=vv(ic)
yy=cumtrapz(tt,vv);
y_c=yy(ic)
a_c=rocket315(60,v_c)

figure,plot(tt,vv),ylim([0 300])
[mdelta,idelta]=min(abs(vv(round(end-1/eps):end)));
idelta=round(idelta+71/eps);
y_0=yy(idelta)
t_0=(idelta-1)*eps
a_0=rocket315(t_0,vv(idelta))

figure,plot(tt,yy)
figure,plot(tt,rocket315(tt,vv))


