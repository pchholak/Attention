xxx

%% Given
sub = [5:9 11 12]; nsub = length(sub);

%% Add to path
path = '..';
addpath(path)

% Tm = [];
T1 = []; T2 = [];
for s=sub
    [t1, t2] = invol_sub(s);
    T1 = [T1; t1']; T2 = [T2; t2'];
    % Tm = [Tm; mode(t1), mode(t2)];
end
T = [T1; T2];

figure
subplot(1,2,1), histogram(T1,'Normalization','pdf')
xlabel('Dominance time (s)')
ylabel('Probability')
title('\tau_1')
set(gca,'FontSize',14)
vline(mode(T1),'k--')
text_graph(sprintf('Mode = %0.3f s',mode(T1)),[.3 .9],12);
subplot(1,2,2), histogram(T2,'Normalization','pdf')
xlabel('Dominance time (s)')
ylabel('Probability')
title('\tau_2')
set(gca,'FontSize',14)
vline(mode(T2),'k--')
text_graph(sprintf('Mode = %0.3f s',mode(T2)),[.3 .9],12);
