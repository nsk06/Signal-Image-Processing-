testim = imread('cameraman.tif');
my = fft2(fft2(testim));
%showing the image
subplot(1,2,1);
imshow(mat2gray(log(abs(my)+1)));
title('result')
rev = fft2(flip(flip(fft2(testim),1),2)+100);
subplot(1,2,2);
imshow(mat2gray(log(abs(rev)+1)));
title('reversing');