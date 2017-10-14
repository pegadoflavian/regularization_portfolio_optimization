function [y,x,returns,sharpe_ratio,v_p,v_a] = optimize_portfolio(U,V,gamma,lambda,norm,n)
    
    cvx_begin
        variable x(n)
        y = U*x  - lambda*(x.^norm) - (gamma/2)*x'*V*x;
        %y = x'*V*x + lambda*(x.^norm);
        %Constraints
        ones(1,n)*x == 1; % Fully invested
        x >=  zeros(n,1);   % Long and not short
        U*x >= 0;
        
        %y >= 0;
        %minimize y
        maximize y
    cvx_end
    
    returns = U*x;
    sharpe_ratio = U*x/sqrt(x'*V*x);
    v_p = sqrt(x'*V*x);%volatility
    v_a = 0;
    for i = 1:n
        x_i = zeros(n,1);
        x_i(i) = 1;
        v_a = v_a + x(i)* x_i'*V*x_i;
    end 
    
end