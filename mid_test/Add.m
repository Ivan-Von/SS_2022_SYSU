clc
close all

A = imread('Albert2.png');
B = imread('Marial2.png');
subplot(241),imshow(A),title('原图像1');
subplot(245),imshow(B),title('原图像2');

%低通滤波
[m,n] = size(A);
A = im2double(A);
F = fft2(A,2*m,2*n);
F1 = fftshift(F);
D0 = 60;
H = GaussianLowpass(A,D0);
G1 = F1.*H;
F2 = ifftshift(G1);
output1 = ifft2(F2);
output1 = output1(1:size(A,1),1:size(A,2)); 
subplot(242),imshow(output1),title('低通D0=60');

[m,n] = size(B);
B = im2double(B);
F = fft2(B,2*m,2*n);
F1 = fftshift(F);
D0 = 60;
H = GaussianLowpass(B,D0);
G2 = F1.*H;
F2 = ifftshift(G2);
output2 = ifft2(F2);
output2 = output2(1:size(B,1),1:size(B,2)); 
subplot(246),imshow(output2),title('低通D0=60');

%高通滤波：
[a,b] = size(A);
F = fft2(A,2*a,2*b);
F3 = fftshift(F);
W = zeros(2*a,2*b);
D0=60;
for u = 1:2*a
    for v = 1:2*b
        D_square = (u-a) * (u-a) + (v-b) * (v-b); 
        W(u,v) =1 - exp(-D_square/(2*D0*D0));        
    end
end
G11 = F3.*W;
F4 = ifftshift(G11);
F1 = ifft2(F4);
F1 = F1(1:size(A,1),1:size(A,2)); 
subplot(243),imshow(F1),title('高通D0=60');

[a,b] = size(B);
F = fft2(B,2*a,2*b);
F3 = fftshift(F);
W = zeros(2*a,2*b);
D0=60;
for u = 1:2*a
    for v = 1:2*b
        D_square = (u-a) * (u-a) + (v-b) * (v-b); 
        W(u,v) =1 - exp(-D_square/(2*D0*D0));        
    end
end
G22 = F3.*W;
F4 = ifftshift(G22);
F2 = ifft2(F4);
F2 = F2(1:size(B,1),1:size(B,2)); 
subplot(247),imshow(F2),title('高通D0=60');

%图像合成
GE = G1 + G22;
F5 = ifftshift(GE);
F6 = ifft2(F5);
F6 = F6(1:size(A,1),1:size(A,2));
subplot(244),imshow(F6),title('低通1+高通2');

GE = G2 + G11;
F5 = ifftshift(GE);
F6 = ifft2(F5);
F6 = F6(1:size(A,1),1:size(A,2));
subplot(248),imshow(F6),title('低通2+高通1');

function H = GaussianLowpass(img,D0)
% 高斯低通滤波器
[M,N] = size(img);
H = zeros(2*M,2*N);

for u = 1:2*M
    for v = 1:2*N
        D_square = (u-M) * (u-M) + (v-N) * (v-N); 
        H(u,v) = exp(-D_square/(2*D0*D0));        
    end
end
 
end