Xbad=csvread('a1\q1\Xbad.csv');
X_bad=Xbad;
W=csvread('a1\q1\W.csv');
mu=csvread('a1\q1\mu.csv');
Y1=csvread('a1\q1\Y1.csv');

mu_bad=mean(X_bad);
X_bad_centered=X_bad-ones(size(X_bad,1),1)*mu_bad;
sigma_bad=cov(X_bad_centered);
[W_bad,~]=eigs(sigma_bad,20);
Y_bad=X_bad_centered*W_bad;

signy=ones(1,20);

for i=1:20
    if Y1(i)*Y_bad(1,i)<0
        signy(i)=-1;
    end
end

for i=1:28
    Y_bad(i,:)=Y_bad(i,:).*signy;
end

X_rec=Y_bad*W'+ones(size(Y_bad,1),1)*mu;
csvwrite('X.csv',X_rec)

for t=1:28
    for m=1:105
        for n=1:105
            I_rec(n,m,t)=X_rec(t,(m-1)*105+n);
        end
    end
figure(t)
image(I_rec(:,:,t))
end
% 
