% generate 1000 2d var X
X=[randn(1000,1) randn(1000,1)*2^0.5]
% scatter
plot(X(:,1),X(:,2),'bo')
axis([-4 4 -4 4])
% R
R=[1/2^0.5 -1/2^0.5;1/2^0.5 1/2^0.5]
X_dup=X*R
X_dup=X_dup+ones(1000,2);
hold on
plot(X_dup(:,1),X_dup(:,2),'r*')



mean_x=mean(X)
X=X-ones(1000,1)*mean_x;
sigma=cov(X)
[W,~]=eigs(sigma,2)
Y=X*W



mean_x_dup=mean(X_dup);
X_dup_centered=X_dup-ones(1000,1)*mean_x_dup;
sigma_dup=cov(X_dup_centered)
[W_dup,~]=eigs(sigma_dup,2)
Y_dup=X_dup_centered*W_dup
plot(Y(:,1),Y(:,2),'b.')
hold on
plot(Y_dup(:,1),Y_dup(:,2),'r.')