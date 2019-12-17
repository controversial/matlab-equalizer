clear

% Boundaries for equalizer frequency bands
freqBands = [1 199; 200 499; 500 999; 1000 4999; 5000 20000];
% How much should we strengthen/weaken each frequency band by?
attenuations = [1.5 0.5 0.75 1.2 1];

[song, rate]=audioread('frank.mp3');

songfft = fft(song, length(song));
songfreqs = rate * (0:floor(length(song)/2)) / length(song);

% Display initial waveform
subplot(2, 2, 1);
plot((1:1:length(song)), song, '-r');
xlabel('time');
ylabel('amplitude');

% Display initial fft
% Plot frequencies against their amplitudes
subplot(2, 2, 2);
plot(songfreqs, abs(songfft(1:floor(length(song)/2+1))), '-r');
xlabel('frequency (Hz)');
ylabel('amplitude');
xlim([0 4000]); % plot up to a frequency of 4000 Hz only


newSong = equalize_func(song, rate, freqBands, attenuations);
newfft = fft(newSong, length(newSong));

% Display modified waveform
subplot(2, 2, 3);
plot((1:1:length(song)), newSong, '-r');
xlabel('time');
ylabel('amplitude');

% Display modified FFT
subplot(2, 2, 4);
plot(songfreqs, abs(newfft(1:floor(length(song)/2+1))), '-r');
xlabel('frequency (Hz)')
ylabel('amplitude');
xlim([0 4000]);



% Play final song
player = audioplayer(newSong, rate);
play(player);
