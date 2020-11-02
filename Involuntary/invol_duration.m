function tau = invol_duration(sw,f)

%Finds the durations of swithces
%   'sw': switching vector
%   'f': 1 for f1; 0 for f2
%   'tau': array with all time durations for switches in f frequency

Fs = 1000;
ts = [];
for i=1:length(sw)
    if sw(i)==f
        ts = [ts, i];
    end
end

tau = []; len = 1;
for j=2:length(ts)
    if j<length(ts)
        if ts(j)==ts(j-1)+1
            len = len + 1;
        else
            tau = [tau, len];
            len = 1;
        end
    else
        tau = [tau, len];
    end
end

tau = tau / Fs;
end
