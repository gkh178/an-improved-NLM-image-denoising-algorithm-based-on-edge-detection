function [output]=NLmeans(input,t,f,h)
 
 %  ����: ��ƽ����ͼ��
 %  t: �������ڰ뾶
 %  f: �����Դ��ڰ뾶
 %  h: ƽ������
 %  NLmeans(ima,5,2,sigma); 

 % ͼ���С
 [m n]=size(input);
  % ���
 Output=zeros(m,n);
 input2 = padarray(input,[f+t f+t],'symmetric');%�߽����Գƴ���
 
 % ��˹��
 kernel = make_kernel(f);
 kernel = kernel / sum(sum(kernel));
 

 
 for i=1:m
    for j=1:n
                 
         i1 = i+ f+t;%ԭʼͼ�������λ�� ���������أ�
         j1 = j+ f+t;
                
         W1= input2(i1-f:i1+f , j1-f:j1+f);%С����
         
         wmax=0; 
         average=0;
         sweight=0;
         
         %rmin = max(i1-t,f+1);
         %rmax = min(i1+t,m+f);
         %smin = max(j1-t,f+1);
         %smax = min(j1+t,n+f);
         rmin=i1-t;
         rmax=i1+t;
         smin=j1-t;
         smax=j1+t;
         
         for r=rmin:1:rmax %�󴰿�
            for s=smin:1:smax
                                               
                if(r==i1 && s==j1) 
                    continue; 
                end;
                                
                W2= input2(r-f:r+f , s-f:s+f);    %�����������е�С�����Դ���     
                d = sum(sum(kernel.*(W1-W2).*(W1-W2)));
                w=exp(-d/(h^2)); %Ȩ��      
                                 
                if w>wmax                
                    wmax=w;   %�����Ȩ��            
                end
                
                sweight = sweight + w;  %�󴰿��е�Ȩ�غ�
                average = average + w*input2(r,s);                                  
            end 
         end
             
        average = average + wmax*input2(i1,j1);
        sweight = sweight + wmax;
                   
        if sweight > 0
            output(i,j) = average / sweight;
        else
            output(i,j) = input(i,j);
        end                
    end
 end
 
function [kernel] = make_kernel(f)    %�˺���  
 
kernel=zeros(2*f+1,2*f+1);   
for d=1:f    
  value= 1 / (2*d+1)^2 ;    
  for i=-d:d
     for j=-d:d
        kernel(f+1-i,f+1-j)= kernel(f+1-i,f+1-j) + value ;
    end
  end
end
kernel = kernel ./ f;
        