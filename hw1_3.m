clear all;close all;clc

load('x3.mat');
load('t3.mat');

train1 = [1 40];
train2 = [51 90];
train3 = [101 140];

u1 = X(1:40);
u2 = X(51:90);
u3 = X(101:140);
v1 = T(1:40);
v2 = T(51:90);
v3 = T(101:140);

train_in = cat( 1,X(1:40,:),X(51:90,:),X(101:140,:) );
train_target = cat( 1,T(1:40),T(51:90),T(101:140));

N = length(train_target); % number of training examples

x = zeros([N 85]);
x(:,1) = ones(N,1);

for i=1:4
    x(:,i+1) = train_in(:,i);
end

for i=1:4
    for j=1:4
        num = 5+(i-1)*4+j;
        x(:,num) = train_in(:,i) .* train_in(:,j);
    end    
end

for i=1:4
    for j=1:4
        for k=1:4
            num = 21+(i-1)*4*4+(j-1)*4+k;
            x(:,num) = train_in(:,i) .* train_in(:,j) .*train_in(:,k);
        end
    end    
end

w = pinv(x' * x) * x' * train_target;