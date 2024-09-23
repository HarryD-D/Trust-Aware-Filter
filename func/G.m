function num = G(e, sigma)
% e 误差 sigma 内核带宽
% 高斯核函数
    num = exp(-e^2/(2 * sigma^2));
end

