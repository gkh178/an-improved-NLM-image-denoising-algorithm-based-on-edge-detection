%����sobel8_grad�Ľ��MΪ��Ե��ֵ����
%����sobel���Ӱ˷���3*3ģ��
function M=sobel8_grad(f)
f=double(f);
[m,n]=size(f);
%��ԭͼ����һ��һ������
f=[zeros(m,1) f zeros(m,1)];
f=[zeros(1,n+2);f;zeros(1,n+2)];
new=f;

%0,45,90,135,180,225,270,315�˸������sobel���Ӿ������
h1=[-1,-2,-1;0,0,0;1,2,1];
h2=[-2,-1,0;-1,0,1;0,1,2];
h3=[-1,0,1;-2,0,2;-1,0,1];
h4=[0,1,2;-1,0,1;-2,-1,0];
h5=[1,2,1;0,0,0;-1,-2,-1];
h6=[2,1,0;1,0,-1;0,-1,-2];
h7=[1,0,-1;2,0,-2;1,0,-1];
h8=[0,-1,-2;1,0,-1;2,-1,0];

for i=2:m+1 %i������
    for j=2:n+1   %j������
		f0=[f(i-1,j-1),f(i-1,j),f(i-1,j+1);%f0Ϊ��f(i,j)Ϊ���ĵ�3*3�ҶȾ���
		f(i,j-1),f(i,j),f(i,j+1);
		f(i+1,j-1),f(i+1,j),f(i+1,j+1)];
		%8������ͬ���
        H1=sum(sum(h1.*f0));
        H2=sum(sum(h2.*f0));
        H3=sum(sum(h3.*f0));
        H4=sum(sum(h4.*f0));
        H5=sum(sum(h5.*f0));
        H6=sum(sum(h6.*f0));
        H7=sum(sum(h7.*f0));
        H8=sum(sum(h8.*f0));
       %% h=H1+H2+H3+H4+H5+H6+H7+H8;
		h=[H1,H2,H3,H4,H5,H6,H7,H8];%ȡ����ݶ�ֵ
        delta_g(i,j)=max(h); %������ݶ�ֵ����delta_g����
    end 
end

%%������Ϊ������ֵT���ݶȾ��������ֵ�ָ�
T0=sum(sum(delta_g(2:m+1,2:n+1)))/(m*n);%��ֵ��ֵΪ�ݶȾ����ƽ��ֵ
u1=0;%u1Ϊ����T0�Ĳ��ֵľ���Ԫ�ص�ƽ��ֵ
c1=0;%ͳ�ƴ���T0��Ԫ�ظ���
u2=0;%u2ΪС�ڵ���T0�Ĳ��ֵľ���Ԫ�ص�ƽ��ֵ
c2=0;%ͳ��С�ڵ���T0��Ԫ�ظ���
sig=150;%�޶�ϵ��
for i=1:m+1
	for j=2:n+1
		if(delta_g(i,j)>T0) 
			u1=u1+delta_g(i,j);
			c1=c1+1;
		else
			u2=u2+delta_g(i,j);
			c2=c2+1;
		end
	end
end
u1=u1/c1;
u2=u2/c2;
T=(u1+u2)/2;

u1=0;
c1=0;
u2=0;
c2=0;
while(abs(T0-T)>sig)
	T0=T
	for i=1:m+1
		for j=2:n+1
			if(delta_g(i,j)>T0)
				u1=u1+delta_g(i,j);
				c1=c1+1;
			else
				u2=u2+delta_g(i,j);
				c2=c2+1;
			end
		end
	end
	u1=u1/c1;
	u2=u2/c2;
	T=(u1+u2)/2;
end

%%���ݶȷ�ֵͼ�������ֵ�ָ�	
for i=2:m+1  %i������
    for j=2:n+1  %j������
		if(delta_g(i,j)>T) %�ж��ݶ�ֵ�Ƿ������ֵ
			new(i,j)=1;
		else
			new(i,j)=0;
		end
	end
end		

M=new(2:m+1,2:n+1);%���new����Ҫ�ľ��󲿷�

