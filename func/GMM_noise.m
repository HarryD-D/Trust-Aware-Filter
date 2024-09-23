% 
function [R_0,R,vk] =GMM_noise(dim,len,sigma1,sigma2,p,snr)

vk1 = randn(dim,len)*sigma1^2;
vk2 = randn(dim,len)*sigma2^2;
vk = zeros(dim,len);
for ii = 1:len
    if rand >= p 
        vk(:,ii) = vk1(:,ii);
    else
        vk(:,ii) = vk2(:,ii);
    end
end
R_0 = vk1*vk1'/len;
R = vk*vk'/len;



end