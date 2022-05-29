% close all;clc;  %关闭所有图形窗口，清空命令行
% x1=-pi:pi/200000:pi;   %开始：步长：终止数值
% y1=((1+cos(x2))/2);%绘制函数
% x2=-3*pi:pi/200000:-pi;
% y2=0*x2;
% x3=pi:pi/200000:3*pi;
% y3=0*x3;
% x=[x1 x2 x3];
% y=[y1 y2 y3];
% subplot(121)
% plot(x,y);  %设置颜色、标记和线型
% axis([-3*pi 3*pi -0.1 1]);
% % 设置坐标轴，其中x为%1～%2，y为%3～%4（但是后来可以通过鼠标滚轮手动修改）
% % 百分号指第几个参量
% xlabel('x'); %设置横坐标
% ylabel('(1+cos(x)/2'); %设置纵坐标
% grid;   %画格子



sym t		%声明变量
R=pi/20;		%取样间隔
t = -4*pi:R:4*pi;	%X取值范围
Ft = sym(0.*(t<-pi)+(1+cos(t))/2.*(t>=-pi & t<=pi)+0.*(t>pi)); %函数
W1=10*pi;	%取要计算的频率范围
M=500;		%计数器
k=0:M;		
w=k*W1/M;	%频域采样数为 M, w 为频率正半轴的采样点
Fw=Ft*exp(-1j*t'*w)*R;	%求傅氏变换 F(jw)
W=[-fliplr(w),w(2:501)];
FW=[fliplr(Fw),Fw(2:501)]; 
subplot(1,2,1); 
plot(t,Ft);	
grid;
xlabel('t') ; 
ylabel('f(t)');
subplot(1,2,2); 
plot(W,FW);				
grid; 
xlabel ('W'); 
ylabel ('F(W)');
title('f(t)的频谱图');



% close all;
% clc;
% x=-3*pi:0.1*pi:3*pi;
% y=0.*(x<-pi)+(1+cos(x))/2.*(x>=-pi & x<=pi)+0.*(x>pi);
% plot(x,y)