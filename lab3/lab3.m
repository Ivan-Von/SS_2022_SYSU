%2.1
syms t w %定义变量
Gt = sym(heaviside(2*t+1)-heaviside(2*t-1)); %声明函数
subplot(121)			%绘制原函数图像
fplot(Gt,[-2 2])
Fw = fourier(Gt,t,w); 	%求傅里叶变换
Fw
FFP = abs(Fw); 			%求幅度
subplot(122)			%绘制幅度图像
fplot(FFP,[-10*pi 10*pi]);
grid;
axis([-10*pi 10*pi 0 2.2]);
%2.2
sym t		%声明变量
R=0.02;		%取样间隔
			%取样间隔 τ=0.02
			% t 为从-2 到 2，间隔为 0.02 的行向量,有 201 个样本点
t = -2:R:2;	%三角脉冲函数X取值范围
w = 2;		%三角脉冲函数的脉冲跨度
Ft = sym(tripuls(t,w)); %三角脉冲函数
W1=10*pi;	%取要计算的频率范围
M=500;		%计数器
k=0:M;		
w=k*W1/M;	%频域采样数为 M, w 为频率正半轴的采样点
Fw=Ft*exp(-1j*t'*w)*R;	%求傅氏变换 F(jw)
FRw=abs(Fw);			%取振幅
W=[-fliplr(w),w(2:501)];
%由信号双边频谱的偶对称性，利用fliplr(w)形成负半轴的点
% w(2:501)为正半轴的点，函数 fliplr(w) 对矩阵 w 行向量作 180 度反转
FW=[fliplr(FRw),FRw(2:501)]; %形成对应于 2M+1 个频率点的值
subplot(1,2,1); 
plot(t,Ft);				%原函数图像
grid;
xlabel('t') ; 
ylabel('f(t)');
title('三角脉冲');
subplot(1,2,2); 
plot(W,FW);				%振幅频谱图像
grid; 
xlabel ('W'); 
ylabel ('F(W)');
title('f(t)的振幅频谱图');
%2.3
syms t w		%声明变量
Ft = sym(heaviside(t)*exp(-t));	%原函数
subplot(121)	
fplot(Ft,[-2 10]);				%绘制原函数图像
title('原函数')
Fw = fourier(Ft,t,w);			%求傅里叶变换
Fw								%输出傅里叶变换之后的函数
FFP = abs(Fw);					%求幅度
subplot(122)
fplot(FFP,[-100 100]);			%输出幅度频谱
grid;
axis([-100 100 0 1]);
title('傅里叶变换之后')
%2.4
%同（3）代码逻辑，不多做解释
syms t w
Ft = sym(exp(-(t^2)));
subplot(121)
fplot(Ft,[-2 10]);
title('原函数')
Fw = fourier(Ft,t,w);
Fw
FFP = abs(Fw);
subplot(122)

fplot(FFP,[-100 100]);
grid;
axis([-10 10 0 2]);
title('傅里叶变换之后')
%3.1
syms t w					%声明变量
Fw=sym(-1j*(2*w/(16+w^2)));	%原函数
Ft=ifourier(Fw,w,t);   		%傅里叶反变换
Ft							%输出傅里叶反变换之后的函数
fplot(Ft,[-5 5]);			%绘制傅里叶反变换之后的函数
grid;
axis([-5 5 -1 1])
%3.2
%代码逻辑同（1），不多做解释
syms t w 
Fw=sym(((1j*w)^2+5*1j*w-8)/((1j*w)^2+6*1j*w+5));
Ft=ifourier(Fw,w,t);   
Ft
fplot(Ft,[-5 5]);
grid;
axis([-5 5 -2 1])
%4
w=-10:0.025:10;	%自变量取值和间距
b=[1];			%分子系数向量
a=[0.08,0.4,1];	%分母系数向量
H=freqs(b,a,w);	%求解模拟滤波器的频率响应
subplot(2,1,1);
plot(w,abs(H));	%绘制幅频图像
grid;
xlabel('\omega(rad/s)');
ylabel('|H(j\omega)|');
title('H(jw)的幅频特性');
subplot(2,1,2);	%绘制相频图像
plot(w,angle (H));
grid;
xlabel('\omega(rad/s)');
ylabel('\phi(\omega)');
title('H(jw)的相频特性');