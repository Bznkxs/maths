clear,clc,close all
%% 1a
y=[ones(1,10),ones(1,1000)*1e-7];
x=1:length(y);
ypos=0;yneg=0;
ypp=[];ynn=[];
for index=x
    ypos=ypos+y(index);
    ypp=[ypp,ypos];
    yneg=yneg+y(end-index+1);
    ynn=[ynn,yneg];
end
figure,hold on,plot(x,ypp,x,ynn),
legend('pos','neg');

fprintf('%.20f\n%.20f\n%.20f\n', 1e-4+10,ypos,yneg);
fprintf('\np=%.20f\nn=%.20f\n---\n'...
        ,ypos-valt,yneg-valt);
%% 1
for n=[1e3 1e4 1e5]
    x=1:n;
    y=exp(-x);
    ypos=0;yneg=0;
    %     ypp=[];ynn=[];
    for index=x
        ypos=ypos+y(index);
%         ypp=[ypp,ypos];
        yneg=yneg+y(end-index+1);
%         ynn=[ynn,yneg];
    end
    % figure,hold on,plot(x,ypp,x,ynn),
    % legend('pos','neg');
    valt=1.0/(exp(1)-1);
    fprintf('%d:\np=%.20f\nn=%.20f\n---\n'...
        ,n,ypos-valt,yneg-valt);
    fprintf('%.20f\n%.20f\n%.20f\n---------------------------\n'...
        ,valt,ypos,yneg);
end
%% 1b
fprintf('%.20f\n%.20f\n%.20f\n',valt,ypos,yneg);

%% 2