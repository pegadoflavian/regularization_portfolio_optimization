
% Number of bonds
n = 8; 
T = 1;

% Co-Variance of return
V = [0.00024336	0.000288475	0.00028314	0.000285137	0.00027169	0.000175718	0.000271892	0.000281736
0.000288475	0.00040401	0.00028743	0.000310867	0.000337559	0.000198106	0.000302003	0.000311148
0.00028314	0.00028743	0.003025	0.001585265	0.0010263	0.000968	0.00191719	0.00167915
0.000285137	0.000310867	0.001585265	0.00494209	0.002711049	0.00207863	0.002281516	0.001330076
0.00027169	0.000337559	0.0010263	0.002711049	0.00386884	0.001532608	0.001794346	0.000909364
0.000175718	0.000198106	0.000968	0.00207863	0.001532608	0.00495616	0.001692416	0.000665984
0.000271892	0.000302003	0.00191719	0.002281516	0.001794346	0.001692416	0.00361201	0.001447208
0.000281736	0.000311148	0.00167915	0.001330076	0.000909364	0.000665984	0.001447208	0.001849];

%Mu of return
mu = [0.2700    0.2500    0.3900    0.8800    0.5300    0.8800    0.7900    0.7100];

gamma = 0;
returns = zeros(T,1);
mean = zeros(T,n);
for i = 1:T
    U = mvnrnd(mu,V);
    cvx_begin
        variable x(n)
        y = U*x - (gamma/2)*x'*V*x;
        %Constraints
        ones(1,n)*x == 1; % Fully invested
        x >=  zeros(n,1);   % Long and not short
        y >= 0;
        maximize y
    cvx_end
    returns(i,1) = y;
    mean(i,:) = U;
end
figure (1);
bar(x);