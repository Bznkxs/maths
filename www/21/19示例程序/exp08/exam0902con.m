function [c,ceq,g,geq]=exam0902con(x)  %编写非线性约束的m文件;
c=[1.5+x(1)*x(2)-x(1)-x(2);-x(1)*x(2)-10];%不等式约束;
ceq=x(1)^2+x(2)-1;%等式约束;
if nargout > 2
    g=[x(2)-1,-x(2);x(1)-1,-x(1)];
    geq=[2*x(1);1];
end
