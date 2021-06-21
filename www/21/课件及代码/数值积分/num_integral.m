clear;clc
fun1=@(x) exp(3.*x).*sin(2.*x);
fun2=@(x) sqrt(1+x.^2);

%% 1
res1t=0.5*(fun1(0)+fun1(2))*2;
res1s=2/6*(fun1(0)+fun1(2)+4*fun1(1));
res2t=0.5*(fun2(0)+fun2(2))*2;
res2s=2/6*(fun2(0)+fun2(2)+4*fun2(1));

syms x
f1(x)=exp(3.*x).*sin(2.*x);
f1d=diff(f1);
f1dd=diff(f1d);
f1ddd=diff(f1dd);
f1dddd=diff(f1ddd);

f2(x)=sqrt(1+x.^2);
f2d=diff(f2);
f2dd=diff(f2d);
f2ddd=diff(f2dd);
f2dddd=diff(f2ddd);

f1ddm=max(abs(double(f1dd(0:1e-3:2))));
f1ddddm=max(abs(double(f1dddd(0:1e-3:2))));
f2ddm=max(abs(double(f2dd(0:1e-3:2))));
f2ddddm=max(abs(double(f2dddd(0:1e-3:2))));

err_t1=2^3/12*f1ddm;
err_s1=2^5/2880*f1ddddm;
err_t2=2^3/12*f2ddm;
err_s2=2^5/2880*f2ddddm;

%% 2
for piece=10:1e4
    eps=2/piece;
    err_tr1=eps^2/12*2*f1ddm;
    if err_tr1<1e-6
        piece1t=piece
        break;
    end
end
for piece=10:1e4
    eps=2/piece;
    err_sim1=eps^4/180*2*f1ddddm;
    if err_sim1<1e-6
        piece1s=piece
        break;
    end
end
for piece=10:1e4
    eps=2/piece;
    err_tr2=eps^2/12*2*f2ddm;
    if err_tr2<1e-6
        piece2t=piece
        break;
    end
end
for piece=10:1e4
    eps=2/piece;
    err_sim2=eps^4/180*2*f2ddddm;
    if err_sim2<1e-6
        piece2s=piece
        break;
    end
end

%% 3
xspan=0:2/piece1t:2;
res1trapz=1/piece1t*(2*sum(fun1(xspan))-fun1(0)-fun1(2));
disp('1-Trapz');disp(res1trapz)

xspan=0:2/piece1s:2;
res1simpson=2/piece1s/6*(-fun1(0)-fun1(2)+4*sum(fun1(xspan(1:end-1)+2/piece1s/2))+2*sum(fun1(xspan)));
disp('1-Simpson');disp(res1simpson)

xspan=0:2/piece2t:2;
res2trapz=1/piece2t*(2*sum(fun2(xspan))-fun2(0)-fun2(2));
disp('2-Trapz');disp(res2trapz)

xspan=0:2/piece2s:2;
res2simpson=2/piece2s/6*(-fun2(0)-fun2(2)+4*sum(fun2(xspan(1:end-1)+2/piece2s/2))+2*sum(fun2(xspan)));
disp('2-Simpson');disp(res2simpson)

%% 4
res1quad=quad(fun1,0,2)
res1quadl=quadl(fun1,0,2)
res2quad=quad(fun2,0,2)
res2quadl=quadl(fun2,0,2)

res1quad=quad(fun1,0,2,1e-4)
res1quadl=quadl(fun1,0,2,1e-4)
res2quad=quad(fun2,0,2,1e-4)
res2quadl=quadl(fun2,0,2,1e-4)

res1quad=quad(fun1,0,2,1e-8)
res1quadl=quadl(fun1,0,2,1e-8)
res2quad=quad(fun2,0,2,1e-8)
res2quadl=quadl(fun2,0,2,1e-8)

res1quad=quad(fun1,0,2,1e-10)
res1quadl=quadl(fun1,0,2,1e-10)
res2quad=quad(fun2,0,2,1e-10)
res2quadl=quadl(fun2,0,2,1e-10)

res1quad=quad(fun1,0,2,1e-12)
res1quadl=quadl(fun1,0,2,1e-12)
res2quad=quad(fun2,0,2,1e-12)
res2quadl=quadl(fun2,0,2,1e-12)

