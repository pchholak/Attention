function SourceCoh_cond(info, cond, f)

% Estimate trial data size
sprintf('Estimating trial data size...')
path = fullfile(info.root_to_stripped, info.name);
files_cond = dir([path, '/*_', cond, '_*.mat']);
n_files = length(files_cond);

% Extract time 't' from the first trial and Kernel 'K' 
load([path, '/', files_cond(1).name], 'Time'); t = Time;
kernel_file = dir([path, '/*_KERNEL_*.mat']);
load([path, '/', kernel_file.name], 'K')
[nV, nch] = size(K);

% Loop over each trial
C = zeros(nV, n_files);
for q=1:n_files
    sprintf('Loading file %d out of %d files', q, n_files)
    load([path, '/', files_cond(q).name], 'F')
    X = F(1:nch, :);
    % Calculate time series at each vertex
    sprintf('Calculating time series in source space...')
    S = X'*K';
    % Evaluate coherence at each vertex
    sprintf('Calculating coherence in source space...')
    C(:, q) = SourceCoh_evaluate(S, t', f);
end

%% Write results
src = C;
fname = sprintf('Coh(120by3s)_%0.4fHz_%s_%s.mat', f, info.name, cond);
fpath = [info.res_path_coh, '/', fname];
save(fpath, 'src')
