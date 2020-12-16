% 1�ⲿ�����Լ���MATLAB�Դ���princomp��������PCA��ά��
clc;clear;
nperson=40;    %��������������
imgMatrix=inputImg(nperson,0);   %�����ͼƬ����ת��Ϊ�����б�ʾ���������б�ʾ����ά����
[Coeff,~,latent]=princomp(imgMatrix,'econ');   %PCA��ά��latentΪ����ֵ��CoeffΪ��Ӧ����ֵ�µ�����������
img_train_reduced=imgMatrix*Coeff(:,1:30);     %��ά���ѵ�����ݣ�
multiSVMstruct=multiSVMtrain(img_train_reduced,nperson);  %���ж�����SVMѵ����
[imgMatrix_test,realclass]=inputImg(nperson,1);   %����������ݣ� 
img_test_reduced=imgMatrix_test*Coeff(:,1:30);
% ��ά��Ĳ������ݣ��˴��������¼�������������ԭ���ǲ��Լ���ѵ�������뱣֤ͶӰ��ͬ�������ռ��
class=multiSVM(img_test_reduced,multiSVMstruct,nperson);   %��ÿ�������������з��࣬�������洢��class;
accuracy=sum(class==realclass')/length(class);    %����׼ȷ�ʣ�
msgbox(['ʶ��׼ȷ��:',num2str(accuracy*100),'%']); %��ʾ�����

%2���²��������Լ�д��PCA�������н�ά��
clc;clear;
nperson=40;    %��������������
imgMatrix=inputImg(nperson,0);   %�����ͼƬ����ת��Ϊ�����б�ʾ���������б�ʾ����ά����
mA=mean(imgMatrix);   %�����ݾ���ÿһ�е�ƽ��ֵ��
[V,img_train_reduced]=fpca(imgMatrix,30,mA);  %�õ���ά�������img_train_reduced��
lowvec=min(img_train_reduced,[],1);  %����������Сֵ��
upvec=max(img_train_reduced,[],1);   %�����������ֵ��
% % img_train_reduced = scaling(img_train_reduced,lowvec,upvec);  %���ݹ�һ��
multiSVMstruct=multiSVMtrain(img_train_reduced,nperson);  %���ж�����SVMѵ����
[imgMatrix_test,realclass]=inputImg(nperson,1);   %����������ݣ� 
%ʹ�ò������ݾ�ֵΪ0��
m=size(imgMatrix_test,1);
mdata_testMatrix=repmat(mA,m,1);
testdata=imgMatrix_test-mdata_testMatrix; 
%��ά��Ĳ������ݣ��˴��������¼�����������V��ԭ���ǲ��Լ���ѵ�������뱣֤ͶӰ��ͬ�������ռ��
img_test_reduced=testdata*V;   
% % img_test_reduced = scaling(img_test_reduced,lowvec,upvec);
class=multiSVM(img_test_reduced,multiSVMstruct,nperson);   %��ÿ�������������з��࣬�������洢��class;
accuracy=sum(class==realclass')/length(class);    %����׼ȷ�ʣ�
msgbox(['ʶ��׼ȷ��:',num2str(accuracy*100),'%']); %��ʾ�����