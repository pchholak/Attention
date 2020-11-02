close all
clear
clc

% Given
iSubj = 5;
info.root = 'D:/brainstorm_db/Perception/data';
info.root_to_stripped = 'D:/Research/Academic/PhD/Attention/Stripped';

% Strip 'B' and 'I' trials and get Kernel matrix
info.name = sprintf('Subject%02d', iSubj);
info.folder = 'run_percep_tsss_notch';
strip_trials(info, 'B', 1)
strip_trials(info, 'I')
