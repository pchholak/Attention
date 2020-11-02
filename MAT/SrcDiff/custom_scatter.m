function [p, lm] = custom_scatter(x, y, exc, dx, names, M)
% Draws scatter plot of X and Y with a linear best fit and ANOVA
% 
%     x:              Numerical array; Contains x-axis values
%     y:              Numerical array; Contains y-axis values
%     exc:          Numerical array; Contains which values to exclude
%     dx:            Numerical value; Specifies offset of text labels on each point
%     names:    String cell; Contains name of each point in the graph 
%     M:             Char value: Specifies marker shape
% 
%     p:              Figure handle; Handle to the drawn figure
%     lm:            Linear model; Linear model fitting the given data
% 
% Example: [p,lm] = custom_scatter(x,y,[],.05,names);

% ===== PARSE INPUTS =====
if nargin < 6 || isempty(M)
    M = 'c';
end

% Given
x = x'; y = y'; % Convert to column vector
x(exc) = []; y(exc) = []; names(exc) = [];

% Fit
fit = polyfit(x,y,1);
bfl = polyval(fit,x);

% Plot scatter with labels
p = plot(x, bfl, 'LineWidth', 2);
hold on
scatter(x, y, [], 'k',M,'filled')
hold off
text(x+dx, y, names)

% ANOVA
lm = fitlm(x,y,'linear');
anova(lm,'summary')
end