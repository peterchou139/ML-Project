lambda_vector = [0.01 0.03 0.1 0.3 1 3 10 30 100 300];
interval_vector = [1 2 3 4 5 6];
mae = realmax;
cost = realmax;
file = fopen('result.txt', 'a');
fprintf(file, '-----------------------------------------------------------\n');
for i = 1:length(interval_vector)
    for j = 1:length(lambda_vector)
        tmp_interval = interval_vector(i);
        tmp_lambda = lambda_vector(j);
        fprintf('Choose lambda: %f, interval: %f\n', tmp_lambda, tmp_interval);
        % 开始预处理数据
        [X, y, Xval, yval, Xtest, ytest] = preprocess(tmp_interval);
        
        % 开始梯度下降法训练
        fprintf('Traning... \n');
        m = size(X, 1);
        X = [ones(m, 1) X];
        initial_theta = zeros(size(X, 2), 1);
        options = optimset('GradObj', 'on', 'MaxIter', 600, 'TolFun', 1e-20, 'TolX', 1e-20);
        [tmp_theta, J] = ...
            fminunc(@(t)(costFunction(t, X, y, tmp_lambda)), initial_theta, options);

        % 开始交叉验证
        fprintf('Starting cross validation...\n');
        Xval = [ones(size(Xval, 1), 1) Xval];
        error = abs(10 .^ (Xval * tmp_theta) - 10 .^ yval);
        tmp_mae = sum(error) / length(error);
        tmp_cost = computeCost(Xval, yval, tmp_theta);
        fprintf('tmp result: mae: %f, cost: %.10e, lambda: %f, interval: %f\n', tmp_mae, tmp_cost, tmp_lambda, tmp_interval);
        fprintf(file, 'tmp result: mae: %f, cost: %.10e, lambda: %f, interval: %f\n', tmp_mae, tmp_cost, tmp_lambda, tmp_interval);
        if (tmp_mae < mae)
            cost = tmp_cost;
            mae = tmp_mae;
            theta = tmp_theta;
            interval = tmp_interval;
            lambda = tmp_lambda;
        end
    end
end

Xtest = [ones(size(Xtest, 1), 1) Xtest];
error = abs(10 .^ (Xtest * theta) - 10 .^ ytest);
mae = sum(error) / length(error);
costtest = computeCost(Xtest, ytest, theta);
fprintf('Mae: %f, cost: %.10e, lambda: %f, interval: %f\n', mae, costtest, lambda, interval);
fprintf(file, 'Mae: %f, cost: %.10e, lambda: %f, interval: %f\n', mae, costtest, lambda, interval);
fclose(file);