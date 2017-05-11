function c=kmean(y)

%% K mean
mu1_old=[0,0];
mu2_old=[0,0];

mu1_new=[0.267,0];
mu2_new=[0,0.267];


c=zeros(length(y),1);% identify the cluster assignment

while max(mu1_old~=mu1_new)||max(mu2_old~=mu2_new)
       
    mu1_old=mu1_new;
    mu2_old=mu2_new;
    
   
    dis1=sum((y-repmat(mu1_old,length(y(:,1)),1)).^2,2);
    dis2=sum((y-repmat(mu2_old,length(y(:,1)),1)).^2,2);
    
    c1=0; % number of data in cluster 1
    c2=0; % number of data in cluster 2
    sum_c1=[0,0];
    sum_c2=[0,0];
    
    for i=1:30 %length(y2(:,1))
        if (dis1(i)-dis2(i))<=0
            c(i,:)=1;% i is in cluster 1
            c1=c1+1;
            sum_c1=sum_c1+y(i,:);
        else
            c(i,:)=0;% i is in cluster 2
            c2=c2+1;
            sum_c2=sum_c2+y(i,:);
            
        end
    end
    
    mu1_new=sum_c1/c1;
    mu2_new=sum_c2/c2;
   
end