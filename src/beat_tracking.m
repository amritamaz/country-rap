figure;

[d2, sr2] = mp3read('rap1_jayzCUT.mp3');
[d2b, sr2b] = mp3read('rap1_jayzCUT.mp3', sr2*5, 1);
% [d2, sr2] = mp3read('rap2_nickiCUT2.mp3');
% [d2b, sr2b] = mp3read('rap2_nickiCUT2.mp3', sr2*5, 1);
% [d2, sr2] = mp3read('country1_beerCUT.mp3');
% [d2b, sr2b] = mp3read('country1_beerCUT.mp3', sr2*5, 1);
% [d2, sr2] = mp3read('country2_redneckCUT.mp3');
% [d2b, sr2b] = mp3read('country2_redneckCUT.mp3', sr2*5, 1);


x = d2b;
subplot(3,2,1)
plot(x);
xlabel('Samples');
ylabel('Gain');
xlim([0 length(x)]);
title('original signal');
disp('sig done');

%% full wave rectification

y1 = abs(x);
subplot(3,2,2);
plot(y1);
xlim([0 length(y1)]);
xlabel('Samples');
ylabel('Gain');
title('Full Wave Rectification');
disp('full rect done');

%% low pass filtering

% simple low pass filter with one pole and alpha val of .99
% used to smooth envelope
% y[n] = (1-a)x[n] + a*y[n-1]
% y[n] - a*y[n-1] = (1-a)x[n]
% (1-az^-1)y[n] = (1-a)x[n]
% (1-a)/(1-az^-1) = H(z)
% a = .99 -> .01/(1-.99*z^-1) = H(z)

y2 = filter(.01, [1 -.99], y1);
subplot(3,2,3);
plot(y2);
xlim([0 length(y2)]);
title('Low Pass Filter');
xlabel('Samples');
ylabel('Gain');
disp('lp done');

%% downsampling -> for computational efficiency

y3 = downsample(y2, 16);
subplot(3,2,4);
plot(y3);
xlim([0 length(y3)]);
xlabel('Samples');
ylabel('Gain');
title('Downsampling x16');
disp('downsp done');

%% mean removal - center signal at zero
y4 = y3 - mean(y3);
subplot(3,2,5);
plot(y4);
xlim([0 length(y4)]);
xlabel('Samples');
ylabel('Gain');
title('Mean Removal');
disp('mean rem done');
% std(y4)

% %% autocorrelation
y5 = conv(y4, fliplr(y4));
a = conv(y5, fliplr(y5));
b = conv(a, fliplr(a));
c = conv(b, fliplr(b));
y7 = conv(c, fliplr(c));
% subplot(3,2,6);
% plot(y7);
% xlabel('Samples');
% ylabel('Gain');
% xlim([0 length(y7)]);
% title('Autocorrelation x10');
disp('autocr done');

ha = axes('Position',[0 0 1 1],'Xlim',[0 1],'Ylim',[0 
1],'Box','off','Visible','off','Units','normalized', 'clipping' , 'off');

text(0.5, 1,'\bf Beat Tracking - Beer Money','HorizontalAlignment','center','VerticalAlignment', 'top');


%% fourier plot

fftsig = fft(y5);
% fftsig = fftshift(fftsig);
fs = 1/(length(fftsig));
f =  fs/2*linspace(-1,1,length(fftsig));
subplot(3,2,6); 
plot(f,abs(fftsig));
xlabel('\omega');
ylabel('Gain');
title('FFT');

%% get max values
% sort, get top 10%, avg
% downsample first

y8 = downsample(y7, 256);

y9 = sort(y8, 'descend');
sortlen = floor(.1*length(y9));
y10 = zeros(sortlen);
for K = 1:sortlen
    y10(K) = y9(K);
end

disp('sort done');

maxval = mean(y9)
