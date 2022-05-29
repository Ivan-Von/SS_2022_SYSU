function [f,k]=dconv(f1,f2,k1,k2)
%The function of computef=f1*f2
%f 卷积和序列 f(k)对应的非零样值向量
%k 序列 f(k)的对应序号向量
%f1 序列 f1(k)非零样值向量
%f2 序列 f2(k)非零样值向量
%k1 序列 f1(k)的对应序号向量
%k2 序列 f2(k)的对应序号向量
f=conv(f1,f2) %计算序列 f1 与 f2 的卷积和 f
k0=k1(1)+k2(1); %计算序列 f 非零样值的起点位置
k3=length(f1)+length(f2)-2; %计算卷积和 f 非零样值的宽度
k=k0:k0+k3; %确定卷积和 f 非零样值的序号向量
subplot(2,2,1);
stem(k1,f1) %在子图 1 绘序列 f1(k)的波形
title('f1(k)')
xlabel('k')
ylabel('f1(k)')
subplot(2,2,2);
stem(k2,f2) %在子图 2 绘序列 f2(k)的波形
title('f1(k)')
xlabel('k')
ylabel('f2(k)')
subplot(2,2,3);
stem(k,f); %在子图 3 绘序列 f(k)的波形
title('f1(k)与 f2(k)的卷积和 f(k)')
xlabel('k')
ylabel('f(k)')
h=get(gca,'position');
h(3)=2.5*h(3);
set(gca,'position',h)