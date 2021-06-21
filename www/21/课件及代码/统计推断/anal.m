clc
x=[9.23, 8.72, 10.31, 9.64, 9.51, 9.34, 9.08, 9.95];
alpha=[0.1 0.05];


[mu sigma muci sigmaci]=normfit(x,alpha(1))
fprintf('\n\n');
[mu sigma muci sigmaci]=normfit(x,alpha(2))

ttt=sqrt(length(x))*(mean(x)-9.75)/std(x)
alpha=tcdf(ttt,7)*2  %p

% tinv(0.975,n-1)
nn=(2*norminv(0.975)*std(x)/0.1)^2



