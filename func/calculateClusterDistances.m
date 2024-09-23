function norm_distances = calculateClusterDistances(data, eps, minPts)
    % 使用MATLAB自带的DBSCAN函数计算idx
    idx = dbscan(data, eps, minPts);

    % 获取聚类中心
    uniqueClusters = unique(idx);
    clusterCenters = zeros(length(uniqueClusters), size(data, 2));
    for i = 1:length(uniqueClusters)
        clusterPoints = data(idx == uniqueClusters(i), :);
        clusterCenters(i, :) = mean(clusterPoints, 1);
    end

    % 计算每个数据点到其所属聚类中心的距离
    distances = zeros(size(data, 1), 1);
    for i = 1:size(data, 1)
        point = data(i, :);
        clusterIndex = idx(i);
        center = clusterCenters(uniqueClusters == clusterIndex, :);
        distances(i) = norm(point - center);
        norm_distances = abs(normalize(distances));
    end
end
