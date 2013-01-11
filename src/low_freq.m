%% read in song file

[d2, sr2] = mp3read('country1_beerCUT.mp3');
[d2b, sr2b] = mp3read('country1_beerCUT.mp3', sr2*5, 1);
xlen = 1:1:sr2b;
subplot(2,2,1);
specgram(d2b,1024,sr2b);
colorbar;
title('country1\_beer');
% ylim([0 4000]);

subplot(2,2,2)
plot(d2b);
title('Time-Domain signal');

fftsig = fft(d2b);
fs = 1/(length(fftsig));
f =  fs/2*linspace(-1,1,length(fftsig));

subplot(2,2,3)
title('notfftshift');
plot(f,fftsig);
% not sure if this is right
fftsig = fftshift(fftsig);
subplot(2,2,4)
title('fftshifted');
plot(f,fftsig);

%Next, calculate the frequency axis, which is defined by the sampling rate

%Since the signal is complex, we need to plot the magnitude to get it to
%look right, so we use abs (absolute value)
% subplot(2,2,3)
% plot(f, abs(fftsig));
% title('magnitude FFT of cosine');
% xlabel('Frequency (Hz)');
% ylabel('magnitude');
