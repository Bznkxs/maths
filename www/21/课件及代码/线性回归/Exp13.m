% һԪ�ع������Ѫѹ����
y=[144	215	138	145	162	142	170	124	158	154 162	150	140	110	128	130	135	114	116	124 136	142	120	120	160	158	144	130	125	175];
x=[39	47	45	47	65	46	67	42	67	56 64	56	59	34	42	48	45	18	20	19 36	50	39	21	44	53	63	29	25	69];
n=length(y);
X=[ones(n,1)  x'];
[b,bint,r,rint,s]=regress(y',X);
b,bint,s,s2=sum(r.^2)/(n-2)
pause
plot(x,b(1)+b(2)*x,'LineWidth',2);  % ��С���˻ع�ֱ��
hold on
plot(x,y,'ro','MarkerSize',10,'LineWidth',2); % ���ݵ�ɢ��ͼ
pause
close; rcoplot(r,rint)
pause
[b,bint,r,rint,s]=regress(y',X);
y(2)=[]; x(2)=[];  % ȥ���쳣��
n=length(y); X=[ones(n,1)  x'];
[b,bint,r,rint,s]=regress(y',X);
plot(x,b(1)+b(2)*x,'LineWidth',2);  % ��С���˻ع�ֱ��
hold on
plot(x,y,'ro','MarkerSize',10,'LineWidth',2); % ���ݵ�ɢ��ͼ
pause; close; rcoplot(r,rint)

x0=50;
y0=b(1)+b(2)*x0;              % Ԥ��y(x=50)
xb=mean(x);
sxx=sum((x-xb).^2);
a=sqrt((x0-xb)^2/sxx+1/n+1);
t=tinv(0.975,n-2);
d=t*a*sqrt(s2);
y1=y0-d;y2=y0+d;             % Ԥ��y(x=50)���䣨t�ֲ���
[y0 y1 y2]
d1=norminv(0.975)*sqrt(s2);
y3=y0-d1;y4=y0+d1;
[y0 y3 y4]                   % Ԥ��y(x=50)���䣨N�ֲ���

% ��Ԫ�ع������Ѫѹ����
y=[144	215	138	145	162	142	170	124	158	154 162	150	140	110	128	130	135	114	116	124 136	142	120	120	160	158	144	130	125	175];
x1=[39	47	45	47	65	46	67	42	67	56 64	56	59	34	42	48	45	18	20	19 36	50	39	21	44	53	63	29	25	69];
x2=[24.2 31.1 22.6 24.0 25.9 25.1 29.5 19.7 27.2 19.3 28.0 25.8 27.3 20.1 21.7 22.2 27.4 18.8 22.6 21.5 25.0 26.2 23.5 20.3 27.1 28.6 28.3 22.0 25.3 27.4];  
x3=[0   1   0   1   1   0   1   0   1   0   1   0   0   0   0   1    0    0   0   0   0    1    0    0    1    1     0     1     0     1];
n=length(y);
X=[ones(n,1), x1',x2',x3'];
[b,bint,r,rint,s]=regress(y',X);
b,bint,s
rcoplot(r,rint)
pause
y=[y(1) y(3:9) y(11:30)];           % �޳������쳣����
x1=[x1(1) x1(3:9) x1(11:30)];
x2=[x2(1) x2(3:9) x2(11:30)];
x3=[x3(1) x3(3:9) x3(11:30)];
n=length(y);
X=[ones(n,1), x1',x2',x3'];
[b,bint,r,rint,s]=regress(y',X);
b,bint,s
rcoplot(r,rint)

% н�����ݵĻع����
M=dlmread('xinjindata.m');
n=46;
x1=M(:,3);
x2=M(:,4);
x3=M(:,6);
x4=M(:,7);
y=M(:,2);
x=[ones(n,1) x1 x2 x3 x4 ];
[b,bi,r,ri,s]=regress(y,x);
b,bi,s
pause
plot(x1,r,'+'),
pause
xx=M(:,8);
plot(xx,r,'+');

%x5=3-(x4+2*x3);  % ������ˮƽ����ָ��ϲ�����ѧ-1����ѧ-2���о���-3
x5=(x4+2*x3);
y=M(:,2);
x=[ones(n,1) x1 x2 x5 ];
[b,bi,r,ri,s]=regress(y,x);

% н�����⣬���ǽ�������
M=dlmread('xinjindata.m');
y=M(:,2);
x1=M(:,3);
x2=M(:,4);
x3=M(:,6);
x4=M(:,7);
x5=x2.*x3;
x6=x2.*x4;
n=length(y);
x=[ones(n,1) x1 x2 x3 x4 x5 x6];
[b,bi,r,ri,s]=regress(y,x);
b,bi,s
pause
plot(x1,r,'+'),
pause
xx=M(:,8);
plot(xx,r,'+')

% н�����⣬ȥ���쳣ֵ
M=dlmread('xinjindata.m');
M=[M(1:32,:);M(34:46,:)];
y=M(:,2);
x1=M(:,3);
x2=M(:,4);
x3=M(:,6);
x4=M(:,7);
x5=x2.*x3;
x6=x2.*x4;
n=length(y);
x=[ones(n,1) x1 x2 x3 x4 x5 x6];
[b,bi,r,ri,s]=regress(y,x);
s2=sum(r.^2)/(n-7);
b,bi,s,s2
pause
plot(x1,r,'+'),
pause
xx=M(:,8);
plot(xx,r,'+')


