%3 M=3
close all;
    
train1 = [1 40];
train2 = [51 90];
train3 = [101 140];

x = load('x3.mat');
t = load('t3.mat');

train_i = cat( 1,x.X(train1(1):train1(2),:), x.X(train2(1):train2(2),:), x.X(train3(1):train3(2),:));
train_t = cat( 1, t.T(train1(1):train1(2)),t.T(train2(1):train2(2)),t.T(train3(1):train3(2)));

N = length(train_t); % number of training examples

x = zeros([N 85]);
x(:,1) = ones(N,1);

for i=1:4
    x(:,i+1) = train_i(:,i);
end

for i=1:4
    for j=1:4
        num = 5+(i-1)*4+j;
        x(:,num) = train_i(:,i) .* train_i(:,j);
    end    
end

for i=1:4
    for j=1:4
        for k=1:4
            num = 21+(i-1)*4*4+(j-1)*4+k;
            x(:,num) = train_i(:,i) .* train_i(:,j) .*train_i(:,k);
        end
    end    
end

w = pinv(x' * x) * x' * train_t;