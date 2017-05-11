% Use the Likelihood weighted (importance weighted) sampling procedure for this Bayesian
% Network. Submit 100 samples in file ?sample.csv? where each line is a vector of length
%3 separated by commas and you will provide 100 lines, one for each sample
N=100;
w=zeros(N,1);
x=zeros(N,3);
x(:,2)=1;
for t=1:N
    w(t)=1;
    for i=1:3
        if i==1
            
            if rand()<=0.1
            x(t,i)=1;
            else
            x(t,i)=0; 
            end
            
        elseif i==2
            
            if x(t,1)==1;
               w(t)= w(t)*0.3;
            else
               w(t)= w(t)*0.4;
            end
            
        elseif i==3
            
            if x(t,1)==1
                if rand()<=0.2
                    x(t,i)=1; 
                else
                    x(t,i)=0; 
                end
                
            elseif x(t,1)==0
                if rand()<=0.5
                    x(t,i)=1; 
                else
                    x(t,i)=0; 
                end
            end
            
        end
                           
    end
end

%% Based on the sample, compute empirical marginal distributions for P(X1|X2 = 1),P(X3|X2 = 1) 
s1=0;
s2=0;
s3=0;
s4=0;

for t=1:N
    if x(t,1)==1
        s1=s1+w(t);
    elseif x(t,1)==0
        s2=s2+w(t);
    end
    if x(t,3)==1
        s3=s3+w(t);
    elseif x(t,3)==0
        s4=s4+w(t);
    end
end

p1=s1/sum(w);
p2=s2/sum(w);
p3=s3/sum(w);      
p4=s4/sum(w);

%a)
csvwrite('sample.csv',x);






        