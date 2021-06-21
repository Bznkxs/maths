
data2=xlsread('data2.xlsx');

figure,scatter(data2(:,1),data2(:,2)),hold on;
ffit=fit(data2(:,1),data2(:,2),'poly1');
plot(ffit);
figure,h1=histogram(data2(:,1));
figure,h2=histogram(data2(:,2));

n=100;
alpha=[0.02,0.05,0.1];
mu1=[];mu2=[];
for aa=alpha
    mu1=[mu1,[mean(data2(:,1))-tinv(1-aa/2,n-1)*std(data2(:,1))/sqrt(n);...
        mean(data2(:,1))+tinv(1-aa/2,n-1)*std(data2(:,1))/sqrt(n)]];
    mu2=[mu2,[mean(data2(:,2))-tinv(1-aa/2,n-1)*std(data2(:,2))/sqrt(n);...
        mean(data2(:,2))+tinv(1-aa/2,n-1)*std(data2(:,2))/sqrt(n)]];
end

mu0=[167.5,60.2];
tt=[sqrt(n)*(mean(data2(:,1))-mu0(1))/std(data2(:,1))...
    ,sqrt(n)*(mean(data2(:,2))-mu0(2))/std(data2(:,2))];
pp=tcdf(-abs(tt),n-1)*2;

pp2=tcdf(tt,n-1);
pp3=1-tcdf(tt,n-1);



