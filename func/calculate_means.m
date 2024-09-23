%% 计算不同标签对应数据的均值
function [means,unique_labels] = calculate_means(data, labels)
    siz = size(data);
    unique_labels = unique(labels);  % 获取唯一的标签值
    num_labels = length(unique_labels);  % 获取标签的数量

    means = zeros(siz(1), num_labels);  % 初始化均值向量

    for i = 1:num_labels
        label = unique_labels(i);  % 当前标签值
        idx = (labels == label);  % 获取与当前标签匹配的索引

        
        if siz(1) == 4
            
            means(:,i) = mean(data(:,idx),2); 
        else
            means(i) = mean(data(idx));  % 计算对应标签的数据均值
        end

    end
end