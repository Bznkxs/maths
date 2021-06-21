clear,clc,close all
dtable=[
    1	586	4.4
    2	462	14.0
    3	491	10.1
    4	565	6.7
    5	462	11.5
    6	532	9.6
    7	478	12.4
    8	515	8.9
    9	493	11.1
    10	528	7.8
    11	576	5.5
    12	533	8.6
    13	531	7.2
    ];
y=dtable(:,2);x=dtable(:,3);
n=length(x);
X=[ones(n,1),x];
figure,hold on,scatter(x,y);
[b,bint,r,rint,s]=regress(y,X);
plot(x,b(1)+b(2)*x,'LineWidth',1);  % 最小二乘回归直线
xlabel('age'),ylabel('sleep min')
figure,rcoplot(r,rint)

s2=sum(r.^2)/(n-2);
x0=10;
y0=b(1)+b(2)*x0;              % 预测y(x=50)
xb=mean(x);
sxx=sum((x-xb).^2);
a=sqrt((x0-xb)^2/sxx+1/n+1);
t=tinv(0.975,n-2);
d=t*a*sqrt(s2);
y1=y0-d;y2=y0+d;             % 预测y(x=50)区间（t分布）
[y0 y1 y2]
d1=norminv(0.975)*sqrt(s2);
y3=y0-d1;y4=y0+d1;
[y0 y3 y4]                   % 预测y(x=50)区间（N分布）

y(5)=[];x(5)=[];
n=length(x);
X=[ones(n,1),x];
figure,hold on,scatter(x,y);
[b,bint,r,rint,s]=regress(y,X);
plot(x,b(1)+b(2)*x,'LineWidth',1);  % 最小二乘回归直线
xlabel('age'),ylabel('sleep min')
figure,rcoplot(r,rint)

s2=sum(r.^2)/(n-2);
x0=10;
y0=b(1)+b(2)*x0;              % 预测y(x=50)
xb=mean(x);
sxx=sum((x-xb).^2);
a=sqrt((x0-xb)^2/sxx+1/n+1);
t=tinv(0.975,n-2);
d=t*a*sqrt(s2);
y1=y0-d;y2=y0+d;             % 预测y(x=50)区间（t分布）
[y0 y1 y2]
d1=norminv(0.975)*sqrt(s2);
y3=y0-d1;y4=y0+d1;
[y0 y3 y4]                   % 预测y(x=50)区间（N分布）

%% 2
M=[
    1	11.2	16.5	6.2	587
    2	13.4	20.5	6.4	643
    3	40.7	26.3	9.3	635
    4	5.3	16.5	5.3	692
    5	24.8	19.2	7.3	1248
    6	12.7	16.5	5.9	643
    7	20.9	20.2	6.4	1964
    8	35.7	21.3	7.6	1531
    9	8.7	17.2	4.9	713
    10	9.6	14.3	6.4	749
    11	14.5	18.1	6	7895
    12	26.9	23.1	7.4	762
    13	15.7	19.1	5.8	2793
    14	36.2	24.7	8.6	741
    15	18.1	18.6	6.5	625
    16	28.9	24.9	8.3	854
    17	14.9	17.9	6.7	716
    18	25.8	22.4	8.6	921
    19	21.7	20.2	8.4	595
    20	25.7	16.9	6.7	3353
    ];
n=length(M);
x1=M(:,3);
x2=M(:,4);
x3=M(:,5);
y=M(:,2);
X=[x1,x2,x3];
for index=1:3
    Xtemp=X;Xtemp(:,index)=[];
    x=[ones(n,1),Xtemp];
    [b,bi,r,ri,s]=regress(y,x);
    s
end
x=[ones(n,1),X];
[b,bi,r,ri,s]=regress(y,x);
s
figure,rcoplot(r,ri)

X([8,11,20],:)=[];
ydel=y;ydel([8,11,20])=[];
n=size(X,1);
x=[ones(n,1),X];
[b,bi,r,ri,s]=regress(ydel,x);
s
figure,rcoplot(r,ri)
