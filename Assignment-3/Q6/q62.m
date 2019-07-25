testim = imread('cameraman.tif');
testim2 = imresize(testim,2);
testim3 = imresize(testim,4);
subplot(2,2,1);
imshow(testim);
title('original');
subplot(2,2,2);
imagesc(Efficient_Dp(9,testim));colormap gray;
title('efficient average');
x = [];
y = [];
m = [];
n = [];
for j=3:6:50
    tic
    res = conv2(testim,Myaverageconv(j));
    x = [x;toc];
    tic
    res = Efficient_average(j,testim);
    y = [y;toc];
    tic
    res = Efficient_Dp(j,testim);
    n = [n;toc];
    tic
    res = Myaveragescratch(j,testim);
    m = [m;toc];
end
subplot(2,2,[3,4]);
plot(x);
hold on;
plot(y);
plot(n);
plot(m);
legend('avg matrix','avg row col','Dp efficient average','Scratch convolution avg');
function av = Efficient_average(k,testim)
colwise = ones(k,1);
rowwise = ones(1,k);
testfilter = conv2(testim,rowwise);
testfilter = imfilter(testfilter,colwise);
testfilter = testfilter/k.^2;
av = testfilter;
end
function av = Efficient_Dp(k,testim)
tempim = padarray(testim,[k-1,k-1],'pre');
strip_store = im2col(tempim,[1 k]);
temp = strip_store./(k^2);
temp = sum(temp,1);
n = size(testim,2);
var = 1:n-1;
av = zeros(length(testim),n);
av(1,var) = sum(temp((var-1)*(n+k-1)+1:(var-1)*(n+k-1)+k),2);
sz = length(testim);
for i=2:sz
        av(i,var) = av(i-1,var) - temp((var-1)*(sz+k-1)+i-1)+temp( (var-1)*(sz+k-1)+k-1+i );
end
end
function avg = Myaverageconv(k)
avg = ones(k,k);
avg = avg./k.^2;
end
function avg = Myaveragescratch(k,testim)
tempim = padarray(testim,[k-1 k-1],'pre');
kernel_store = im2col(tempim,[k k]);
kernel_store = kernel_store./(k.^2);
kernel_store = sum(kernel_store);
avg = col2im(kernel_store,[k k],size(tempim));
end
