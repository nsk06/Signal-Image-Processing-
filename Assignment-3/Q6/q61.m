testim = imread('cameraman.tif');
subplot(1,2,1);
imshow(testim);
title('original');
test = imfilter(testim,Myaverage(9));
subplot(1,2,2)
imshow(test);
title('average-filter');
function avg = Myaverage(k)
avg = ones(k,k);
avg = avg./k.^2;
end
