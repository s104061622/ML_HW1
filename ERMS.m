erms = zeros([1 M]);
for M = 0:9
   
input = [1 20];

x = load('x2.mat');
t = load('t2.mat');

train_i = x.x2(input(1):input(2));
train_t = t.t2(input(1):input(2));

N = size(train_i,1);

temp = zeros([N M+1]);
for i = 1:M+1
    temp(:,i) = w(i,M+1)*(train_i(:).^(i-1))';
end

y = sum(temp,2);
temp2 = (y - train_t).^2;
E = 0.5*(sum(temp2)) + 0.5*lambda*sum(w(:,M+1).^2);
erms(M+1) = sqrt(2*E/N);

end