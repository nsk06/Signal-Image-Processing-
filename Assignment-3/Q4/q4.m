load('Q4.mat');
stem(abs(fftshift(fft(X))));
figure;
my = fft(X);
orig = audioplayer(X,Fs);
%playblocking(orig);
my(abs(my)<2000) = 0;
stem(abs(fftshift(my)));
filtered = audioplayer(ifft(my),Fs);
%playblocking(filtered);
%alternatively
y = lowpass(X,1500,Fs);
%sound(y,Fs);