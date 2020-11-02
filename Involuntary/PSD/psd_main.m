xxx

% Given
sub = [5:9, 11:13, 15, 17]; nsub = length(sub);

[pm1, f] = psd_sub(sub(1));
P1 = zeros(length(pm1), nsub); P1(:, 1) = pm1;
for isub=2:nsub
    sprintf('Subject-%02d', sub(isub))
    pm1 = psd_sub(sub(isub));
    P1(:, isub) = pm1;
end
Pm1 = mean(P1, 2);

figure
plot(f, Pm1, 'LineWidth', 2)
xlim([5 20])
xlabel('f (Hz)')
ylabel('|P(f)|')
legend({'Involuntary'}, 'FontSize', 12)
set(gca, 'FontSize', 14)
vline([13.33 15.24 17.14], '--')
