clear all;close all;clc

load('x3.mat');
load('t3.mat');

train_i = cat( 1,X(1:40,:),X(51:90,:),X(101:140,:) );
train_t = cat( 1,T(1:40),T(51:90),T(101:140));

M = length(train_t); % # of training examples

test_i = cat( 1,X(41:50,:),X(91:100,:),X(141:150,:) );
test_t = cat( 1,T(41:50),T(91:100),T(141:150) );

N = length(test_t); % # of testing examples

x = zeros([M 85]); % 1 + 4 + 4*4 + 4*4*4 = 85
x(:,1) = ones(M,1);

y = zeros([N 85]); % 1 + 4 + 4*4 + 4*4*4 = 85
y(:,1) = ones(N,1);

for i = 1:4
    x(:,i+1) = train_i(:,i);
    y(:,i+1) = test_i(:,i);
end

for i = 1:4
    for j = 1:4
        idx = 5 + (i-1)*4 + j;
        x(:,idx) = train_i(:,i) .* train_i(:,j);
        y(:,idx) = test_i(:,i) .* test_i(:,j);
    end    
end

for i = 1:4
    for j = 1:4
        for k = 1:4
            idx = 21 + (i-1)*4*4 + (j-1)*4 + k;
            x(:,idx) = train_i(:,i) .* train_i(:,j) .* train_i(:,k);
            y(:,idx) = test_i(:,i) .* test_i(:,j) .* test_i(:,k);
        end
    end    
end

w = pinv(x' * x) * x' * train_t;
erf1 = sum((x*w - train_t).^2) / 2;
erf2 = sum((y*w - test_t).^2) / 2;
erms1 = sqrt((2*erf1) / size(train_t,1));
erms2 = sqrt((2*erf2) / size(test_t,1));

