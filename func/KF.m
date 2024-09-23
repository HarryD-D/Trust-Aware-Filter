% 单步KF算法
function [P_k,X_k,K_k] = KF(A,P,H,R,Q,X,Y)
% A:状态转移
% P:协方差 p(k-1)+
% H:观测
% R:观测噪声
% Q:预测噪声
% X:x(k-1)+
% Y:y(k)观测
% K:

X_k_ = A * X;
P_k_ = A*P*A' + Q;

K_k = P_k_*H' * inv(H*P_k_*H'+R);

X_k = X_k_ + K_k*(Y-H*X_k_);
P_k = P_k_- K_k*H*P_k_;

end