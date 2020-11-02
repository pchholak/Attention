xxx

% Given
sub = [4:12 15 17]; nsub = length(sub);

[pm0, pm1, pm2, f0, f] = psd_sub(sub(1));
P0 = zeros(length(pm0), nsub); P1 = zeros(length(pm1), nsub); P2 = P1;
P0(:, 1) = pm0; P1(:, 1) = pm1; P2(:, 1) = pm2;
for isub=2:nsub
    sprintf('Subject-%02d', sub(isub))
    [pm0, pm1, pm2] = psd_sub(sub(isub));
    P0(:, isub) = pm0; P1(:, isub) = pm1; P2(:, isub) = pm2;
end

Pm0 = mean(P0, 2); Pm1 = mean(P1, 2); Pm2 = mean(P2, 2);

figure
plot(f0, Pm0, f, Pm1, f, Pm2, 'LineWidth', 2)
xlim([5 20])
xlabel('f (Hz)')
ylabel('|P(f)|')
legend({'Background', 'Left', 'Right'}, 'FontSize', 12, 'Location', 'NorthWest')
set(gca, 'FontSize', 14)
vline([13.33 17.14], '--')
