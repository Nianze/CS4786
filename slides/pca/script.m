clear;

% Load images and convert them to vector format
for t = 1:28
    I(:,:,t) = rgb2gray(imread(['smilie',num2str(t),'.jpeg']));
    temp = I(:,:,t);
    X(t,:) = double(temp(:));
end

% now X is the data matrix and each row of X corresponds to one data point

Mu = mean(X);

% Mu is the mean vector of all the smilie faces (in vector format)

Sigma = cov(X);

% Matlab does the covariance calculation for you using function cov

K = 8;  % we pick the top 20 eigen vectors

[W,D] = eigs(Sigma,K);

% The above is a matlab function that returns the top 20 eigen vectors in
% matrix W and D is the diagonal matrix of the eigen values


Y = (X-repmat(Mu,[28,1]))*W;

% Here is the line that does the linear projection to lower dimension
% We are doing all the 28 ones in a batch and repmat repeats the single
% mean vector 28 times


% First column of Y is the data on first principal component, second column
% is the second principal component and so on


%The below snippet that shows the 2 dimensional scatter plot of the images
scatter(Y(:,1), Y(:,2))
hold on
for t = 1:28
image([Y(t,1),Y(t,1)+400], [Y(t,2),Y(t,2)-400],I(:,:,t));
end
% notice that the wink images are seperated from the other ones



%Image reconstruction
%Lets see how the reconstrcuted image looks like

Xhat = Y*W' + repmat(Mu,[28,1]);

% Xhat is the vectorized version, let us put vectors back into images

for t = 1:28
    for n = 1:105
        for m = 1:105
            Ihat(n,m,t) = Xhat(t,(m-1)*105+ n);
        end
    end
end

% Let us pick a random image out of the 28 and see the reconstructed one
% versus the original

R = randi(28);
figure;
image(Ihat(:,:,R));
figure;
image(I(:,:,R));
% Play around with K to see the difference


%Now let us see how PCA performs when pick a new x_{n+1} outside of the
%original set of n points.

% Using PCA to classify, two example images testsmilie1 and testsmilie2
% are provided in the list of images


% Lets load and vectorize these images
for t = 1 :2
    Itest(:,:,t) = rgb2gray(imread(['testsmilie',num2str(t),'.jpg']));
    temp = Itest(:,:,t);
    Xtest(t,:) = double(temp(:));
end


% Now we project to lower dimension

Ytest = (Xtest-repmat(Mu,[2,1]))*W;

% For fun let us do the nearest neighbor search on the lower dimensional
% representation of the image. That is given the new point Xtest we project
% it to Ytest and retrieve the y_t closest from the 28 images we ran PCA on

for i = 1:2
    for t = 1:28
        dis(t) = norm(Ytest(i,:)-Y(t,:));
    end
    indx(i) = find(dis==min(dis));
end

% Just to compare let us do the same nearest neighbor search in the
% original d dimensional space

for i = 1:2
    for t = 1:28
        dis(t) = norm(Xtest(i,:)-X(t,:));
    end
    originalindx(i) = find(dis==min(dis));
end

%Just for fun, lets look at the images we retrieved and the original images
for i = 1:2
    figure;
    image(Itest(:,:,i));
    %figure;
    %image(I(:,:,indx(i)));
    figure;
    image(I(:,:,originalindx(i)));
end


% Here is the surprise, as K becomes large, naturally reconstruction
% quality improves. However notice that when K is large, especially for the
% second test image nearest neighbor search deteriorates but for small K
% the wink images are better retrieved. This is because PCA is removing
% irrelavant information and noise

