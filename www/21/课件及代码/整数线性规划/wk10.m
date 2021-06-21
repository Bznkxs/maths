clear,clc,close all
clock=[];
sol=cell(5,1);
index=0;
for n=[2,10,50,100,1000]
    lb=zeros(3*n,1);
    f=zeros(3*n,1);f(n)=-1;
    A1=zeros(1,3*n);
    A1(1)=4;A1(n+1)=-4;
    A2=zeros(1,3*n);
    A2(1)=1;A2(2*n+1)=1;
    A3=zeros(n-1,3*n);
    for row=1:n-1
        A3(row,row)=-1;
        A3(row,row+1)=4;
        A3(row,row+n+1)=-4;
    end
    A4=zeros(n-1,3*n);
    for row=1:n-1
        A4(row,row)=1;
        A4(row,row+1)=4;
        A4(row,row+2*n+1)=4;
    end
    A=[A1;A2;A3;A4];
    b=[1;1;zeros(n-1,1);4*ones(n-1,1)];
    tic;
    index=index+1;
    sol(index)={linprog(f,[],[],A,b,lb)};
    clock=[clock,toc];
end
index=0;
for n=[2,10,50,100,1000]
    index=index+1;
    figure,plot(1:3*n,sol{index});
end
figure,plot([2,10,50,100,1000],clock);



