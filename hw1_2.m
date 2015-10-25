clear all;close all;clc
w = zeros(size([10 1]));
for M = 0:9
    load('x2.mat');
    load('t2.mat');
    u = x2(1:80);
    v = t2(1:80);
    m = length(v); % # of training examples

    % Plot the training data
    figure;
    plot(u, v, 'o', 'MarkerFacecolor', 'g', 'MarkerSize', 7);

    % All powers of x from 0 to M
    x = zeros([m M+1]);
    x(:,1) = ones(m,1);
    for i=1:M
        x(:,i+1) = u.^i;
    end
    
    % Regularization parameter
    lambda = 0.001;

    % Normal equations
    L = lambda.*eye(M+1);
    L(1,1) = 0;
    w(1:M+1,M+1) = (x' * x + L)\x' * v;
    norm_w = norm(w);

    % Plot the linear fit
    hold on;
    x_vals = (0:0.05:2)';
    features(:,1) = ones(length(x_vals),1);
    for i = 1:M
        features(:,i+1) = x_vals.^i;
    end
    plot(x_vals, features*w(1:M+1,M+1), '--','color', 'black', 'LineWidth', 2)
    legend('Training data', 'Regression')
    hold off
end

