I=imread('couple256.bmp'); %ԭʼͼ
[m,n] = size(I);         %ͼ�Ĵ�С
I=double(I);

%������ 
std_n=5; % ��˹������׼��
In = randn(size(I))*std_n; % ��˹�������
IO = I + In;  % IOΪ������ͼ��

%%IO_eage=sobel4_grad(IO);
%%figure(1);
%%imshow(IO_edge);title('4�����Ե')

%fs=fspecial('gaussian');
%IO_=imfilter(IO,fs,'symmetric');
%figure(1);
%imshow(double(IO));title('����ͼ')
%imwrite(double(IO),'edge0.bmp');

IO_edge=sobel8_grad(IO);
figure(2);
imshow(IO_edge);title('8�����Ե')
imwrite(IO_edge,'edge1.bmp');

IO_edge=edge(IO,'sobel');
figure(3);
imshow(IO_edge);title('sobel��Ե')
imwrite(IO_edge,'edge2.bmp');