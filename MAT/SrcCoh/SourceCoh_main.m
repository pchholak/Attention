close all
clear
clc

% Given
iSubj = 5;
f1 = 120/9;
info.root_to_stripped = 'D:/Research/Academic/PhD/Attention/Stripped'
info.res_path_coh = 'D:/Research/Academic/PhD/Attention/Coherence';

info.name = sprintf('sub%02d', iSubj);
SourceCoh_cond(info, 'B', f1)
SourceCoh_cond(info, 'I', f1)
