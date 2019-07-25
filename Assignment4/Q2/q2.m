folder = 'C:\Users\Nonidh\Documents\DSAA Spring 2019\Assignment4\dataset';
pattern = fullfile(folder,'*.jpg');
files = dir(pattern);
imarray = [];
im1 = imread('./dataset/000_000.jpg');
sz = size(im1);
for k=1:numel(files)
    namefile = files(k).name;
    namefile = fullfile(folder,namefile);
    temp = imread(namefile);
    temp = temp;
    imarray = [imarray double(temp(:))];
end
for n = 1:36
    subplot(3, ceil(36/3), n);
    evector = reshape(imarray(:,n), sz);
    imshow(uint8(evector));
end
figure;
meanimage = mean(imarray,2);
meansubarray = imarray - repmat(meanimage,[1 size(imarray,2)]);
L = meansubarray'*meansubarray;
[vecmat,valmat] = eig(L);
eigvals = diag(valmat);
eigvals = eigvals(end:-1:1);
vecmat = fliplr(vecmat);
tot = sum(eigvals);
errsum = 0;
itr = 0;
for i=1:length(eigvals)
    errsum = errsum+ eigvals(i);
    if errsum/tot > .9
        itr = i;
        break
    end
end 
princ = vecmat(:,1:itr);
eigfaces = meansubarray*princ;
for n = 1:36
    subplot(3, ceil(36/3), n);
    evector = reshape(eigfaces(:,n), sz);
    imshow(uint8(evector));
end
figure;
%reconstruct from 35
topeig = vecmat(:,1:35);
eigfaceconst = meansubarray*topeig;
reconstruct = eigfaceconst*topeig';
for n = 1:36
    subplot(3, ceil(36/3), n);
    evector = reshape((reconstruct(:,n)+meanimage), sz);
    imshow(uint8(evector));
end

%scatter plots
figure;
temp = meansubarray*vecmat(:,1:3)*vecmat(:,1:3)';
scatterplot(temp(:,1));
figure;
scatter(temp(:,1),temp(:,2));
figure;
scatter3(temp(:,1),temp(:,2),temp(:,3));

