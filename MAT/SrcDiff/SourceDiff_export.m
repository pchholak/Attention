% The program should be started after clearing the workspace and exporting
% the Test source time average file as 'xyz' and changing 'sub'

%% Given
iSubj = 5;
info.res_path_coh = 'D:/Research/Academic/PhD/Attention/Coherence/';
keywd = 'Coh(120by3s)';

%% Locate and list .mat files
fmatI = dir([info.res_path_coh, keywd, '*_Subject', sprintf('%02d',iSubj), '_I.mat']);
fmatB = dir([info.res_path_coh, keywd, '*_Subject', sprintf('%02d',iSubj), '_B.mat']);

%% Load files, average and take difference
load([info.res_path_coh, fmatI(1).name]); clear fmatI
srcm = mean(src, 2); srcI = [srcm, srcm];
load([info.res_path_coh, fmatB(1).name]); clear fmatB
srcm = mean(src, 2); srcB = [srcm, srcm];
img = srcI-srcB;

%% Prepare to export
xyz.ImageGridAmp = img;
xyz.Comment = ['Diff_' keywd '_Subject' sprintf('%02d',iSubj)];
clear info
