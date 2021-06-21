clc

n=1e3;
nn=10;
for xis=0:0.1:1
    [p,time,err]=MCp(nn,xis,n);
    p,time,err
    fprintf('--------\n\n');
end


