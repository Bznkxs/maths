
%% 2-数值积分
%误差控制，课件、数值积分大作业可以参考
%收敛性：课件P16
%代数精度，用幂函数的次数来表示，k就是k》梯形1；辛普森3
%sum ，cumsum,trapz,simpson,quad,quadl,integral

%% 3-ODE初值问题
%局部截断误差，精度，p阶，p+1次方,作业2
%梯形和改进Euler是2阶方法
%龙格库塔，可以参考4-作业1
%% Runge-Kutta-四级四阶
function [x,y]=runge_kutta1(ufunc,y0,h,a,b)
%参数表顺序依次是微分方程组的函数名称，初始值向量，
%步长，时间起点，时间终点（参数形式参考了ode45函数）
n=floor((b-a)/h);%求步数
x(1)=a;%时间起点
y(:,1)=y0;%赋初值，可以是向量，但是要注意维数
for ii=1:n

x(ii+1)=x(ii)+h;

k1=ufunc(x(ii),y(:,ii));

k2=ufunc(x(ii)+h/2,y(:,ii)+h*k1/2);

k3=ufunc(x(ii)+h/2,y(:,ii)+h*k2/2);

k4=ufunc(x(ii)+h,y(:,ii)+h*k3);

y(:,ii+1)=y(:,ii)+h*(k1+2*k2+2*k3+k4)/6;
%按照龙格库塔方法进行数值求解
end
end
%% 3-继续
[xx,yy]=ode45(@odefun2,[0 1],0);%fun tspan/xspan y0
%新开辟文件
function dxdt=odefun1(t,x)
dxdt=x+2*t;
end
function diff=odefun2(x,y)
diff=x.^2-y.^2;
end
%logistic作业4

%% 4-线性方程组
%条件数cond(A)与2范数norm(A)，cond大可能病态
%作业1善用不等式
[xJ,k,XX,rho]=JacDD(A,b,m,tol);%对角优势、下三角优势
[xG,k,XX,rho]=GSDD(A,b,m,tol);%对角优势、下三角优势-对称正定
%rho谱半径：迭代矩阵B最大特征根模。小于1收敛.与方法和A有关。函数里有初值！！
w=[0.75 1 1.25 1.5];%超松弛因子
[xS,k,XX]=SORDD(A,b,m,tol,w);
xx=pcg(A,b,tol,maxiter);%预条件共轭梯度法,A对称正定
%最暴力的高斯消去法（选主元）——A阶数小，非病态
%收敛性判断准则看作业2

%% 5-非线性方程组数值解
fun1 = @(x) sin(x)-0.5*x.^2;
options = ...
    optimset('FunValCheck','on','Display','final','TolX',1e-10);
[x,fval,exitflag,output]=fzero(fun1,x0,options);
fprintf('iter:%d\nsol=%.3f\n-------------------\n',output.iterations,x);
%fzero，变号点
%fsolve：形式类似方法不同
%理论题1：迭代公式不动点，三阶方法
%k阶收敛——k阶极限为非零常数。k=2叫平方收敛（Newton）
%重根——牛顿切线1阶。重数越高收敛越慢。和牛顿割线法 课件P24
%理论题2：设计函数，让迭代算法3阶至少收敛。迭代函数1、2阶导数在不动点处=0

%% 6-浮点数、机器精度、问题病态性、算法稳定性
%小数突然与大数相加会导致很大误差
%高斯消去法如果不选主元，会导致误差被放大
%龙格库塔公式，3级与2阶，最高3阶（取中间）
%算法稳定性，试验方程（y'=-λy），步长区间与λ的关系.
% 找到n到n+1的迭代式，看系数≤1

%% 7-线性规划
%基本解，选取A的行数非零，基变量，满足约束为基本可行解
%线性规划可行域的顶点=基本解
%作业题3（2）有详细的单纯性过程，B逆b（B\b代表基变量，要≥0）
%根据用非基变量（0）表示的目标函数确定入基
%对偶不要求，3（3、4）问

%% 8-整数线性优化
%1（a）：linprog计算量、计算时间，指数级别
%2（b）：带边界条件的linprog；拉格朗日乘子lambda.eqlin
%（B\b代表基变量，要≥0）
%2:搞清楚等量关系，不等式和等式之间的转化。Ax=b，x≥0
%3：分支定界作业题3
%4：注意TSP问题动态规划，f的定义（报告里）

%% 10-统计量和MC方法
%MC直接模拟、MC计算区域内积分（虽然生成均匀分布但是还要在区域内累加pi）
%integral2不推荐，迭代次数和精度是很大的矛盾
%Ryser-NW、GG、KKLLL计算矩阵的积和式

%% 11-统计推断
[mu sigma muci sigmaci]=normfit(x,alpha);
ttt=sqrt(length(x))*(mean(x)-9.75)/std(x)% t统计量
ppp=tcdf(ttt,7)*2  %p
%1还涉及样本总数计算
%2涉及均值的区间估计（t方法），涉及均值大小关系的假设检验，着重几个p值求法
%3:F的自由度一般-1，用于方差比检验；t检验量自由度m+n-2，拒绝域见报告
%注意假设的顺序，指的是大于小于还是等于
%概率论chapter777各种假设检验

%% 12-拟合优度检验
%卡方检验的公式，hw1里面有
%列联表检验：课件P12--卡方太大，p值太小小于α，就把原命题否了！
%样本数1000，分组数100
%hw1关于指数分布
%hw2关于随机数生成，rand迭加，BM变换，线性同余生成器seed的影响

%% 13-线性回归
%总偏差平方和、回归平方和、残差平方和，见课件P17
%记得选取自变量时，检查bint，防止过拟合
x=[];
n=length(x);
X=[ones(n,1),x];%1列向量+自变量（可以多列）
[b,bint,r,rint,s]=regress(y,X,alpha);
%显著性水平alpha默认0.05，即置信水平0.95
s     %R2,F,置信水平p,误差方差的估计值
figure,plot(x,b(1)+b(2)*x,'LineWidth',1);  % 最小二乘回归直线
%bint不要过零，另外r用来剔除异常样本点
figure,rcoplot(r,rint)
%模型有效性，r，b，stat

for index=1:3
    Xtemp=X;Xtemp(:,index)=[];
    x=[ones(n,1),Xtemp];
    [b,bi,r,ri,s]=regress(y,x);
    s
end
%选择自变量，一般看R方和误差方差

%模型-2 比模型-1 预测区间更小，需要对于“异常”数据特征和预测精度进行权衡； 
%正态分布是对于 t 分布的近似，适用于 n 较大（几十上百）
% 且 x0 接近于 x 均值的情况。 
s2=sum(r.^2)/(n-2);
x0=10;
y0=b(1)+b(2)*x0;              % 点预测
xb=mean(x);
sxx=sum((x-xb).^2);
a=sqrt((x0-xb)^2/sxx+1/n+1);
t=tinv(0.975,n-2);
d=t*a*sqrt(s2);
y1=y0-d;y2=y0+d;             % 预测y区间（t分布）alpha=0.05
[y0 y1 y2]
d1=norminv(0.975)*sqrt(s2);
y3=y0-d1;y4=y0+d1;
[y0 y3 y4]                   % 预测y区间（N分布）alpha=0.05


%scatter,plot,stairs,histogram,bar,stem
%% 大作业4用到了大数定律

