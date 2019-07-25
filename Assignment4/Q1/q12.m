testim = imread('LAKE.TIF');
test1 = testim(420:427,45:52);
test2 = testim(427:434,298:305);
test3 = testim(30:37,230:237);
subplot(4,3,1);
imshow(test1);
title('orignal (420,45)');
subplot(4,3,2);
imshow(test2);
title('orignal (427,298)');
subplot(4,3,3);
imshow(test3);
title('orignal (30,230)');
test1  = double(test1)-128*ones(8,8);
test2  = double(test2)-128*ones(8,8);
test3  = double(test3)-128*ones(8,8);
c = 2;
Quant_Mat=[16 11 10 16 24 40 51 61       % Quantisation matrix matrix (8 X 8) used to Normalize the DCT Matrix.
          12 12 14 19 26 58 60 55
          14 13 16 24 40 57 69 56
          14 17 22 29 51 87 80 62
          18 22 37 56 68 109 103 77
          24 35 55 64 81 104 113 92
          49 64 78 87 103 121 120 101
          72 92 95 98 112 100 103 99];
 temp = create_mat_dct();
 dcttest1 = temp*test1*temp';
 dcttest2 = temp*test2*temp';
 dcttest3 = temp*test3*temp';
  subplot(4,3,4);
 imshow(double(dcttest1));
 title('DCT (420,45)');
  subplot(4,3,5);
 imshow(double(dcttest2));
 title('DCT (427,298)');
  subplot(4,3,6);
 imshow(double(dcttest3));
 title('DCT (30,230)');
 quantest1 = round(dcttest1./(c.*Quant_Mat));
 quantest2 = round(dcttest2./(c.*Quant_Mat));
 quantest3 = round(dcttest3./(c.*Quant_Mat));
  subplot(4,3,7);
 imshow(double(quantest1));
 title('quantised (420,45)');
  subplot(4,3,8);
 imshow(double(quantest2));
 title('quantised (427,298)');
  subplot(4,3,9);
 imshow(double(quantest3));
 title('quantised (30,230)');
 retest1 = round(quantest1.*(c.*Quant_Mat));
 retest1 = temp'*retest1*temp+128*ones(8,8);
 retest2 = round(quantest2.*(c.*Quant_Mat));
 retest2 = temp'*retest2*temp+128*ones(8,8);
 retest3 = round(quantest3.*(c.*Quant_Mat));
 retest3 = temp'*retest3*temp+128*ones(8,8);
 subplot(4,3,10);
 imshow(uint8(retest1));
 title('Regenerated (420,45)');
  subplot(4,3,11);
 imshow(uint8(retest2));
 title('Regenerated (427,298)');
  subplot(4,3,12);
 imshow(uint8(retest3));
 title('Regenerated (30,230)');
 function mt = create_mat_dct()
N = 8;
A = zeros(N,N);
v = 0:N-1;
u = 0:N-1;
A = sqrt(2/N).*cos((pi.*(2*u+1).*v')./(2*N));
A(1,:) = sqrt(1/N);
mt = A;
end