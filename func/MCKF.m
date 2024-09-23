function [P_k,X_k] = MCKF(A,P_k_1,H,R,Q,X_k_1,Y,sigma,kesai)
    Xk_k_1 = A * X_k_1;
    Pk_k_1 = A * P_k_1* A' + Q;
    
    dim = size(X_k_1,1);
    dim_y = size(Y,1);
    
    Rk1 = R;
%     Rk1 = 0.1;
    I = eye(dim);
    
    Bpk = chol(Pk_k_1)';
    Brk = chol(Rk1)';
    
    dk = [inv(Bpk) * Xk_k_1;
          inv(Brk) * Y];
    Wk = [inv(Bpk);
          inv(Brk) * H];
    
    xke_mckf_t = A * X_k_1;
    for ii = 1 : 20
        ek = dk - Wk*xke_mckf_t;
        Cxk_temp = [];
        Cyk_temp = [];
        for i = 1:dim
            Cxk_temp = [Cxk_temp G(ek(i,:), sigma)];
        end
        for i = dim+1:dim+dim_y
            Cyk_temp = [Cyk_temp G(ek(i,:), sigma)];
        end
        Cxk = diag(Cxk_temp);
        Cyk = diag(Cyk_temp);
        
%         Pk_mid_mckf = Bpk * inv(Cxk) * Bpk';
%         Rk_mid_mckf = Brk * inv(Cyk) * Brk';
%         Kk_mckf = Pk_mid_mckf * H' * inv(Rk_mid_mckf + H * Pk_mid_mckf * H');
        
        Pk_mid_mckf_inv = inv(Bpk') * Cxk * inv(Bpk);
        Rk_mid_mckf_inv = inv(Brk') * Cyk * inv(Brk);
        Kk_mckf = inv(Pk_mid_mckf_inv + H' * Rk_mid_mckf_inv * H) * H'* Rk_mid_mckf_inv;
        
        X_k = Xk_k_1 + Kk_mckf * (Y - H * Xk_k_1);
        if ( (norm(X_k - xke_mckf_t) / norm(xke_mckf_t)) < kesai)
            break;
        end
        xke_mckf_t = X_k;
    end
    P_k = (I - Kk_mckf * H) * Pk_k_1 * (I - Kk_mckf * H)' + Kk_mckf * Rk1 * Kk_mckf';
end

