% 开始数据预处理
fprintf('Preprocessing data... \n');
load('distance.txt');
load('distance_test.txt');
load('rssi.txt');
load('rssi_test.txt');

tmp_y = distance(distance(:, 2) <= 5000, :);
m = size(tmp_y, 1);
X = [];
y = [];
Xval = [];
yval = [];
count = 0;
for i = 1:m
    flag = true;
    tmp_yi = tmp_y(i, :);
    timestamp = tmp_yi(1, 1);
    yi = tmp_yi(1, 2);
    % 注意这里可以对 interval 内 rssi 样本数少于一定个数的 distance 样本做剔除处理
    x = zeros(2, 1);
    for j = 5:5
        tmp_rssi = rssi(rssi(:, 1) <= timestamp & rssi(:, 1) >= (timestamp - interval) & rssi(:, 2) == j, 3);
        if ~isempty(tmp_rssi)
            x(1) = mean(tmp_rssi);
        else
            flag = false;
            break;
        end
    end
    x(2) = x(1) ^ 2;
    if flag
        count = 1 + count;
        if mod(count, 4) == 0
            Xval = [Xval; x.'];
            yval = [yval; yi];
        else
            X = [X; x.'];
            y = [y; yi];
        end
    end
end
% [X_norm, mu, sigma] = featureNormalize(X);
% X = X_norm;
% Xval = bsxfun(@minus, Xval, mu);
% Xval = bsxfun(@rdivide, Xval, sigma);
save('X.mat', 'X');
save('y.mat', 'y');

tmp_ytest = distance_test(distance_test(:, 2) <= 5000, :);
m_test = size(tmp_ytest, 1);
Xtest = [];
ytest = [];
for i = 1:m_test
    flag = true;
    tmp_yi = tmp_ytest(i, :);
    timestamp = tmp_yi(1, 1);
    yi = tmp_yi(1, 2);
    x = zeros(2, 1);
    for j = 5:5
        tmp_rssi = rssi_test(rssi_test(:, 1) <= timestamp & rssi_test(:, 1) >= (timestamp - interval) & rssi_test(:, 2) == j, 3);
        if ~isempty(tmp_rssi)
            x(1) = mean(tmp_rssi);
        else
            flag = false;
            break;
        end
    end
    x(2) = x(1) ^ 2;
    if flag
        Xtest = [Xtest; x.'];
        ytest = [ytest; yi];
    end
end
% Xtest = bsxfun(@minus, Xtest, mu);
% Xtest = bsxfun(@rdivide, Xtest, sigma);
save('Xtest.mat', 'Xtest');
save('ytest.mat', 'ytest');
% 数据预处理结束