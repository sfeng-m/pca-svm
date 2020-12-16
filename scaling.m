function [scaleddata] = scaling(traindata,lowvec,upvec)
[m,n]=size(traindata);
scaleddata=zeros(m,n);
for i=1:m
   scaleddata(i,:)=-1+(traindata(i,:)-lowvec)./(upvec-lowvec)*2;
end
end