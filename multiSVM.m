function [class]=multiSVM(testdata,multiSVMstruct,nclass)
m=size(testdata,1);
voting=zeros(m,nclass);
for i=1:nclass-1
    for j=i+1:nclass
     class=svmclassify(multiSVMstruct{i}{j},testdata)
     voting(:,i)=voting(:,i)+(class==1);
     voting(:,j)=voting(:,j)+(class==0);
    end
end
[~,class]=max(voting,[],2)
end