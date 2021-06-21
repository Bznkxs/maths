clear,clc,close all

tnum=1000;
h=[];p=[];
for index=1:10
    x1=randn(tnum,1);
%     figure,histogram(x1,50);
    for num=1:tnum
        x2(num)=sum(rand(12,1));
    end
    x2=(x2-mean(x2))./std(x2);
%     figure,histogram(x2,50)
    for num=1:tnum
        x3(num)=sum(rand(6,1));
    end
    x3=(x3-mean(x3))./std(x3);
%     figure,histogram(x3,50)
    
    m=2^31-1; b=65539;a=0;
    x=23;
    for k=1:2*tnum
        x(k+1)=mod(x(k)*b+a,m);
        xx(k)=x(k+1)/m;
    end
    yy=xx(1:2:end-1);%奇数偶数
    xx=xx(2:2:end);
    uu=sqrt(-2.*log(xx)).*cos(2.*pi.*yy);
    vv=sqrt(-2.*log(xx)).*sin(2.*pi.*yy);%BoxMuller变换
%     figure,histogram(uu,50);
%     figure,histogram(vv,50);
    
    %卡方检验，检验正态属性？或者normfit
    [hh,pp] = chi2gof(x1);
    [hh(2),pp(2)] = chi2gof(x2);
    [hh(3),pp(3)] = chi2gof(x3);
    [hh(4),pp(4)] = chi2gof(uu);
    [hh(5),pp(5)] = chi2gof(vv);
    h=[h;hh];p=[p;pp];
end
pmean=mean(p);
