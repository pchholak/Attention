% The program should be started after clearing the workspace and exporting
% the Test source time average file as 'xyz' and changing 'sub'

%% Given
sub = 6;
info.res_path_coh = '/home/rommel/research/results/perception/Coherence/';
keywd = 'Coh(120by3s)';

%% Locate and list .mat files
fmatF = dir([info.res_path_coh, keywd, '*_sub', sprintf('%02d',sub), '_F.mat']);
fmatB = dir([info.res_path_coh, '*_sub', sprintf('%02d',sub), '_B.mat']);

%% Load files, average and take difference
load([info.res_path_coh, fmatF(1).name]); clear fmatF
srcm = mean(src, 2); srcF = [srcm, srcm];
load([info.res_path_coh, fmatB(1).name]); clear fmatB
srcm = mean(src, 2); srcB = [srcm, srcm];
img = srcF-srcB;

%% Prepare to export
xyz.ImageGridAmp = img;
xyz.Comment = ['Diff_' keywd '_sub' sprintf('%02d',sub)];
clear info
