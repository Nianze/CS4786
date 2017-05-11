% set1 was setup to have a better performance on pca.
% since all vector points in sets will be normalized to have unit length
% and we would like to scatter set1 as linearly as possible, so I picked an
% arc on the sphere.
set1=ones(100,998);
a=rand(100,1)/4*pi;
x=[];
y=[];
for i=1:100
    x(i)=1*sin(a(i));
    y(i)=1*cos(a(i));
end
% plot(x,y,'b.')
% axis([-1 1 -1 1])
set1=[set1 x' y'];


% set2 was set up to have a better performance on random projection.

% set2=zeros(100,1000);

set2=rand(100,1000)*2-1;

for i=1:100
    set1(i,:)=set1(i,:)/norm(set1(i,:));
    set2(i,:)=set2(i,:)/norm(set2(i,:));
end
csvwrite('pca_set.csv',set1);
csvwrite('rp_set.csv',set2)

[y1_pca,~]=pca(set1,20);
y1_rp=rp(set1,20);

[y2_pca,~]=pca(set2,20);
y2_rp=rp(set2,20);

err=[ttlerr(set1,y1_pca) ttlerr(set1, y1_rp);ttlerr(set2,y2_pca) ttlerr(set2,y2_rp)]