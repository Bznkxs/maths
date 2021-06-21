clear,clc

A=[2 1 2;3 3 1];
cT=[4 1 1];
b=[4;3];

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
    x=zeros(size(A,2),1);
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
cBT=cT(indexsett(Mindex,:));
lambda=cBT/B






