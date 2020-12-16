% 1这部分是自己用MATLAB自带的princomp函数进行PCA降维；
clc;clear;
nperson=40;    %输入的样本类别数
imgMatrix=inputImg(nperson,0);   %输入的图片数据转换为矩阵，行表示样本数，列表示特征维数；
[Coeff,~,latent]=princomp(imgMatrix,'econ');   %PCA降维；latent为特征值，Coeff为相应特征值下的特征向量；
img_train_reduced=imgMatrix*Coeff(:,1:30);     %降维后的训练数据；
multiSVMstruct=multiSVMtrain(img_train_reduced,nperson);  %进行多分类的SVM训练；
[imgMatrix_test,realclass]=inputImg(nperson,1);   %输入测试数据； 
img_test_reduced=imgMatrix_test*Coeff(:,1:30);
% 降维后的测试数据；此处不用重新计算特征向量的原因是测试集跟训练集必须保证投影在同个特征空间里；
class=multiSVM(img_test_reduced,multiSVMstruct,nperson);   %对每个测试样本进行分类，分类结果存储于class;
accuracy=sum(class==realclass')/length(class);    %计算准确率；
msgbox(['识别准确率:',num2str(accuracy*100),'%']); %显示结果；

%2以下部分是用自己写的PCA函数进行降维；
clc;clear;
nperson=40;    %输入的样本类别数
imgMatrix=inputImg(nperson,0);   %输入的图片数据转换为矩阵，行表示样本数，列表示特征维数；
mA=mean(imgMatrix);   %求数据矩阵每一列的平均值；
[V,img_train_reduced]=fpca(imgMatrix,30,mA);  %得到降维后的数据img_train_reduced；
lowvec=min(img_train_reduced,[],1);  %沿列向求最小值；
upvec=max(img_train_reduced,[],1);   %沿列向求最大值；
% % img_train_reduced = scaling(img_train_reduced,lowvec,upvec);  %数据归一化
multiSVMstruct=multiSVMtrain(img_train_reduced,nperson);  %进行多分类的SVM训练；
[imgMatrix_test,realclass]=inputImg(nperson,1);   %输入测试数据； 
%使得测试数据均值为0；
m=size(imgMatrix_test,1);
mdata_testMatrix=repmat(mA,m,1);
testdata=imgMatrix_test-mdata_testMatrix; 
%降维后的测试数据；此处不用重新计算特征向量V的原因是测试集跟训练集必须保证投影在同个特征空间里；
img_test_reduced=testdata*V;   
% % img_test_reduced = scaling(img_test_reduced,lowvec,upvec);
class=multiSVM(img_test_reduced,multiSVMstruct,nperson);   %对每个测试样本进行分类，分类结果存储于class;
accuracy=sum(class==realclass')/length(class);    %计算准确率；
msgbox(['识别准确率:',num2str(accuracy*100),'%']); %显示结果；