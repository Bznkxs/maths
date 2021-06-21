function [f,g]=exam0705grad(x)
f=100*(x(2)-x(1)^2)^2+(1-x(1))^2;;% compute the function value at x
if nargout > 1   % fun called with 2 output arguments
   g(1)=-2*(1-x(1))-400*x(1)*(x(2)-x(1)^2);   % compute the gradient evaluated at x
   g(2)=200*(x(2)-x(1)^2);    
end
