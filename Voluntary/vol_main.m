xxx

%% Given
sub = 13:17;
nsub = length(sub);
fexp = 'Voluntary_L2R.xlsx';
% fexp_pow = 'Voluntary_NormPower.xlsx';

%% Loop over all subjects
Data = zeros(nsub, 3);
% Power = zeros(nsub, 4);
for isub=1:nsub
    [dLR, D1, D2] = vol_sub(sub(isub));
    Data(isub, :) = [dLR, D1, D2];
    % [dLR, D1, D2, Pn] = vol_sub(sub(isub));
    % Power(isub, :) = Pn;
end

%% Export to Excel
xlswrite(fexp, Data)
% xlswrite(fexp_pow, Power)
