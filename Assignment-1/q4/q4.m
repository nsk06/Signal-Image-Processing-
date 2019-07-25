set(gcf, 'Position', get(0, 'Screensize'));
F1 = imread('testim.jpeg');
 x = RESIZE_NN(F1,5);
 imshow(x);
 figure;
 title('Nearest Neighbour');
 F2 = imread('testim.jpeg');
 x = RESIZE_bilinear(F2,5);
 imshow(x);
function res_nn= RESIZE_NN(Img, X)
 
[height,width,cdata] = size(Img);
widepix = width*X;   %fixing the new width of matrix
heightpix = height*X;   %fixing the new height of im matrix
res_nn= uint8(zeros(heightpix, widepix));
 
for i= 0:heightpix-1
  for j= 0:widepix-1
    x = floor(j/X);        %applying nn
    y = floor(i/X);
    for k= 1:cdata
      res_nn(i+1, j+1, k) = Img(y+1, x+1, k);
    end
  end
end
end

function res_bi = RESIZE_bilinear(Img, X)
 
[height, width, cdata] = size(Img);
heightpix = X*(height-1)+1; widepix = X*(width-1)+1; %New sizes
res_bi = zeros(heightpix+1, widepix+1, cdata);
 
% Extending new image matrix from original with 0 padding
for i= 1:height
   for j= 1:width
      res_bi(X*(i-1)+1, X*(j-1)+1, : ) = Img(i, j, : );
   end
end
 
% Interpolation
for k= 1:cdata
for i= 0:X:heightpix-X
for j= 0:X:widepix-X
A = res_bi(i+1, j+1, k);
B = res_bi(i+1, j+X+1, k);      
C = res_bi(i+X+1, j+1, k);
D = res_bi(i+X+1, j+X+1, k);
         x1 = A;
         x2 = double((B-A)/X);
         x3 = double((C-A)/X);
         x4 = double((D-C-B+A)/(X*X));
         for l= 0:X
            for m= 0:X
               res_bi(i+l+1, j+m+1, k) = x1 + x2*m + x3*l + x4*m*l;  %applying the algorithm
            end
         end
      end
   end
end
res_bi = uint8(res_bi);
end