myrecording = audiorecorder(44100,24,1);
%disp('Start Speaking');
%recordblocking(myrecording,5);
%disp('End Recording');
%play(myrecording);
%filename ="sample.wav"
%record = getaudiodata(myrecording);
%audiowrite(filename,record,44100);

[y,fs] = audioread("sample.wav");
record = audioplayer(y,fs);
x1 = downsample(y,2);
play1 = audioplayer(x1,fs);
x2 = resample(y,2,1);
play2 = audioplayer(x2,fs);
%plotting the original
subplot(3,1,1);
plot(y);
title('original');
%plotting the fast
subplot(3,1,2);
plot(x1)
title('fast');
%plotting the slow
subplot(3,1,3);
plot(x2);
title('slow');
disp('Original');
playblocking(record);
disp('fast');
playblocking(play1);
disp('slow');
playblocking(play2);