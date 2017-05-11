function [ y ] = rp( x,k )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
d=size(x,2);
ran=sign(rand(d,k)-0.5);
y=x*ran;

end

