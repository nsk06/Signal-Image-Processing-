data = csvread('houses.csv',0,0,[0,0,41,2]);
test = csvread('houses.csv',42,0,[42,0,46,2]);
X = ones(42,3);
X(:,2) = data(:,1);
X(:,3) = data(:,2);
Y = data(:,3);
tran = X.';
b = inv(tran*X)*tran*Y;
disp(b);
t1 = [1,1400,4];
y1 = t1*b;
%part 1-b
disp(y1);
x_test = ones(5,3);
x_test(:,2) = test(:,1);
x_test(:,3) = test(:,2);
y_test = x_test*b;
y_test_orig = test(:,3);
val1 = norm(y_test_orig);
val2 = norm(y_test);
accur = norm(y_test_orig-y_test);
%plot
%normalizing part 2
temp_x = X;
test_normx = x_test;
temp_x(:,2) = (temp_x(:,2)-min(temp_x(:,2)))./range(temp_x(:,2));
temp_x(:,3) = (temp_x(:,3)-min(temp_x(:,3)))./range(temp_x(:,3));
%temp_x(:,2) = normalize(temp_x(:,2));
%temp_x(:,3) = normalize(temp_x(:,3));
test_normx(:,2) = (test_normx(:,2)-min(X(:,2)))./range(X(:,2));
test_normx(:,3) = (test_normx(:,3)-min(X(:,3)))./range(X(:,3));
%test_normx(:,2) = normalize(test_normx(:,2));
%test_normx(:,3) = normalize(test_normx(:,3));
%norm_y = (Y-mean(Y))./range(Y);
normalized_b = inv(temp_x.'*temp_x)*temp_x'*Y;
norm_ytest = test_normx*normalized_b;
%norm_ytest_orig = (y_test_orig-mean(y_test_orig))./range(y_test_orig);
norm_accur = norm(y_test_orig-norm_ytest);
%part 1-c
area_mean = mean(X(:,2));
room_mean = mean(X(:,3));
price_mean = mean(Y);
temp = [1 area_mean room_mean];
ans = temp*b;