xxx

% Given
sub = [5:9 11:13 17];
nsub = length(sub);

Tm = [];
T1 = []; T2 = [];
for s=sub
    [t1, t2] = invol_sub(s);
    T1 = [T1; t1']; T2 = [T2; t2'];
    Tm = [Tm; mode(t1), mode(t2)];
end
% T = [T1; T2];

figure

subplot(1,2,1), h1 = histogram(T1,'Normalization','pdf');
ylim([0 max(h1.Values)])
xlabel('T_1')
ylabel('Probability')
set(gca,'FontSize',14)
vline(mode(T1),'k--')
text_graph(sprintf('Mode = %0.3f s',mode(T1)),[.15 .9],12);

subplot(1,2,2), h2 = histogram(T2,'Normalization','pdf');
ylim([0 max(h2.Values)])
xlabel('T_2')
ylabel('Probability')
set(gca,'FontSize',14)
vline(mode(T2),'k--')
text_graph(sprintf('Mode = %0.3f s',mode(T2)),[.15 .9],12);
