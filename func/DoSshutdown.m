function [G1] = DoSshutdown(G,enablenode)
% 直接关掉一些节点
% 
n = size(G);

G1 = G;

G1(enablenode,:) = 0;
G1(:,enablenode) = 0;
end

