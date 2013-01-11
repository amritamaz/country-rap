% 15 Second Clips %

% COUNTRY %
% [d1a, sr1a] = mp3read('country1_beer.mp3');
[d1, sr1] = mp3read('country1_beerCUT.mp3');
[d1b, sr1b] = mp3read('country1_beerCUT.mp3', sr1*5);
subplot(2,2,1);
specgram(d1b(:,1),1024,sr1b);
title('country1\_beer');
ylim([0 4000]);

% [d2, sr2] = mp3read('country2_redneck.mp3');
[d2, sr2] = mp3read('country2_redneckCUT.mp3');
[d2b, sr2b] = mp3read('country2_redneckCUT.mp3', sr2*5);
subplot(2,2,2);
specgram(d2b(:,1),1024,sr2b);
title('country2\_redneck');
ylim([0 4000]);


% RAP %
% [d3, sr3] = mp3read('rap1_jayz.mp3');
[d3, sr3] = mp3read('rap1_jayzCUT.mp3');
[d3b, sr3b] = mp3read('rap1_jayzCUT.mp3');
subplot(2,2,3);
specgram(d3b(:,1),1024,sr3b);
xlabel('Time (s)');
title('rap1\_jayz');
ylim([0 4000]);


% [d4, sr4] = mp3read('rap2_nicki.mp3');
[d4, sr4] = mp3read('rap2_nickiCUT2.mp3');
[d4b, sr4b] = mp3read('rap2_nickiCUT2.mp3', sr4*5);
subplot(2,2,4);
specgram(d4b(:,1),1024,sr4b);
title('rap2\_nicki');
ylim([0 4000]);
