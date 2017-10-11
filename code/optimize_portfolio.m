function [y,x] = optimize_portfolio(U,V,gamma,lambda,norm,n)
    
    cvx_begin
        variable x(n)
        %y = U*x  - lambda*(1-x) - (gamma/2)*x'*V*x;
        h = (x >= 0.005*ones(n,1) );
        
        y = x'*V*x + h'*h %+ ones(1,n)*(h)%lambda;
        %Constraints
        ones(1,n)*x == 1; % Fully invested
        x >=  zeros(n,1);   % Long and not short
        U*x >= 0;
        %y >= 0;
        %minimize h
        minimize y
    cvx_end
    
end