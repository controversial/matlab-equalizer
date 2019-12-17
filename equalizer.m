clear

% Boundaries for equalizer frequency bands
bounds = [1 199; 200 499; 500 999; 1000 4999; 5000 20000];
% How much should we strengthen/weaken each frequency band by?
attenuations = [1.5 0.5 0.75 1.2 1];
% Make sure that the number of arguments matches up; enforce consistency
assert(length(attenuations) == length(bounds));

[song, rate]=audioread('frank.mp3');
song = song(:,1); % Convert from stereo to mono

player = audioplayer(song, rate);
% play(player);

songfft = fft(song, length(song));
% Get vector with frequency values
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
xlabel('frequency (Hz)')
ylabel('amplitude');
xlim([0 4000]); % plot up to a frequency of 4000 Hz only



% Mutate FFT according to specified parameters
newfft = songfft;

for i=1:length(bounds)
    lower = bounds(i, 1); upper = bounds(i, 2);
    newfft = adjustBand(newfft, rate, lower, upper, attenuations(i));
end

% Get new audio file
newSong = real(ifft(newfft, length(song)));

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

soundsc(newSong, rate);
% player2 = audioplayer(newSong, rate);
% play(player2);


function f = adjustBand(fft, rate, low, upp, atten)
    % Attenuate frequencies
    for i=ceil(low/rate*length(fft)):1:ceil(upp/rate*length(fft))
        % Change frequency amplitude on both lower and upper ends of the
        % fft spectrum
        fft(i) = atten*fft(i);
        fft(length(fft)-i) = atten*fft(length(fft)-i);
    end
    f = fft;
end
