interval = 0.8;
lambda = 1;
% 需要调的参数


if ~exist('X')
    preprocess;
end
fprintf('Loading data... \n');
load('X.mat');
load('y.mat');
load('Xtest.mat');
load('ytest.mat');

% 开始梯度下降法训练
fprintf('Traning... \n');
m = size(X, 1);
X = [ones(m, 1) X];
initial_theta = zeros(size(X, 2), 1);


options = optimset('GradObj', 'on', 'MaxIter', 600);
[theta, J] = ...
	fminunc(@(t)(costFunction(t, X, y, lambda)), initial_theta, options);
% 梯度下降法训练结束

% 开始评估算法
Xtest = [ones(size(Xtest, 1), 1) Xtest];
error = abs(Xtest * theta - ytest);
mae = sum(error) / length(error);
costtest = computeCost(Xtest, ytest, theta);
file = fopen('result.txt', 'a');
fprintf('Mae: %f, cost: %f, lambda: %f, interval: %f\n', mae, costtest, lambda, interval);
fprintf(file, 'Mae: %f, cost: %f, lambda: %f, interval: %f\n', mae, costtest, lambda, interval);
fclose(file);