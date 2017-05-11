clc
clear all
close all

%% AspectralI generation
% A is a matrix that 1-2-3-...-15 connected, 16-17-...-30 connected
data=zeros(30,30); 
for i=1:29
    data(i,i+1)=1;
    data(i+1,i)=1;
end

data(15,16)=0;
data(16,15)=0;

csvwrite('AspetralI.csv',data); 
A1=data;
D1=diag(sum(A1,2));
L1=eye(30,30)-D1^(-1/2)*A1*D1^(-1/2);
[vector1, value1]=eig(L1);

y1=vector1(:,1:2);

c1=kmean(y1);
csvwrite('cspectralI.csv', c1);

%% modify the data
% add a link for (1,16), (15,30),(9,23)
data(1,16)=1;
data(16,1)=1;
data(15,30)=1;
data(30,15)=1;
data(9,23)=1;
data(23,9)=1;

csvwrite('AspetralII.csv',data);

A2=data;
D2=diag(sum(A2,2));
L2=eye(30,30)-D2^(-1/2)*A2*D2^(-1/2);
[vector2, value2]=eig(L2);

y2=vector2(:,1:2);

c2=kmean(y2);
csvwrite('cspectralII.csv', c2);

%% difference
c3=~c2;
numdiff1=nnz(c1-c2);
numdiff2=nnz(c1-c3);
vary=min(numdiff1,numdiff2)/30;

