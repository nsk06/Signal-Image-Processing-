[aud1,fs1] = audioread('1.wav');
[aud2,fs2] = audioread('2.wav');
[aud3,fs3] = audioread('3.wav');
[aud4,fs4] = audioread('4.wav');
[aud5,fs5] = audioread('5.wav');
subplot(2,3,1);
stem(abs(fft(aud1)));
title('audio 1');
orig1 = audioplayer(aud1,fs1);
%playblocking(orig1,fs1);
subplot(2,3,2);
stem(abs(fft(aud2)));
title('audio 2');
orig2 = audioplayer(aud2,fs2);
%playblocking(orig2,fs2);
subplot(2,3,3);
stem(abs(fft(aud3)));
title('audio 3');
orig3 = audioplayer(aud3,fs3);
%playblocking(orig3,fs3);
subplot(2,3,4);
stem(abs(fft(aud4)));
title('audio 4');
orig4 = audioplayer(aud4,fs4);
%playblocking(orig4,fs4);
subplot(2,3,5);
stem(abs(fft(aud5)));
title('audio 5');
orig5 = audioplayer(aud5,fs5);
%playblocking(orig5,fs5);
fs = fs1;
val = fs*5;
array = [aud1(:);aud2(:);aud3(:);aud4(:);aud5(:)];
start = [aud1(1:val);aud2(1:val);aud3(1:val);aud4(1:val);aud5(1:val)];
last = [aud1(size(aud1,1)-val+1:size(aud1,1));aud2(size(aud2,1)-val+1:size(aud2,1));
        aud3(size(aud3,1)-val+1:size(aud3,1));aud4(size(aud4,1)-val+1:size(aud4,1));aud5(size(aud5,1)-val+1:size(aud5,1))];
st = [];
ls = [];
st_val = [];
ls_val = [];
for i=1:5
    temp = start(i,:);
    temp2 = last(i,:);
    cmp= -100000;
    p = 0;
    for j = 1:5
        res = max(xcorr(temp,last(j,:)));
        if(res > cmp)
            cmp = res;
            p = j;
        end
    end
    st = [st,p];
    st_val = [st_val,cmp];
    cmp2 = -100000;
    for j = 1:5
        res = max(xcorr(temp2,start(j,:)));
        if(res > cmp2)
            cmp2 = res;
            p2 = j;
        end
    end
    ls = [ls,p2];
    ls_val = [ls_val,cmp2];
end
st
st_val
ls
ls_val
[minval,wav_start] = min(st_val(:));
order = -5:-1;
order(1)=wav_start;
z = wav_start;
for i=2:5
    order(i) = ls(z);
    z = ls(z);
end
order
final_audio = [];
for j=1:5
    final_audio = [final_audio;eval(strcat("aud",num2str(order(j))))];
end
size(final_audio);
%sound(final_audio,fs);
%denoising
test3 = medfilt1(final_audio);
test1 = smoothdata(test3,'gaussian');
test2 = smoothdata(test1,'sgolay');
out1 = audioplayer(test3,fs);
sound(test3,fs);