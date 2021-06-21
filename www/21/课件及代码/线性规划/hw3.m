clear,clc

A=[2,2,1,0,0;
    3,0,0,1,0;
    0,2,0,0,1];
cT=[-1,-2,0,1,0];
b=[16;9;8];

indexset=nchoosek(1:size(A,2),size(A,1));
xset=[];
xsetok=[];
indexsett=[];
for num=1:length(indexset)
    indexb=indexset(num,:);
    B=A(:,indexb);
    if rank(B)<size(A,1)
        continue;
    end
    x=zeros(5,1);
    x(indexb)=B\b;
    xset=[xset,x];
    if min(x)>=0
        xsetok=[xsetok,x];
        indexsett=[indexsett;indexb];
    end
end
xset
xsetok
zset=cT*xsetok
[Mini,Mindex]=min(zset);
xopt=xsetok(:,Mindex)
Mini
%% lambda
indexbb=indexsett(Mindex,:);
cBT=cT(indexbb);
B=A(:,indexbb);
lambda=cBT/B
b=[16;b(2:3)];
B\b
zmin=Mini+4*lambda(1)


