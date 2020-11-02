function strip_trials(info, cond, isInit)
% Strips trials in shorter segments for a given subject and experimental
% condition specified by the input arguments
%
% Inputs
%   info.name:    Subject's name [str]
%   info.root:    Path to the brainstorm study [str]
%   info.folder:  Name of the folder with imported trials [str]
%   cond:         Condition [str]

% ===== PARSE INPUTS =====
if nargin < 3 || isempty(isInit)
    isInit = 0;
end

% Given
strip_size = 3000; % For 3-second strips

% Load trials and kernel
sprintf('Loading time series from trials...')
if isInit
    [X_all, t, K] = load_trials(info, cond, 1);
else
    [X_all, t] = load_trials(info, cond);
end
N = size(X_all, 3); nt = length(t);

% Create new subject folder and save kernel file
if isInit
    mkdir(info.root_to_stripped, info.name)
end
path_to_stripped = fullfile(info.root_to_stripped, info.name);
if isInit
    save([path_to_stripped, '/exp_KERNEL_file.mat'], 'K')
end

% Strip trials and write to new location
n_seg = floor(nt/strip_size);
for q=1:N % Loop over all trials
    for seg=1:n_seg % Loop over each segment
        F = X_all(:, strip_size*(seg-1)+1:strip_size*seg, q);
        sprintf('Size of F: (%d x %d); Trial#: %02d', size(F), q)
        fname = sprintf('/data_%s_trial%03d_%03d.mat', cond, q, seg);
        Time = t(strip_size*(seg-1)+1:strip_size*seg);
        save([path_to_stripped, fname], 'F', 'Time')
    end
end
