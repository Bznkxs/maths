% ��������������ʽ����
x=0.988:.001:1.012;
plot(x,(x-1).^7)

x=0.988:.001:1.012;
y=x.^7-7*x.^6+21*x.^5-35*x.^4+35*x.^3-21*x.^2+7*x-1;
subplot(2,2,1); scatter(x,y,'.'),hold on, plot(x,(x-1).^7,'r')

x=0.988:.0001:1.012;
y=x.^7-7*x.^6+21*x.^5-35*x.^4+35*x.^3-21*x.^2+7*x-1;
subplot(2,2,2); scatter(x,y,'.'),hold on, plot(x,(x-1).^7,'r')

x=0.988:.00001:1.012;
y=x.^7-7*x.^6+21*x.^5-35*x.^4+35*x.^3-21*x.^2+7*x-1;
subplot(2,2,3); scatter(x,y,'.'),hold on, plot(x,(x-1).^7,'r')

x=0.988:.000001:1.012;
y=x.^7-7*x.^6+21*x.^5-35*x.^4+35*x.^3-21*x.^2+7*x-1;
subplot(2,2,4); scatter(x,y,'.'),hold on, plot(x,(x-1).^7,'r')

% ����������������֤I
% �ӷ������ɣ���������ʾ
clear
n=10000;
A=rand(1,n);
m=1e10;

tic
x1=0;
for i=1:n
    x1=x1+A(i);
end
x1=n*x1;
x1=x1+m;
t(1)=toc;

tic
x2=m;
for j=1:n
    for i=1:n
        x2=x2+A(i);
    end
end
t(2)=toc;

tic
for k=1:10000   x3=n*sum(A)+m; end
t(3)=toc/10000;

[x1, x2, x3],x3-[x1,x2],t

% ����������������֤II
% �˷�������
for m=1:60
    a=4;
    for k=1:m
        a=sqrt(a);
    end
    for k=1:m
        a=a*a;
    end
    b(m)=a;
end
plot(b)

% �㷨�ȶ��ԣ������㷨I
clear
ep(1)=1
for n=2:100
    ep(n)=exp(1.0)-n*ep(n-1);
end
plot(ep,'b*');

% �㷨�ȶ��ԣ������㷨II
clear
ep(100)=0;
for n=100:-1:2
    ep(n-1)=(exp(1.0)-ep(n))/n;
end
plot(ep,'b*');


% ����ʽ����Ĳ�̬��
p=poly(1:20);
ep=zeros(1,21);
ep(3)=1.0e-5;
re=roots(p+ep)
subplot(2,1,1); plot(re,'b+');
hold on
plot(1:20,0,'r*');

ep(3)=1.0e-8;
re=roots(p+ep)
subplot(2,1,2); plot(re,'b+');
hold on
plot(1:20,0,'r*');

%pagerank����ʵ��
A=zeros(11);
A(2,3)=1;
A(3,2)=1;
A(4,[1 2])=1;
A(5,[2 4 6])=1;
A(6,[2 5])=1;
A(7,[2 5])=1;
A(8,[2 5])=1;
A(9,[2 5])=1;
A(10,[5])=1;
A(11,[5])=1;

b=sum(A,2);
b(2:11)=1./b(2:11);
G=diag(b)*A;

b=ones(1,11)/11;
b=b*G; b=b/sum(b)   % ѭ��

G=0.85*G;
G=0.15*ones(11)/11+G;
G(1,:)=ones(1,11)/11;

b=ones(1,11)/11;
b=b*G    % ѭ��

[v,e]=eig(G');

v=v(:,1); v=v/sum(v)


% QR�㷨
 [P,H] = hess(G);
 A=H;
 for k=1:50
     [q,r]=qr(A);
     A=r*q, pause
 end
 
 [P,H] = hess(G');
 A=H;
 for k=1:100
     [q,r]=qr(A);
     A=r*q;
 end
     