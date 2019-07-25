testim = imread('cameraman.tif');
imshow(testim)
title('Original')
figure;
B=imfilter(testim,gauss_filter(100,5));
imshow(B);
title('my gauss filtered N = 100,var = 5');
%{
%subplot(2,2,1);
imshow(B);
%subplot(2,2,2);
%B=imfilter(testim,gauss_filter(65,.5));
%imshow(B);
%title('my gauss filtered N = 65,var = .5');
%subplot(2,2,3);
%B=imfilter(testim,gauss_filter(75,10));
imshow(B);
title('my gauss filtered N = 75,var = 10');
subplot(2,2,4);
B=imfilter(testim,gauss_filter(120,12));
imshow(B);
title('my gauss filtered N = 120,var = 12');
%}
figure;
infilt  = fspecial('gaussian',100,5);
C = imfilter(testim,infilt);
imshow(C);
title('fspecial-filter');
figure;
median filtering
my_med_filt = median_filter('cameraman.tif',4);
imshow(my_med_filt);
title('my median');
figure;
in_med = medfilt2(testim,[4 4]);
imshow(in_med);
title('inbuilt median')
function mygauss = gauss_filter(N,var)
[X,Y] = meshgrid(round(-N/2):round(N/2));
mygauss = exp(-(X.^2/(var.^2*2) + Y.^2/(var.^2*2)));
nor = sum(mygauss,'all');
mygauss = mygauss./nor;
end
function mymed = median_filter(I,N)
immat = imread(I);
padd = padarray(immat,[round(N/2) round(N/2)]);
coln_wise = im2col(padd,[N N],'sliding');
med = median(coln_wise);
mymed = col2im(med,[N N],size(padd),'sliding');
end