%% load data
load('../data/covariance_6.mat');
load('../data/returns_6.mat');

%% define the model parameters

n = size(V,1); % Number of bonds

gamma = 0;%set to zero for classic mean variance model, 100 for regularization model
lambda = 0.0002; %set to 0 for classic mean variance model, 0.02 for regularization model
lambda = repmat(lambda,1,n);
norm = 1;
%% optimize the model
[y,x] = optimize_portfolio(U,V,gamma,lambda,norm,n);

%% plot the distribution
figure (1);
bar(x);