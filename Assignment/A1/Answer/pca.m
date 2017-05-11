function [ y, mu, w ] = pca( x, k )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
l=size(x,1);
mu=mean(x);
x_centered=x-ones(l,1)*mu;
sigma=cov(x_centered);
[w,~]=eigs(sigma,k);
y=x*w;

end

