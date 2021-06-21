clear,clc,close all
f=[1.8;3.5;0.4;1;zeros(6,1)];
LB=zeros(10,1);
% x: a b c d(goods) e f g(auxiliary) p ch r(nutrition)
Aeq=[0.5 1 2 6 0 0 0 -1 0 0;
    2 4 0.5 1 0 0 0 0 -1 0;
    5 2 1 2.5 0 0 0 0 0 -1;
    zeros(1,4) -1 0 0 1 0 0;
    zeros(1,5) -1 0 0 1 0;
    zeros(1,6) -1 0 0 1;
    ];
beq=[0,0,0,40,20,45]';
[sol,fval,exitflag,output,lambda]=linprog(f,[],[],Aeq,beq,LB);
cost=f'*sol
Bindex= find(lambda.lower==0);
B=Aeq(:,Bindex);
b1=[0,0,0,42,20,45]';
check1=B\b1
b2=[0,0,0,40,21,45]';
check2=B\b2
% 算出来eqlin 刚好是课本上 lambda的负数！
cost1=cost-lambda.eqlin(4)*2
cost2=cost-lambda.eqlin(5)*1

sol1=linprog(f,[],[],Aeq,b1,LB);
cost1a=f'*sol1
sol2=linprog(f,[],[],Aeq,b2,LB);
cost2a=f'*sol2
