testim = imread('inp2.png');
my = fftshift(fft2(testim));
[x,y] = size(testim);
rectfilt=[zeros(120,y);ones(55,y);zeros(143,y)];
filter = double(imgaussfilt(testim,20));
res = my.*rectfilt;
out = ifft2((res));
figure
subplot(2,2,1)
imagesc(log(abs((my))));
title('Fourier of image');
subplot(2,2,2)
imagesc(log(abs(res))); 
title('Fourier transform of image after applying filter(sigma = 20)');
subplot(2,2,3)
imshow(testim)
title('Original image');
subplot(2,2,4)
imshow(mat2gray(log(abs(out))));
title('filtered image');