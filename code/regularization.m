clear all;
%% load data
covariance = load('../data/covariance_6.mat');
returns = load('../data/returns_6.mat');
U = returns.U;
V = covariance.V;

covariance_pert = load('../data/covariance_6_pert.mat');
returns_pert = load('../data/returns_6.mat');
Up = returns_pert.U;
Vp = covariance_pert.V;

analysis = [];

%% Classical mean variance model for minimum risk
% define the model parameters

n = size(V,1); % Number of bonds

gamma = 100;%set to zero for classic mean variance model, 100 for regularization model
lambda = 0; %set to 0 for classic mean variance model, 0.02 for regularization model
lambda = repmat(lambda,1,n);
norm = 1;
% optimize the model
[y,x,returns,sharpe_ratio,v_p,v_a] = optimize_portfolio(U,V,gamma,lambda,norm,n);
analysis = [analysis; returns,sharpe_ratio,v_p,v_a];

% plot the distribution
figure (1);
subplot(2,2,1);
bar(x);
xlabel('Assest');
ylabel('Holding');
title('Mean-variance: Maximize returns');
axis([0 n 0 1]);

%% Addidng Regularization
% define the model parameters

n = size(V,1); % Number of bonds

gamma = 100;%set to zero for classic mean variance model, 100 for regularization model
lambda = 0.5; %set to 0 for classic mean variance model, 0.02 for regularization model
lambda = repmat(lambda,1,n);
norm = 2;
% optimize the model
[y,x,returns,sharpe_ratio,v_p,v_a] = optimize_portfolio(U,V,gamma,lambda,norm,n);
analysis = [analysis; returns,sharpe_ratio,v_p,v_a];

% plot the distribution
figure (1);
subplot(2,2,2);
bar(x);
xlabel('Assest');
ylabel('Holding');
title('Mean-variance: Maximize returns with added L2 norm');
axis([0 n 0 1]);
%% Classical mean variance model for minimum risk for perturbed portfolio
% define the model parameters

n = size(V,1); % Number of bonds

gamma = 100;%set to zero for classic mean variance model, 100 for regularization model
lambda = 0; %set to 0 for classic mean variance model, 0.02 for regularization model
lambda = repmat(lambda,1,n);
norm = 1;
% optimize the model
[y,x,returns,sharpe_ratio,v_p,v_a] = optimize_portfolio(Up,Vp,gamma,lambda,norm,n);
analysis = [analysis; returns,sharpe_ratio,v_p,v_a];

% plot the distribution
figure (1);
subplot(2,2,3);
bar(x);
xlabel('Assest');
ylabel('Holding');
title('Mean-variance: Maximize returns, after perturbations ');
axis([0 n 0 1]);
%% Addidng Regularization
% define the model parameters

n = size(V,1); % Number of bonds

gamma = 100;%set to zero for classic mean variance model, 100 for regularization model
lambda = 0.5; %set to 0 for classic mean variance model, 0.02 for regularization model
lambda = repmat(lambda,1,n);
norm = 2;
% optimize the model
[y,x,returns,sharpe_ratio,v_p,v_a] = optimize_portfolio(Up,Vp,gamma,lambda,norm,n);
analysis = [analysis; returns,sharpe_ratio,v_p,v_a];

% plot the distribution
figure (1);
subplot(2,2,4);
bar(x);
xlabel('Assest');
ylabel('Holding');
title('Mean-variance: Maximize returns, with added L2 norm after perturbations');
axis([0 n 0 1]);