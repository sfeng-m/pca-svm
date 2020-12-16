function [V,pcaData]=fpca(traindata,k,mA)
m=size(traindata,1);
% mdata=mean(traindata,1);
mdata_matrix=repmat(mA,m,1);
z=traindata-mdata_matrix;  %ʹ��ԭʼ���ݾ�ֵΪ0��
A=z*z';
[U,D]=eigs(A,k);   %����A��ǰK������ֵ�Խ���D����������U������UΪz*z'������������
D=inv(D);          %�������棻
V=z'*U*D;          %VΪz'*z��������������һ���ǰ����Լ���SVD�����д�ģ���һ����ȷ�����Խ��Ӱ�첻��
%  V=z'*U;         %�������һ�������ʣ���������һ�����棬�ҿ�����������д�ģ�
for i=1:k         %����������λ��  
    l=norm(V(:,i));  
    V(:,i)=V(:,i)/l;  
end 
pcaData=z*V; 
end
