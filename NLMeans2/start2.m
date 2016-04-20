I=imread('barbara256.bmp'); %ԭʼͼ
[m,n] = size(I);         %ͼ�Ĵ�С
I=double(I);

%������
std_n=40; % ��˹������׼��
In = randn(size(I))*std_n; % ��˹�������
IO = I + In;  % IOΪ������ͼ��

%���� 
h=0.8*std_n; %�˲�����
t=5;   %���ƴ��뾶
f=3;   %�������뾶

IO1=NLmeans(IO,t,f,h);% I01ΪNL-Meansȥ����ͼ��

tic;
fs=fspecial('gaussian');
IO_=imfilter(IO,fs,'symmetric');

edge=sobel8_grad(IO_);

IO2=NLmeans2(IO,t,f,h,edge);% I02Ϊ������ȥ����ͼ��
toc;
t=toc;
% ��ʾԭʼͼ������ͼ��NL-Meansȥ��ͼ��NL-Means����������������ȥ��ͼ�񡢱�����ȥ�����
figure(1); imshow(uint8(I));
figure(2); imshow(uint8(IO));
figure(3); imshow(uint8(IO1));
figure(4); imshow(uint8(IO-IO1));
figure(5); imshow(uint8(IO2));
figure(6); imshow(uint8(IO-IO2));

imwrite(uint8(I),'result1.bmp');
imwrite(uint8(IO),'result2.bmp');
imwrite(uint8(IO1),'result3.bmp');
imwrite(uint8(IO-IO1),'result4.bmp');
imwrite(uint8(IO2),'result5.bmp');
imwrite(uint8(IO-IO2),'result6.bmp');

psnr1=PSNR(I,IO1);
mse1=MSE(I,IO1);
fprintf('PSNR1=%f\n',psnr1);
fprintf('MSE1=%f\n',mse1);
psnr2=PSNR(I,IO2);
mse2=MSE(I,IO2);
fprintf('PSNR2=%f\n',psnr2);
fprintf('MSE2=%f\n',mse2);
[mssim1 ssim_map1]=ssim_index(IO, IO1);
fprintf('SSIM1=%f\n',mssim1);
[mssim2 ssim_map2]=ssim_index(IO, IO2);
fprintf('SSIM2=%f\n',mssim2);
fprintf('time=%f\n',t);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
