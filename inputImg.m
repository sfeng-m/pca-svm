function [imgMatrix,realClass]=inputImg(nperson,flag)
imgRow=112;
imgCol=92;
imgMatrix=zeros(nperson*5,imgRow*imgCol);

for i=1:nperson
facepath='E:\SHI\模式识别学习资料\人脸识别\facePCAsvm\face\orl_faces\s';
facepath=strcat(facepath,num2str(i));
facepath=strcat(facepath,'\');
temppath=facepath;
   for j=1:5
       if flag==0
      facepath=strcat(temppath,'0'+j);
       else
         facepath=strcat(temppath,num2str(5+j));  
         realClass(5*(i-1)+j)=i;
       end
   facepath=strcat(facepath,'.pgm');
   img=imread(facepath);
   imgMatrix(5*(i-1)+j,:)=img(:)';
   end
end
end
