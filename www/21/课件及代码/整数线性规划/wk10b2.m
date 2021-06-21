clear,clc,close all
f=[1.8;3.5;0.4;1;0;0;0];
LB=[zeros(4,1);40;20;45];
Aeq=[0.5 1 2 6 -1 0 0;
    2 4 0.5 1 0 -1 0;
    5 2 1 2.5 0 0 -1];
beq=zeros(3,1);
sol=linprog(f,[],[],Aeq,beq,LB);
cost=f'*sol












