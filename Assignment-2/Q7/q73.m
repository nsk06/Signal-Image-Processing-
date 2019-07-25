dial_tone("20171203");
function res = dial_tone(numb)
rows = [697,770,852,841];
cols = [1209,1336,1477];
dig = str2double(regexp(num2str(numb),'\d','match'));
fs = 32768;
t = 0:1/fs:.5;
final = zeros(1);
for i = 1:length(dig)
    if(dig(i) == 0)
        r = 4;c = 2;
    else
        c = mod(dig(i)-1,3)+1;
        r = (dig(i)-c)/3+1;
    end
    y1 = sin(2*pi*rows(r)*t);
    y2 = sin(2*pi*cols(c)*t);
    y = y1+y2;
    final = horzcat(final,y);
    gap = sin(t);
    final = horzcat(final,gap);
end
sound(final,fs);
z = spectrogram(final,200);
imagesc(log(abs(z)));
title('Tone spectrogram');
end