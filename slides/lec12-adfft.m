mu = [[0,10];[20,0];[-20,0]]; % Initialize initial tree location
sigma = 0.3; % Initialize initial variance, for now all cluster have same varaince
pi = [0.2,0.2,0.6]; % Initialize misture distribution

x = mu; % First three trees are the inital mu locations
Ind1 = 1; % Ind1, In2 and Ind3 hold current locations of each of the three trees
Ind2 = 2;
Ind3 = 3;

for t = 4:10000  % Generate the remaining points 
    r = rand; % This is to pick a tree according to pi
    if(r < pi(1)) 
        c(t) =1;    % Its a red apple
        idx  = Ind1(randi(length(Ind1)));   %  Find a parent by drawing any one of the red apple trees unif at random
        Ind1 = [Ind1;t];        % Update Ind1 the list of red tree indices
    elseif(r < pi(1)+pi(2)) 
        c(t) =2;    %Its a green apple
        idx  = Ind2(randi(length(Ind2)));    %  Find a parent by drawing any one of the green apple trees unif at random
        Ind2 = [Ind2;t];        % Update Ind2 the list of green tree indices
    else
        c(t) =3;    %Its a yellow apple
        idx  = Ind3(randi(length(Ind3)));    %  Find a parent by drawing any one of the yellow apple trees unif at random
        Ind3 = [Ind3;t];        % Update Ind3 the list of yellow tree indices
    end
    x(t,:) = x(idx,:) + randn(1,2)*sigma;   % Generate tree location by drawing from a gaussian centered at parent and variance sigma
end

Scatter plot the locations of the trees according to their color
figure;scatter(x(find(c==3),1),x(find(c==3),2),'y') 
hold on;
scatter(x(find(c==1),1),x(find(c==1),2),'r')
scatter(x(find(c==2),1),x(find(c==2),2),'g')