testim = imread('LAKE.TIF');
testim = double(testim);
c = 1;
temp = create_mat_dct();
Quant_Mat=[16 11 10 16 24 40 51 61       % Quantisation matrix matrix (8 X 8) used to Normalize the DCT Matrix.
          12 12 14 19 26 58 60 55
          14 13 16 24 40 57 69 56
          14 17 22 29 51 87 80 62
          18 22 37 56 68 109 103 77
          24 35 55 64 81 104 113 92
          49 64 78 87 103 121 120 101
          72 92 95 98 112 100 103 99];
myfun = @(block_struct)round((temp*(block_struct.data-128) * temp')./(c.*Quant_Mat));
resim = blockproc(testim,[8 8],myfun);
imshow(resim);
title('Quantised Image');
%invfun = @(block_struct)((temp'*round(block_struct.data.*(c.*Quant_Mat))*temp)+128);
%rec_im = blockproc(resim,[8 8],invfun);
%imshow(uint8(rec_im));
 function mt = create_mat_dct()
N = 8;
A = zeros(N,N);
v = 0:N-1;
u = 0:N-1;
A = sqrt(2/N).*cos((pi.*(2*u+1).*v')./(2*N));
A(1,:) = sqrt(1/N);
mt = A;
end