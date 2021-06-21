function r=simpson(fv,a,b,n)
% 利用复合Simpson公式计算积分，a,b为积分上下限，n等分
x=linspace(a,b,2*n+1);
r0=feval(fv,x([1 2*n+1]));
r1=4*feval(fv,x(2:2:2*n));
r2=2*feval(fv,x(3:2:2*n));
r=(sum(r0)+sum(r1)+sum(r2))*(b-a)/6/n;
if n==1
     r=sum([r0 r1])*(b-a)/6;
end