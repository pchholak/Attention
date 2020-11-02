function [fr1,fr2] = freq_sets(freq)
% Creates non-repeating frequency pairs without any subharmonics
%   'freq': Array containing all the single frequencies

N = length(freq);
fr1 = []; fr2 = []; ih = [];
for i = 1:N
    for j = i+1:N
        fr1 = [fr1 freq(i)];
        fr2 = [fr2 freq(j)];
        if 2*freq(i)==freq(j) % Indices for subharmonic entries
            ih = [ih length(fr1)];
        end
    end
end
fr1(ih) = []; fr2(ih) = []; % Remove harmonics
end