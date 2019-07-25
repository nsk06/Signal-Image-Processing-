[y,fs] = audioread('message.wav');
%[y,fs] = audioread('message.wav');
plot(abs(fft(y)));
title('original signal');
figure;
A = myspect(y,700,350);
B = spectrogram(y,700,350,'centered');
imagesc(abs(B));
title('Inbuilt Spectrogram');
function Spect = myspect(x, w, s)
% array containing the start points of each step
array = 1 : abs(w-s) : size(x,1)-w+1;
Spect = zeros (size(array,1),w);
% Calculating the STFT for each small step
for i=1:length(array)
    Spect(i,1:w) = abs(fftshift(fft(x(array(i):array(i)+w-1))));
end
imagesc(log(Spect(:,1:w)).');
title('My Spectrogram');
figure;
end