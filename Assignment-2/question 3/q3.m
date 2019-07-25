catchfugitive('Police.ogg');
function findnum = catchfugitive(rec_file)
file0 = audioread('q3/0.ogg');
file1 = audioread('q3/1.ogg');
file2 = audioread('q3/2.ogg');
file3 = audioread('q3/3.ogg');
file4 = audioread('q3/4.ogg');
file5 = audioread('q3/5.ogg');
file6 = audioread('q3/6.ogg');
file7 = audioread('q3/7.ogg');
file8 = audioread('q3/8.ogg');
file9 = audioread('q3/9.ogg');
tone = audioinfo('q3/6.ogg');
tone_len= tone.Duration;
info = audioinfo(rec_file);
rec_duration = info.Duration;
datalength = info.SampleRate;
%data = [file0(1:datalength),file1(1:datalength),file2(1:datalength),file3(1:datalength),
 %   file4(1:datalength),file5(1:datalength),file6(1:datalength) ,file7(1:datalength),file8(1:datalength),file9(1:datalength)];
%data = arrayfunc(,array);
data = zeros(10,datalength);
for i=1:10
    my = strcat('file',num2str(i-1));
    my2 = eval(my);
    data(i,:) = my2(1:datalength);
end
[read,fs] = audioread(rec_file);
diff_nums = rec_duration/tone_len;
%seps = reshape(read,[],diff_nums);
res = uint32(0);
for j = [1:diff_nums]
    sig = read((j-1)*datalength +1 : j*datalength);
    %disp(size(data));   
    %disp(size(sig));
    [m,p] = max(data*sig);
    res = res*10 + (p-1);
end
findnum = res;
disp(findnum);
end

