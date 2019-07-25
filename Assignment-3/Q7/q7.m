x_data = xlsread('Altitude.xlsx');
x_data_train = x_data(1:900,1:2);
x_data_test = x_data(901:length(x_data),1:2);
y_data_train = x_data(1:900,3);
y_data_test = x_data(901:length(x_data),3);
theta = batchgradiant(x_data_train,y_data_train,3,500,.02);
%theta = Stochasticdescent(x_data_train,y_data_train,3,500,.02);
x_data_test = [ones(length(x_data_test),1),x_data_test];
pred = norm(x_data_test*theta-y_data_test)
function res = batchgradiant(X,Y,b,num,alpha)
mn = mean(X);
st = std(X);
norm_X = (X-mn);
trf_X = [ones(size(X,1),1) ,norm_X];
histry = zeros(num,1);
theta = zeros(b,1);
for i=1:num
    temp = trf_X*theta-Y;
    derivative_func = temp'*trf_X/length(Y);
    theta = theta-alpha*derivative_func';
    msrt = trf_X*theta-Y;
    msrt = msrt.^2;
    histry(i) = mean(msrt)/2;
end
plot(histry);
res = theta;
end
function res = Stochasticdescent(X,Y,b,num,alpha)
mn = mean(X);
st = std(X);
norm_X = (X-mn);
trf_X = [ones(size(X,1),1) ,norm_X];
histry = zeros(num,1);
theta = zeros(b,1);
trf_X = trf_X(randperm(length(trf_X)),:);
Y = Y(randperm(length(Y)),:);
for i=1:num
    for j=1:length(trf_X)
        temp = trf_X(j,:)*theta-Y(j);
        derivative_func = temp'*trf_X(j,:)/length(Y);
         theta = theta-alpha*derivative_func';
         msrt = trf_X(j,:)*theta-Y(j);
    msrt = msrt.^2;
    histry(i) = msrt/2;
    end
end
plot(histry);
res = theta;
end