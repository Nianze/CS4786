XA=csvread('a1\q2\XA.csv');
XB=csvread('a1\q2\XB.csv');
XC=csvread('a1\q2\XC.csv');
LabelAB=csvread('a1\q2\LabelAB.csv');
LabelABC=csvread('a1\q2\LabelABC.csv');

X_AB=[XA XB];
sigma_AB=cov(X_AB);
sigma_11=sigma_AB(1:10,1:10);
sigma_12=sigma_AB(1:10,11:20);
sigma_21=sigma_AB(11:20,1:10);
sigma_22=sigma_AB(11:20,11:20);
[W,~]=eigs(sigma_11^-1*sigma_12*sigma_22^-1*sigma_22,5)

XA_centered=XA-ones(size(XA,1),1)*mean(XA);
Y_AB=XA_centered*W;

X_AB_rec=Y_AB*W'+ones(size(XA,1),1)*mean(XA);

X_ABC=[X_AB_rec XC];
sigma_ABC=cov(X_ABC);
sigma_ABC_11=sigma_ABC(1:10,1:10);
sigma_ABC_12=sigma_ABC(1:10,11:20);
sigma_ABC_21=sigma_ABC(11:20,1:10);
sigma_ABC_22=sigma_ABC(11:20,11:20);
[W_ABC,~]=eigs(sigma_ABC_11^-1*sigma_ABC_12*sigma_ABC_22^-1*sigma_ABC_21,1);

X_AB_centered=X_AB_rec-ones(size(X_AB_rec,1),1)*mean(X_AB_rec);
Y_ABC=X_AB_centered*W_ABC;

Y_ABC_sign=(sign(Y_ABC)+1)/2;

acc_ABC=0;
for i=1:1000
    if(Y_ABC_sign(i)==LabelABC(i))
        acc_ABC=acc_ABC+1;
    end
end
csvwrite('YABC.csv',Y_ABC_sign);
acc_ABC

[W_AB,~]=eigs(sigma_ABC_11^-1*sigma_ABC_12*sigma_ABC_22^-1*sigma_ABC_21,10);
Y_AB=X_AB_centered*W_AB(:,9);
Y_AB=(sign(Y_AB)+1)/2;

acc_AB=0;
for i=1:1000
    if(Y_AB(i)==LabelAB(i))
        acc_AB=acc_AB+1;
    end
end
csvwrite('YAB.csv',Y_AB);
acc_AB
