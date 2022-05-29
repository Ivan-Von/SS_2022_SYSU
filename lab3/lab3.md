![img](file:///C:\Users\张文沁\AppData\Local\Temp\ksohtml20212\wps1.jpg)

 

 

 

# 						本科生实验报告

# 课程：信号与系统

# 实验：Lab3

# 姓名：张文沁

# 学号：20337268



## 1.简述实验目的及实验原理

### 一、 实验目的

#### 1．熟悉傅里叶变换的性质

#### 2．熟悉常见信号的傅里叶变换

#### 3．了解傅里叶变换的 MATLAB 实现方法

#### 4 ．学会用 MATLAB 分析 LTI 系统的频域特性

#### 5 ．学会用 MATLAB 分析 LTI 系统的输出响应

### 二、 实验原理

#### 傅里叶变换是信号分析 的最重要的内容之一。从已知信号**f**(**t**) 求出相应的频谱函数 **F**(**j**ω) 的数学表示为：

$$
F(jω) = ∫ f (t)e^(−jωt^) dt
$$

#### **f** (**t**) 的傅里叶变换存在的充分条件是**f**(**t**) 在无限区间内绝对可积， 即**f**(**t**) 满足下式：

$$
∫ |f (t) | dt <∞
$$

#### 但上 式并非 傅里叶变换存在的必要条件。在引入广义函数概念之后，使一些不满足绝对可 积条件的函数也能进行傅里叶变换。

#### 傅里叶反变换 的定义为：

$$
f (t) = ∫F(jω)e^(jωt^) dω 
$$



#### 在这一部分的学习中，大家都体会到了这种数学运算的麻烦。在 MATLAB 语言中有专 门对信号进行正反傅里叶变换的语句，使得傅里叶变换很容易在 MATLAB 中实现。在  MATLAB 中实现傅里叶变换的方法有两种，一种是利用 MATLAB 中的 `Symbolic Math Toolbox` 提供的专用函数直接求解函数的傅里叶变换和傅里叶反变换， 另一种是傅里叶变换的数值计算实现法。

## 2.实验内容及结果分析：

#### 1.验证实验原理中所述的相关程序

1. ### 例一

   1. #### 代码

      ```matlab
      syms t w	%声明变量
      Gt=sym(heaviside(t+1)-heaviside(t-1)); 		%定义门函数
      Fw=fourier(Gt,t,w);		%进行傅里叶变换
      Fw 		%输出傅里叶变换之后的值
      FFP=abs(Fw); 	%求幅度
      fplot(FFP,[- 10*pi 10*pi]);		%绘制频谱图
      grid;		%网格
      axis([- 10*pi 10*pi 0 2.2])		%限制上下界
      ```

   2. #### 结果

      ![image-20220413201303841](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413201303841.png)

      ![image-20220413201148123](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413201148123.png)

2. ### 例二

   1. #### 代码

      ```matlab
      syms t w 	%声明变量
      Fw=sym(1/(1+w^2)); 	%定义函数
      ft=ifourier(Fw,w,t);	%傅里叶反变换
      ft	%输出反傅里叶变换的值
      fplot(ft,[-5 5]);	%绘制反傅里叶变换的结果
      grid;	%网格
      axis([-5 5 0 1]) 	%限制上下界
      ```

   2. #### 结果

      ![image-20220413201718284](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413201718284.png)

      ![image-20220413201704416](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413201704416.png)

3. ### 例三

   1. #### 代码

      ```matlab
      ft=sym(4*cos(2*pi*6*t)*(heaviside(t+1/4)-heaviside(t- 1/4)));	%定义函数
      Fw=simplify(fourier(ft))	%调制函数
      subplot(121)	%分区画图
      fplot(ft,[-0.5 0.5]);	%原函数图像
      grid;
      subplot(122)
      fplot(abs(Fw),[-24*pi 24*pi]);	%调制函数的频谱
      grid;
      ```

   2. #### 结果

      ![image-20220413202845624](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413202845624.png)

      ![image-20220413202910996](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413202910996.png)

4. ### 例四

   1. #### 代码

      ```matlab
      R=0.02;
      t=-2:R:2;
      %取样间隔τ=0.02
      % t 为从-2 到 2，间隔为 0.02 的行向量,有 201 个样本点
      ft=[zeros(1,50),ones(1,101),zeros(1,50)];   
      %产生f(t)的样值矩阵(即f(t)的样本值组成的行向量)
      W1=10*pi;	%取要计算的频率范围
      M=500;		%频域采样数
      k=0:M; 		%计数器
      w=k*W1/M;	%频域采样数为M,w为频率正半轴的采样点
      Fw=ft*exp(-1j*t'*w)*R;	%求傅氏变换F(jw)
      FRw=abs(Fw);	%取振幅
      W=[-fliplr(w),w(2:501)];
      %由信号双边频谱的偶对称性，利用fliplr(w)形成负半轴的点w(2:501)为正半轴的点， 函数 fliplr(w) 对矩阵 w 行向量作 180 度反转
      FW=[fliplr(FRw),FRw(2:501)]; 
      subplot(2,1,1); 
      plot(t,ft);
      grid;
      %形成对应于 2M+1 个频率点的值
      %画出原函数 f(t)的波形，并加网格
      xlabel('t') ; 
      ylabel('f(t)');%原函数
      title('f(t)=u(t+1)-u(t-1)');
      subplot(2,1,2); 
      plot(W,FW);
      grid on; 
      xlabel ('W'); 
      ylabel ('F(W)');%傅里叶变换之后的函数
      title('f(t)的振幅频谱图');
      ```

   2. #### 结果

      ![image-20220413203216682](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413203216682.png)

5. ### 例五

   1. #### 代码

      ```matlab
      w=0:0.025:5;	%所取的点和间距
      b=[1]; 			%分子的系数向量
      a=[1,2,2,1]; 	%分母的系数向量
      H=freqs(b,a,w);	%求解模拟滤波器的频率响应
      subplot(2,1,1); %绘图
      plot(w,abs(H)); %幅度图像
      grid;
      xlabel('\omega(rad/s)');
      ylabel('|H(j\omega)|');
      title('H(jw)的幅频特性');
      subplot(2,1,2);
      plot(w,angle (H)); %相频图像
      grid;
      xlabel('\omega(rad/s)');
      ylabel('\phi(\omega)');
      title('H(jw)的相频特性');
      ```

   2. #### 结果

      ![image-20220413210439383](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413210439383.png)

6. ### 例六

   ​	
   $$
   y(t) = H(jw0 )  cos(ω0 t +ϕ(ω0 ))
   $$
   

   1. #### 代码

      ```matlab
      RC=0.04; 				%RC值
      t=linspace(-2,2,1024); 	%产生x1,x2之间的N点行矢量
      w1=5;
      w2=100;
      H1=1j*w1/(1j*w1+1/RC);
      H2=1j*w2/(1j*w2+1/RC);
      f=cos(5*t)+cos(100*t); 	%原函数
      y=abs(H1)*cos(w1*t+angle(H1))+ abs(H2)*cos(w2*t+angle(H2)); %系统响应
      subplot(2,1,1);	%绘图
      plot(t,f);
      ylabel('f(t)');
      xlabel('Time(s)');
      subplot(2,1,2);
      plot(t,y);
      ylabel('y(t)');
      xlabel('Time(s)');
      ```

   2. #### 结果

      ![image-20220413210627858](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413210627858.png)


#### 2.编程实现求下列信号的幅度频谱

#### 	**(1)  求出f1 (t) = ε(2t +1) − ε(2t −1) 的频谱函数 F1 (jω)，请将它与上面门宽为 2 的门 函数f (t) = ε(t +1) −ε(t −1) 的频谱进行比较，观察两者的特点， 说明两者的关系。**

1. #### 代码

   ```matlab
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
   ```

2. ### 结果

   1. #### 例一结果：

      $$
      f1 (t) = ε(t +1) − ε(t −1)
      $$

   ![image-20220413212058446](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413212058446.png)

   ![image-20220413212118846](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413212118846.png)

   2. #### 本题结果

      $$
      f1 (t) = ε(2t +1) − ε(2t −1) 
      $$

      

   ![image-20220413211937914](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413211937914.png)

   ![image-20220413211956705](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413211956705.png)

### 分析：

> #### 原函数由 t 变成 2t ，频谱图象其幅度缩小为一半，主瓣宽度增加。频谱函数omega值减小为一半，即周期增大为两倍，综上与课堂所学知识相符合

​	**(2) 三角脉冲  f2 (t) = ![img](file:///C:\Users\张文沁\AppData\Local\Temp\ksohtml13468\wps1.jpg)![img](file:///C:\Users\张文沁\AppData\Local\Temp\ksohtml13468\wps2.jpg)**

 1. ### 代码

    ```matlab
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
    ```

 2. ### 结果

    ![image-20220413234531672](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413234531672.png)

 3. ### 分析：

    > #### 因为三角脉冲函数为离散函数，于是不能使用fourier函数直接进行计算，此处使用了数值计算的方法进行计算。

**(3) 单边指数 信号**
$$
f3 (t) = e^(-t) ε(t)
$$
​	

 1. ### 代码

    ```matlab
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
    ```

 2. ### 结果

    ![image-20220413215613993](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413215613993.png)

    ![image-20220413215545608](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413215545608.png)

    

**(4) 高斯信号**
$$
f3 (t) = e^(-t^2)
$$

 1. ### 代码

    ```matlab
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
    ```

 2. ### 结果

    ![image-20220413215834018](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413215834018.png)

    ![image-20220413215846448](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413215846448.png)

    

##### 3.利用 ifourier( ) 函数求下列频谱函数的傅氏反变换

​	**(1) F(jω) = *−j*** ![img](file:///C:\Users\张文沁\AppData\Local\Temp\ksohtml13468\wps3.jpg)           

 1. ### 代码

    ```matlab
    syms t w					%声明变量
    Fw=sym(-1j*(2*w/(16+w^2)));	%原函数
    Ft=ifourier(Fw,w,t);   		%傅里叶反变换
    Ft							%输出傅里叶反变换之后的函数
    fplot(Ft,[-5 5]);			%绘制傅里叶反变换之后的函数
    grid;
    axis([-5 5 -1 1])
    ```

    

 2. ### 结果

    ![image-20220413220408924](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413220408924.png)

    ![image-20220413220426344](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413220426344.png)

    

​	**(2) F(jω) =** ![img](file:///C:\Users\张文沁\AppData\Local\Temp\ksohtml13468\wps4.jpg)

 1. ### 代码

    ```matlab
    %代码逻辑同（1），不多做解释
    syms t w 
    Fw=sym(((1j*w)^2+5*1j*w-8)/((1j*w)^2+6*1j*w+5));
    Ft=ifourier(Fw,w,t);   
    Ft
    fplot(Ft,[-5 5]);
    grid;
    axis([-5 5 -2 1])
    ```

 2. ### 结果

    ![image-20220413220842491](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413220842491.png)

    ![image-20220413220857122](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413220857122.png)

    

##### **4.设H(jw) = ![img](file:///C:\Users\张文沁\AppData\Local\Temp\ksohtml13468\wps5.jpg) ，试用 MATLAB 画出该系统的幅频特性 H![img](file:///C:\Users\张文沁\AppData\Local\Temp\ksohtml13468\wps6.jpg) (jw) ![img](file:///C:\Users\张文沁\AppData\Local\Temp\ksohtml13468\wps7.jpg) 和相频特性ϕ(ω) ，并分析系统具有什么滤波特性。**

 1. ### 代码

    ```matlab
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
    ```

 2. ### 结果

    ![image-20220413232731186](C:\Users\张文沁\AppData\Roaming\Typora\typora-user-images\image-20220413232731186.png)

 3. ### 分析

    > #### 由图像观察可知H（jw）为低通滤波器

## 3. 实验总结(收获及体会)

> #### 1. 本次实验了解到了在matlab中傅里叶变换的两种实现方式，增加了对傅里叶变换过程的理解，相信今后一定会更加得心应手
>
> #### 2. 本次实验中增加了对matlab中库的了解Symbolic Math Toolbox 
>
> #### 3. 了解了各种离散函数的脉冲表示，例如tripuls（）函数可以生成三角脉冲函数