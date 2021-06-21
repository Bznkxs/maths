close all
x=-5:0.1:5;
f1=1/sqrt(2*pi).*exp(-0.5.*x.^2);
f2=-1/sqrt(2*pi).*x.*exp(-0.5.*x.*x);
f3=-1/sqrt(2*pi)*(1-x.^2).*exp(-0.5*x.^2);
figure,hold on
plot(x,f1)
plot(x,abs(f2))
plot(x,abs(f3))
plot(x,normcdf(x))
legend('\Phi^{\prime}(x)','\Phi^{\prime\prime}(x)',...
    '\Phi^{\prime\prime\prime}(x)','\Phi(x)');
%% error
clear;close all
syms x
fun2(x)=-1/sqrt(2*pi).*x.*exp(-0.5.*x.*x);
fun3(x)=-1/sqrt(2*pi)*(1-x.^2).*exp(-0.5*x.^2);
fun4(x)=diff(fun3);
xspan=-10:0.1:10;
figure,hold on
plot(xspan,double(fun2(xspan)))
plot(xspan,double(fun4(xspan)))
legend('2-derivative','4=derivative')
fun2=@(x) -1/sqrt(2*pi).*x.*exp(-0.5.*x.*x);
fun4=@(x) (7186705221432913*x*exp(-x^2/2))/...
    9007199254740992 - x*exp(-x^2/2)*...
    ((7186705221432913*x^2)/18014398509481984 -...
    7186705221432913/18014398509481984);
[x2,max2d]=fminbnd(fun2,0.9,1.1);max2d=-max2d
[x4,max4d]=fminbnd(fun4,-0.9,-0.6);max4d=-max4d
%% distribution
step1=sqrt(8e-6/max2d);
xstep1=-192*step1:step1:0;
xstep2=[];
K=sqrt(8e-6);
xpoint=192*step1;
while xpoint<13
    xstep2=[xstep2,xpoint];
    xpoint=xpoint+K/sqrt(abs(feval(fun2,xpoint)));  %由于下坡
end
xstep2=xstep2(2:end);
xstep=[fliplr(-xstep2),xstep1];




%% numint
fun1=@(x) 1/sqrt(2*pi).*exp(-0.5.*x.^2);
mfun4=@(x) -((7186705221432913*x*exp(-x^2/2))/...
    9007199254740992 - x*exp(-x^2/2)*...
    ((7186705221432913*x^2)/18014398509481984 -...
    7186705221432913/18014398509481984));
xstart=-13;
mfun2=@(x) 1/sqrt(2*pi).*x.*exp(-0.5.*x.*x);
res_trapz=zeros(1,length(xstep));
res_simpson=zeros(1,length(xstep));
index=0;
for xtarget=xstep
    index=index+1;
    if xtarget<-1.1
        [~,fminn]=fminbnd(mfun2,xstart,xtarget);        
        fmaxx=-fminn;
        hhh_t=sqrt(12e-6/fmaxx/13);        
    else
        hhh_t=sqrt(12e-6/max2d/13);
    end
    if xtarget<-2.4
        [~,fminn4]=fminbnd(mfun4,xstart,xtarget);
        fmaxx4=-fminn4;
        hhh_s=(180e-6/fmaxx4/13)^0.25;
    else
        hhh_s=(180e-6/max4d/13)^0.25;
    end
    xspan_t=linspace(xstart,xtarget,round((xtarget-xstart)/hhh_t));
    res_trapz(index)=trapz(xspan_t,fun1(xspan_t));
    res_simpson(index)=simpson(fun1,xstart,xtarget,round((xtarget-xstart)/hhh_s));
end
%% restore
xstep=[xstep(1:end-1),-fliplr(xstep)];
res_trapz=[res_trapz(1:end-1),1-fliplr(res_trapz)];
res_simpson=[res_simpson(1:end-1),1-fliplr(res_simpson)];

%% insert
input=2;
result_t=interp1(xstep,res_trapz,input,'linear');
result_s=interp1(xstep,res_simpson,input,'linear');

%% plot
figure
plot(xstep,res_trapz,xstep,res_simpson,xstep,normcdf(xstep));
legend('trapz','simpson','normcdf');
%% quad quadl
index=0;
res_q=zeros(1,length(xstep));
res_ql=zeros(1,length(xstep));
for xtarget=xstep
    index=index+1;
res_q(index)=integral(fun1,-13,xtarget,'AbsTol',1e-6);
res_ql(index)=quadl(fun1,-13,xtarget,1e-6);
end
%% error q
maxerr_q=max(abs(res_q-normcdf(xstep)));
maxerr_ql=max(abs(res_ql-normcdf(xstep)));
xinterp=-13:1e-5:13;
maxerr_qi=max(abs(interp1(xstep,res_q,xinterp,'linear')-normcdf(xinterp)));
maxerr_qli=max(abs(interp1(xstep,res_ql,xinterp,'linear')-normcdf(xinterp)));

%% error 2
maxerr_t=max(abs(res_trapz-normcdf(xstep)));
maxerr_s=max(abs(res_simpson-normcdf(xstep)));
xinterp=-13:1e-5:13;
maxerr_ti=max(abs(interp1(xstep,res_trapz,xinterp,'linear')-normcdf(xinterp)));
maxerr_si=max(abs(interp1(xstep,res_simpson,xinterp,'linear')-normcdf(xinterp)));

    % piece怎么确定？用误差公式+实际验证
    % piece增大能有什么问题？计算时间长？
    % 要确定在哪些点上算CDF，
    % 插值应该有函数