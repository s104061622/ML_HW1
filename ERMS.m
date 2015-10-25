erms = zeros([1 M]);
for M = 0:9
    load('x2.mat');
    load('t2.mat');
    u = x2(1:80);
    v = t2(1:80);

    N = size(u,1);

    temp = zeros([N M+1]);
    for i = 1:M+1
        temp(:,i) = w(i,M+1)*(u(:).^(i-1))';
    end

    y = sum(temp,2);
    temp2 = (y - v).^2;
    erfc = 0.5*(sum(temp2)) + 0.5*lambda*sum(w(:,M+1).^2);
    erms(M+1) = sqrt(2*erfc/N);

end