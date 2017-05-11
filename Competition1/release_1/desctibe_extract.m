clc;
clear;
Description = csvread('description.csv');
Vecone = ones(1416322,1);
Veczero = zeros(1416322,1);
Temp1 = [Vecone,Vecone,Veczero];

X = spconvert(Description + Temp1); 

sample = csvread('category_partial_supervision.csv');

centroid = zeros(13,8000);

for i = 1 : 13
    centroid(i,:) = mean([X(sample(3*(i-1)+1),:);X(sample(3*(i-1)+2),:);X(sample(3*(i-1)+3),:)]);
end 

C = kmeans(full(X), 13, 'Start',centroid)-1;

headers = {'index','category'};
data = [];
for i=0:1828
    data = [data;i,C(i+1)];
end
csvwrite_with_headers('task2.csv',data,headers);