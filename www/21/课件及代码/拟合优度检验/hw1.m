clear,clc,close all
index=0;
for lambda=[0.5,1,2,4,8,16]
    index=index+1;
    tnum=1000;
    gnum=round(tnum/10);
    unid=rand(tnum,1);
    expd=-log(unid)./lambda;
%     histogram(expd,gnum);
%     hold on;
    [fre, xout] = hist(expd,gnum);
    bin=xout(2)-xout(1);
    
    xspan=linspace(0,lambda,gnum);
    uu=exppdf(xspan,1/lambda);
    uu=uu./max(uu).*max(fre);
%     plot(xspan,uu);
    
    for num=1:gnum
        expect(num)=expcdf(num*bin)-expcdf((num-1)*bin);
    end
    chi2(index)=sum((fre-expect.*tnum).^2./(expect.*tnum))
    p(index)=1-chi2cdf(chi2(index),tnum-1)
%     figure,plot(1:gnum,fre,1:gnum,expect.*tnum)
end
