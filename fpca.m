function [V,pcaData]=fpca(traindata,k,mA)
m=size(traindata,1);
% mdata=mean(traindata,1);
mdata_matrix=repmat(mA,m,1);
z=traindata-mdata_matrix;  %使得原始数据均值为0；
A=z*z';
[U,D]=eigs(A,k);   %计算A的前K个特征值对角阵D与特征向量U；其中U为z*z'的特征向量；
D=inv(D);          %求矩阵的逆；
V=z'*U*D;          %V为z'*z的特征向量；这一步是按照自己对SVD的理解写的，不一定正确，但对结果影响不大；
%  V=z'*U;         %如果对上一步有疑问，可以用这一步代替，我看别人是这样写的；
for i=1:k         %特征向量单位化  
    l=norm(V(:,i));  
    V(:,i)=V(:,i)/l;  
end 
pcaData=z*V; 
end
