%build ground distance
function ground_dist = ground_dist(K,s,Q,p,n_norm)
n = K * s * Q ;
ground_dist = zeros(n,n);
x = zeros(1,n);
y = x;
for i = 1:n
    x(i) = floor((i - 1)/(s*Q)) + 1;
    y(i) = mod(i - 1,s*Q);
end
for i = 1:(n-1)
    for j = (i+1):n       
        ground_dist(i,j) = (abs(x(i) - x(j))^n_norm + abs(y(i) - y(j))^n_norm)^(p/n_norm);
        ground_dist(j,i) = ground_dist(i,j);
    end
end
%{
for i = 1:(n-1)
    for j = (i+1):n       
        ground_dist(i,j) = (abs(x(i) - x(j))^n_norm + abs(y(i) - y(j))^n_norm)^(p/n_norm);
        ground_dist(j,i) = ground_dist(i,j);
    end
end
%}

