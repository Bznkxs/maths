t=0:0.1:1;
x1=(10^6/4+1)*exp(-t)-exp(-10^6*t);
x2=-(10^6/4+1)*exp(-t)+(10^6+1)/2*exp(-10^6*t);
A=[t;x1;x2]';
x0=[10^6/4,10^6/4-1/2];
tic; [t,x]=ode23(@stiff1,t,x0); tt(1)=toc;
tic; [t1,x1]=ode23s(@stiff1,t,x0); tt(2)=toc;
