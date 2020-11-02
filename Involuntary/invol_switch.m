function sw = invol_switch(dE)
%Gives the switching time series based on dE surpassing
%threshold calculated from standard deviation of dE

th = std(dE);
bound = double(abs(dE)>th);
conv = dE.*bound; conv_dc = conv;
k = find(abs(dE)>th); k1 = k(1); val = conv(k1);

n = length(dE);
for i=1:n
    if (bound(i)==1)&&(dE(i)>0)
        conv_dc(i) = 1;
    elseif (bound(i)==1)&&(dE(i)<0)
        conv_dc(i) = -1;
    end
end

sw = zeros(1,n);
if val>0
    sw(1) = 1;
else
    sw(1) = 0;
end

for p=2:length(dE)
    if sw(p-1)==1
        if conv_dc(p)>-1
            sw(p) = 1;
        elseif conv_dc(p)==-1
            sw(p) = 0;
        end
    elseif sw(p-1)==0
        if conv_dc(p)<1
            sw(p) = 0;
        elseif conv_dc(p)==1
            sw(p) = 1;
        end
    end
end
end