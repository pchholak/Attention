function custom_gamma(data,nbins)

% Given
x = min(data):.1*min(data):max(data);

% Evaluate paramters of gamma dist.
pd = fitdist(data,'gamma');
y = pdf(pd,x);

% Plot
hold on
histogram(data,nbins,'normalization','pdf')
plot(x,y,'LineWidth',2)
hold off