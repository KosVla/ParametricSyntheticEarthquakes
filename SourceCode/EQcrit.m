function [PGA, RMSA, NCE, ERMSA, ZC] = EQcrit(y)

% EQcrit computes the PGA, RMSA, ERMSA, NCE, and ZC (from below)
% criteria of a given earthquake accelererogram

N = length(y);
% a) Peak ground acceleration
PGA = max(abs(y));

% b) Root-mean-square acceleration 
RMSA = sqrt((1/N)*sum(y.^2));

% c) Normalized cumulative energy
NCE = zeros(size(y));
% d) Evolutionary root-mean-square acceleration
ERMSA = zeros(size(y));
% e) +Zero crossings
ZC = zeros(size(y));
for ii=1:N
    NCE(ii) = sum(y(1:ii).^2)/(N*(RMSA^2)); 
    ERMSA(ii) = sqrt((1/ii)*sum(y(1:ii).^2));
    if ii>1
        if y(ii)>0 && y(ii-1)<0
            ZC(ii) = ZC(ii-1) + 1;
        else
            ZC(ii) = ZC(ii-1);
        end
    end
end