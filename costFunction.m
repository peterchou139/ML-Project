function [J, grad] = costFunction(theta, X, y, lambda)
m = size(y, 1);
J = 0;
grad = zeros(size(theta));
J = sum((X * theta - y) .^ 2) + sum(theta(2:end) .^ 2) * lambda + J;
J = J / (2 * m);
grad = (X.' * (X * theta - y) + [0; theta(2:end)] * lambda) / m + grad;
end
