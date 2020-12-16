function [multiSVMstruct]=multiSVMtrain(traindata,nperson)
for i=1:nperson-1
   for j=i+1:nperson
     X=[traindata(5*(i-1)+1:5*i,:);traindata(5*(j-1)+1:5*j,:)];
     Y=[ones(5,1);zeros(5,1)];
     multiSVMstruct{i}{j}=svmtrain(X,Y,'Kernel_Function','linear');
   end
end
end