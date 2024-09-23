% trust^-1
function [score] = cal_detect(y_k,H_k,Pk_k_1,R_k,xk_k)
    score =sqrt(trace((y_k-H_k*xk_k)*(y_k-H_k*xk_k)')/trace(H_k*Pk_k_1*H_k'+R_k));
end

