%reading a sound file in matlab
read = audioread('sa_re_ga_ma.wav');
sound(read);
%part 1/2 recording the voice
myrecording = audiorecorder(44100,24,1);
disp('Start Speaking');
recordblocking(myrecording,5);
disp('End Recording');
play(myrecording);
filename ="sample.wav"
record = getaudiodata(myrecording);
audiowrite(filename,record,44100);
%Recording and writing finished
[y,fs] = audioread("sample.wav");
%subsampling the voices at different frequencies
p1 = audioplayer(y,fs);
x1 = audioplayer(y,24000);
x2 = audioplayer(y,16000);
x3 = audioplayer(y,8000);
x4 = audioplayer(y,4000);
disp('original');
playblocking(p1);
disp('24khz');
playblocking(x1);
disp('16khz');
playblocking(x2);
disp('8khz');
playblocking(x3);
disp('4khz');
playblocking(x4);

y = y(:,1); %convert to vector
[bh,t1] = audioread('BIG HALL E001 M2S.wav');
bh = bh(:,1);
out1 = conv(y,bh); %convolution
[hc,t2] = audioread('HOTHALL COMP-1.wav');
hc = hc(:,1);
out2 = conv(y,hc);
[sc,t3] = audioread('SMALL CHURCH E001 M2S.wav');
sc = sc(:,1);
out3 = conv(y,sc);
%playing different audios
res1 = audioplayer(out1,fs);
disp('Big Hall');
playblocking(res1);
res2 = audioplayer(out2,fs);
disp('Hot Hall');
playblocking(res2);
res3 = audioplayer(out3,fs);
disp('Small Church');
playblocking(res3);
