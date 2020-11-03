% The program should be started after clearing the workspace and exporting
% the Test source time average file as 'xyz' and changing 'sub'

%% Given
iSubj = 5;
info.res_path_coh = 'D:/Research/Academic/PhD/Attention/Coherence/';
keywd = 'Coh(120by3s)';
f1 = 120/9; f2 = 120/7;

%% Locate and list .mat files
fmatI1 = dir([info.res_path_coh, sprintf('%s_%0.4fHz_Subject%02d_%s.mat', ...
    keywd, f1, iSubj, 'I')]);
fmatB1 = dir([info.res_path_coh, sprintf('%s_%0.4fHz_Subject%02d_%s.mat', ...
    keywd, f1, iSubj, 'B')]);
fmatI2 = dir([info.res_path_coh, sprintf('%s_%0.4fHz_Subject%02d_%s.mat', ...
    keywd, f2, iSubj, 'I')]);
fmatB2 = dir([info.res_path_coh, sprintf('%s_%0.4fHz_Subject%02d_%s.mat', ...
    keywd, f2, iSubj, 'B')]);

%% Load files, average and take difference
load([info.res_path_coh, fmatI1(1).name]); clear fmatI1
srcm = mean(src, 2); srcI1 = [srcm, srcm];
load([info.res_path_coh, fmatB1(1).name]); clear fmatB1
srcm = mean(src, 2); srcB1 = [srcm, srcm];
img1 = srcI1-srcB1;

load([info.res_path_coh, fmatI2(1).name]); clear fmatI2
srcm = mean(src, 2); srcI2 = [srcm, srcm];
load([info.res_path_coh, fmatB2(1).name]); clear fmatB2
srcm = mean(src, 2); srcB2 = [srcm, srcm];
img2 = srcI2-srcB2;

img = (img1 + img2) / 2;

%% Prepare to export
xyz.ImageGridAmp = img;
xyz.Comment = ['Diff_' keywd '_Subject' sprintf('%02d', iSubj)];
clear info
