testim = imread('cameraman.tif');
tes = fftshift(fft2(testim));
imshow(mat2gray(log(abs(tes)+1)));
title('inbuilt fft2');
array = 1:2^14;
tic
fft2(testim);
toc
tic
My_fft2(testim);
title('myfft');
toc
tic
My_dft2(testim);
toc
title('mydft');
function myfft1 = My_fft1(inp)
% Only works if len is some power of 2
inp = double(inp);
len = size(inp,2); 
even_half=inp(2:2:len);
odd_half=inp(1:2:len);

if len == 1
    myfft1 = inp;
else
    odd_fft = My_fft1(odd_half);
    even_fft = My_fft1(even_half);
    myfft1 = zeros(len,1);
    exp_vect = exp(-1i*2*pi*((0:len/2-1)')/len);
    temp = exp_vect.*even_fft;
    myfft1 = [(odd_fft + temp);(odd_fft -temp)];
end
end
function myfft2 = My_fft2(img)
fft2_row = zeros(size(img));
fft2_col = zeros(size(img));

%Perform fft on each row
for i=1:size(img,1)
    fft2_row(i,:) = My_fft1(img(i,:));
end

%Perform fft on each column
for i=1:size(img,2)
    fft2_col(:,i) = My_fft1(fft2_row(:,i).');
end
res = fftshift(fft2_col);
%plot(abs(res));
figure,imshow(mat2gray(log(abs(res)+1))),colormap gray;
%title('My fft2 function result');
end
function mydft1 = My_dft1(inp)
inp = double(inp);
N = length(inp);
k=0:N-1;
n=0:N-1;
z=exp(-1j*2*pi/N);
W = z.^(n'*k);
mydft1 = W*(inp');
end
function mydft2 = My_dft2(img)
dft2_row = zeros(size(img));
dft2_col = zeros(size(img));

%Perform dft on each row
for i=1:size(img,1)
    dft2_row(i,:) = My_dft1(img(i,:));
end

%Perform dft on each column
for i=1:size(img,2)
    dft2_col(:,i) = My_dft1(dft2_row(:,i).');
end
res = fftshift(dft2_col);
%plot(abs(res));
figure,imshow(mat2gray(log(abs(res)+1))),colormap gray;
%title('My dft2 function result');
end
