clear all;
%perturb the dataset
load('../data/covariance_6.mat');
load('../data/returns_6.mat');
T = 50;
U_t = [];
V_t = [];
for i = 1:T
    mu = mvnrnd(U,V);
    U_t = [U_t;mu];
end

U = 1/T * (sum(U_t,1));
V = cov(U_t);

save('../data/covariance_6_pert.mat','V');
save('../data/returns_6_pert.mat','U');
