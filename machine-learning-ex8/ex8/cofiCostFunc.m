function [J, grad] = cofiCostFunc(params, Y, R, num_users, num_movies, ...
                                  num_features, lambda)
%COFICOSTFUNC Collaborative filtering cost function
%   [J, grad] = COFICOSTFUNC(params, Y, R, num_users, num_movies, ...
%   num_features, lambda) returns the cost and gradient for the
%   collaborative filtering problem.
%

% Unfold the U and W matrices from params
X = reshape(params(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(params(num_movies*num_features+1:end), ...
                num_users, num_features);

X_grad = zeros(size(X));
Theta_grad = zeros(size(Theta));

%
% Notes: X - num_movies  x num_features matrix of movie features
%        Theta - num_users  x num_features matrix of user features
%        Y - num_movies x num_users matrix of user ratings of movies
%        R - num_movies x num_users matrix, where R(i, j) = 1 if the
%            i-th movie was rated by the j-th user
%
% You should set the following variables correctly:
%
%        X_grad - num_movies x num_features matrix, containing the
%                 partial derivatives w.r.t. to each element of X
%        Theta_grad - num_users x num_features matrix, containing the
%                     partial derivatives w.r.t. to each element of Theta
%

err = (X * Theta' - Y).*R;
sqErr = err.^2;
X_reg = sum(sum(X.^2));
Theta_reg = sum(sum(Theta.^2));
J = 1/2 * sum(sum(sqErr.*R)) + lambda/2 * (X_reg + Theta_reg);

X_grad = err * Theta + lambda * X;
Theta_grad = err' * X + lambda * Theta;

grad = [X_grad(:); Theta_grad(:)];

end