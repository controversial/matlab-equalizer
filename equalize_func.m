% Adjust the amplitude of certain frequency bands in an audio sample in
% order to change the character of the sound.
% Params:
% - freqBands: vector containing audio samples
% - rate: the sampling rate associated with the audio vector
% - freqBands: the frequency bands upon which the equalizer should operate
% - attenuations: the scale factor for the amplitude of each band 
function newAudio = equalize_func(audio, rate, freqBands, attenuations)
    % Make sure there is 1 attenuation value to go with each frequency band
    assert(length(attenuations) == length(freqBands));

    audio = audio(:,1); % Discard stereo data if present
  
    % Perform a fast fourier transform on the audio data to enable frequency
    % analysis
    audiofft = fft(audio, length(audio));

    % Mutate FFT according to specified parameters
    newfft = audiofft;
    for i=1:length(freqBands) % Iterate through each frequency band
        lower = freqBands(i, 1); upper = freqBands(i, 2);
        newfft = adjustBand(newfft, rate, lower, upper, attenuations(i));
    end

    % Get new audio file
    newAudio = real(ifft(newfft, length(audio)));
end


function f = adjustBand(fft, rate, low, upp, atten)
    % Attenuate frequencies
    for i=ceil(low/rate*length(fft)):1:ceil(upp/rate*length(fft))
        % Change frequency amplitude on both lower and upper ends of the
        % fft spectrum
        fft(i) = atten*fft(i);
        fft(length(fft)-i) = atten*fft(length(fft)-i);
    end
    % Return modified FFT spectrum
    f = fft;
end
