function [ l, u ] = groupBy(data, predicateData, predicate)
%GROUPBY Summary of this function goes here
%   Detailed explanation goes here
    p = predicate(predicateData);
    u = unique(p);
    g = findgroups(p);
    
    l = cell(1, length(u));
    l{1, length(u)} = [];
    for k = 1:length(predicateData)
        l{g(k)} = [l{g(k)}; data(:, k)];
    end
end

