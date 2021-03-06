clear
% 卡方检验
a=10094/2608; n=2608;
p=poisspdf([0:9],a);
p(11)=1-sum(p);
nk=[57,203,383,525,532,408,273,139,45,27,16];
y=sum(((nk-n*p).^2)./(n*p));
pvalue=1-chi2cdf(y,9)


% 一天内不同时间婴儿出生数
a=[127,139,143,138,134,115,127,113,126,122,121,119,...
    130,125,112,97,115,94,99,97,100,119,127,139];
n=sum(a);
np=n/24;
y=sum((a-np).^2/np);
pvalue=1-chi2cdf(y,23)

% 骰子的均匀性
a1=[7 6 12 14 5 16]; n1=60;
a2=[1500300 1502100 1503000 1498500 1496700 1499400]; n2=9000000;
b1=a1/n1; b2=a2/n2;
np1=n1/6; np2=n2/6;
y1=sum((a1-np1).^2/np1); 
y2=sum((a2-np2).^2/np2); 
1-chi2cdf(y1,5), 1-chi2cdf(y2,5)

% 独立性检验
n=6672;
nn=[2780,3281;311,300]; nz=2;
cc=sum(nn,2)/n; dd=sum(nn,1)/n;
cd=cc*dd;
((nn-n*cd).^2)./(n*cd)

% 家庭收入与小孩数
nn=[2161, 3577, 2184, 1636; 2755, 5081, 2222, 1052; ...
    936, 1753, 640, 306; 225, 419, 96, 38;...
    39, 98, 31,14];
n=sum(sum(nn));
cc=sum(nn,2)/n; dd=sum(nn,1)/n;
cd=cc*dd;
y=sum(sum(((nn-n*cd).^2)./(n*cd)));


% 学生身高数据的正态性检验
x=[170.1 179.0 171.5 173.1 174.1 177.2 170.3 176.2 163.7 175.4 ...
   163.3 179.0 176.5 178.4 165.1 179.4 176.3 179.0 173.9 173.7 ...
   173.2 172.3 169.3 172.8 176.4 163.7 177.0 165.9 166.6 167.4 ...
   174.0 174.3 184.5 171.9 181.4 164.6 176.4 172.4 180.3 160.5 ...
   166.2 173.5 171.7 167.9 168.7 175.6 179.6 171.6 168.1 172.2];
[mu sigma muci sigmaci]=normfit(x) ;

[h,p] = kstest((x-mu)/sigma,[],0.01)

[h,p,ksstat,cv]= jbtest(x,0.01)

[h,p,ksstat,cv]= lillietest(x,0.01)



% 线性同余随机数生成器
m=2^31-1; a=65539;
x=23;  n=10000;
for k=1:n
   x(k+1)=mod(x(k)*a,m);       
   y(k)=x(k+1)/m; 
end
subplot(1,2,1); plot(y(1:2:n),y(2:2:n),'.')
subplot(1,2,2); plot3(y(2:3:n),y(3:3:n),y(4:3:n),'.')
