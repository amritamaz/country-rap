function FinalTest(mp3signal)
[d, sr] = mp3read(mp3signal); %try to precut the signal

figure;
%%-----------------------Draw a spectogram
subplot(2,2,1);
specgram(d(:,1),1024,sr);
colorbar;
str1 = sprintf('Spectrogram: %s',mp3signal);
title(str1);
ylim([0 4000]);


%%------------------------------ZERO CROSSING
% find length of wav file 
len_samp = length(d);
% Length of frame 
frame_size = .02;
frame_length = round(sr*frame_size); 
frames_per_sec = round(1/frame_size); % 50 frames per second
% Calculate number of zero-crossings in each frame 
zcr = []; 
n=1;
for frame = 1:frame_length:len_samp-frame_length
    frameData = d(frame:frame+frame_length-1);
    % Sum up zero crossings accross frame 
    zcr(n) = 0;
    for i = 2:length(frameData)
    zcr(n) = zcr(n) + abs(sign(frameData(i)) - sign(frameData(i-1))); 
    end
    zcr(n) = zcr(n)/(2*frame_length); 
    n=n+1;
end
num_frames = length(zcr);
zcr(zcr>.005)=0;
subplot(2,2,2);
plot(1:1:num_frames,zcr)
%axis([0 300 -.005 .005]) %for cutoff
str2 = sprintf('Zero Crossings: %s',mp3signal);
title(str2);
xlabel('Frame');
ylabel('Sum of Zero Crossings Across Frame');

% %% Beat Peaks
% 
% [d2, sr2] = mp3read(mp3signal, sr*5, 1);
% y1 = abs(x);
% y2 = filter(.01, [1 -.99], y1);
% y3 = downsample(y2, 16);
% y4 = y3 - mean(y3);
% y5 = conv(y4, fliplr(y4));
% a = conv(y5, fliplr(y5));
% b = conv(a, fliplr(a));
% c = conv(b, fliplr(b));
% y7 = conv(c, fliplr(c));
% y8 = downsample(y7, 128);
% y9 = sort(y8, 'descend');
% sortlen = floor(.05*length(y9));
% y10 = zeros(1,sortlen);
% for K = 1:sortlen
%     y10(K) = y9(K);
% end


if any(zcr)
    signal_type = 'This is a rap music signal';
end
if ~any(zcr)
    signal_type = 'This is a country music signal';
end

disp(signal_type);

