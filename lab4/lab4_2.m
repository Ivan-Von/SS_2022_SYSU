wc=2.4;                        %滤波器截止频率 
Ts=2;                     %采样间隔 
n=-5:5;                     %时域采样点数 
nTs=n*Ts;                      %时域采样点 
f=(1+cos(nTs))/2;                   %信号f(nTs)的表达式
t=-pi:pi/10:pi; 
fa=f*Ts*wc/pi*sinc((wc/pi)*(ones(length(nTs),1)*t-nTs'*ones(1,length(t)))); %信号重构 
error=abs(fa-((1+cos(t))/2));          %求重构信号与原信号的误差
t1=-pi:pi/10:pi; 
f1=(1+cos(t1))/2; 
subplot(3,1,1); 
plot(t1,f1); 
xlabel('kTs'); ylabel('f(kTs)'); 
title('sa(t)=(1+cos(nTs))/2临界采样信号T=2'); 
subplot(3,1,2); 
plot(t,fa); 
xlabel('t'); ylabel('fa(t)'); 
title('由sa(t)=(1+cos(nTs))/2的临界采样信号重构sa(t)'); 
grid on; 
subplot(3,1,3); 
plot(t,error); 
xlabel('t'); ylabel('error(t)'); 
title('临界采样信号与原信号的误差error(t)');
