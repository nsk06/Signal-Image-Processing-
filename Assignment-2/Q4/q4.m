[y,fs] = audioread('signal_3.wav');
inp = audioplayer(y,fs);
test1 = smoothdata(y,'gaussian');
test2 = smoothdata(y,'sgolay');
test3 = smoothdata(y,'includenan');
test4 = smoothdata(y,'loess');
test5 = smoothdata(y,'lowess');
test6 = smoothdata(y,'movmean');
test7 = smoothdata(y,'movmedian');
test8 = smoothdata(y,'rloess');
test9 = smoothdata(y,'rlowess');
%{
subplot(1,2,1);
plot(y);
title('original');
%playblocking(inp);
%try1
my = (fft(y));
my(abs(my) < 3*mean(abs(my))) = 0;
%stem(abs(my));
z  = my.*2;
out = audioplayer(ifft(z),fs);
yo = abs(ifft(my));
subplot(1,2,2);
plot(yo);
title('filtered');
figure;
%}
%playblocking(out);
%try2 
 wp = 990/(fs/2);
 ws = 1005/(fs/2);                                           
 rp =  1;                                               
 rs = 90;                                               
 [n,ws] = cheb2ord(wp,ws,rp,rs);                         
 [a,b,c] = cheby2(n,rs,ws,'low');                       
 [sos,g] = zp2sos(a,b,c);                            
 filtered = filtfilt(sos, g, y);
 freqz(sos, 2.^10, fs)
 figure;
 subplot(1,2,1);
 plot(y);
 title('original');
 subplot(1,2,2);
 plot(filtered);
 title('filtered');
 out = filtered.*3;
% sound(out, fs);
playblocking(audioplayer(filtered,fs));
%try3
[c,d] = butter(6,800/(fs/2),'low');
sig = filter(c,d,y);
plot(sig);
title('butter');
sound(sig,fs);
