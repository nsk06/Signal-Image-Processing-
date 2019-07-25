res = create_mat_dct();
testim = imread('cameraman.tif');
testim2 = imread('rice.png');
testim = imresize(testim,[8 8]);
Dct2im = myDCT(im2double(testim),res);
figure;
IDCT2im = myIDCT(im2double(testim),res);
Quant_Mat=[16 11 10 16 24 40 51 61       % Quantisation matrix matrix (8 X 8) used to Normalize the DCT Matrix.
          12 12 14 19 26 58 60 55
          14 13 16 24 40 57 69 56
          14 17 22 29 51 87 80 62
          18 22 37 56 68 109 103 77
          24 35 55 64 81 104 113 92
          49 64 78 87 103 121 120 101
          72 92 95 98 112 100 103 99];
global quantim;
quantim = myDCT_quantization(Dct2im,Quant_Mat,1);
unquantim = myDCT_dequantization(quantim,Quant_Mat,1);
error = RMSE(testim,testim2)
entropy = My_entropy(testim);
function mt = create_mat_dct()
N = 8;
A = zeros(N,N);
v = 0:N-1;
u = 0:N-1;
A = sqrt(2/N).*cos((pi.*(2*u+1).*v')./(2*N));
A(1,:) = sqrt(1/N);
mt = A;
end
function app = myDCT(im,F)
app = F*im*F';
%imshow(app);
end
function iapp = myIDCT(im,F)
iapp = F'*im*F;
%imshow(iapp);
end
function qapp = myDCT_quantization(imDCT, qm, c)
qapp = round(imDCT./(c.*qm));
end
function iqapp = myDCT_dequantization(imqDCT, qm, c)
global quantim;
iqapp = round(c.*qm.*quantim);
end
function errorcal = RMSE(im1, im2)
s1 = size(im1);
s2 = size(im2);
if length(im1)>length(s2)
    im2 = imresize(im2,s1);
else
    im1 = imresize(im1,s1);
end
errorcal = sqrt(mean((im1(:)-im2(:)).^2));
end
function ent = My_entropy(im)
[m,n] = size(im);
[counts,bl] = imhist(im);
counts = counts/(m*n);
counts(counts == 0) = [];
ent = -sum(counts.*log2(counts));
end