function [ err ] = ttlerr( x, y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
l=length(x);
err=0;
for i=1:l
    for j=i+1:l
      err=err+abs(norm(y(i)-y(j))-norm(x(i)-x(j)));
    end
end
err=err/(l*(l-1)/2);
end

