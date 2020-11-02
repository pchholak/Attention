function [F, Time, K] = load_trials(info, cond, iskern)
% Loads all the MEG trials stored in .mat format for the given subject and
% condition. Optionally, it also returns imaging kernel (if any).
%
% Usage
%   [X, t, K] = load_trials(info, cond, iskern)
%
% Inputs
%   info.name:    Subject's name [str]
%   info.root:    Path to the brainstorm study [str]
%   info.folder:  Name of the folder with imported trials [str]
%   cond:         Condition [str]
%   iskern:       Indicator to load imaging kernel [num]
%                 ikern = 1 Yes
%                       = 0 No
%
% Outputs
%   X:  Matrix containing all the loaded time series
%       [nChannels, nTime, nTrials]
%   t:  Time vector for the first trial loaded
%   K:  Imaging kernel

% ===== PARSE INPUTS =====
if nargin < 3 || isempty(iskern)
    iskern = 0;
end

% Locate and list trial mat-files
path = fullfile(info.root, info.name, info.folder);
fmat = dir([path, '/*_', cond, '_*.mat']); nmat = length(fmat);

% Load MEG time series for all channels and all trials
load([path, '/', fmat(1).name], 'F', 'Time');

% Load kernel
if iskern == 1
    Kmat = dir([path, '/*KERNEL*.mat']);
    load([path, '/', Kmat.name], 'ImagingKernel')
    K = ImagingKernel;
elseif iskern == 0
    K = [];
else
    error('Value of iskern must be either 0 or 1')
end
