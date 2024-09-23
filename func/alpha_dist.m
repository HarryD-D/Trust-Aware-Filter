function [outputArray] = alpha_dist(inputArray,alpha,beta,gamma,a,msnr)
%%SaS条件下，beta为0，a为0，gamma为1，alpha为[1,2]，在浅海条件下
%%alpha:0<alpha<=2,特征参数，另一文中同
%%beta:-1<=beta<=1,对称参数，另一文中同
%%gamma:gamma>0,比例参数，另一文中为sigma
%%a:位置参数，另一文中为miu0
if sum(imag(inputArray)) == 0
    comp_flag = 1;%%实数
else
    comp_flag = 2;%%复数
end
arrayLen = length(inputArray);
k_alpha = alpha-1+sign(1-alpha);
if alpha ~= 1
    beta2 = 2*atan(beta*tan(pi*alpha/2))/(pi*k_alpha);
    gamma2 = gamma*(1+beta^2*(tan(pi*alpha/2)^2))^(1/(2*alpha));
else
    beta2 = beta;
    gamma2 = 2*gamma/pi;
end
w = exprnd(1,arrayLen,1)';
gamma0 = -pi/2*beta2*k_alpha/alpha;
gamma1 = -pi/2*ones(1,arrayLen)+pi*rand(comp_flag,arrayLen);
x = zeros(comp_flag,arrayLen);
if alpha ~= 1
    for ik = 1:arrayLen
        for jk = 1:comp_flag
            x(jk,ik) = sin(alpha*(gamma1(jk,ik)-gamma0))/(cos(gamma1(jk,ik))^(1/alpha))*(cos(gamma1(jk,ik)-alpha*(gamma1(jk,ik)-gamma0))/w(ik))^((1-alpha)/alpha);
        end
    end
else
    for ik = 1:arrayLen
        for jk = 1:comp_flag
            x(jk,ik) = (pi/2+beta2*gamma1(jk,ik))*tan(gamma1(jk,ik))-beta2*log10(w(ik)*cos(gamma1(jk,ik))/(pi/2+beta*gamma1(jk,ik)));
        end
    end
end
y = gamma2*x;
if alpha ~= 1
    u = y+a*ones(1,arrayLen);
else
    u = y+a+2/pi*gamma*beta*log(2*gamma/pi)*ones(1,arrayLen);
end
amp_lvl = sqrt(10^(msnr/10)*gamma);
if comp_flag == 1
    outputArray = inputArray+u/amp_lvl;
else
    outputArray = real(inputArray)+u(1,:)/amp_lvl+1i*(imag(inputArray)+u(2,:));
end
end