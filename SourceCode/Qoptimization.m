function [RES,th,IAs,t5s,t45s,t95s,IATs,D5_45s,D5_95s] = Qoptimization(th0,Y,Ts,Ia,D5_45,D5_95)

RES = zeros(size(th0,1),1);

if nargin<4
    N = length(Y);
    % Arias intensity of the real EQ accelerogram
    [Ia,~,tmid,~,~,D5_45,D5_95] = EQarias(Y,Ts); 
else
    N = Y;
    tmid = D5_45;
end

for i=1:size(th0,1)
    % alpha_2 and alpha_3
    a2 = th0(i,1);
    a3 = th0(i,2);

    t5s =  gaminv(0.05,2*a2-1,2*a3);
    t45s = gaminv(0.45,2*a2-1,2*a3);
    t95s = gaminv(0.95,2*a2-1,2*a3);

    D5_95s = (t95s - t5s);
    D5_45s = (t45s - t5s);

    RES(i) = 100*(abs(D5_95 - D5_95s)/D5_95 + abs(D5_45 - D5_45s)/D5_45)/2;
end
    
if nargout>1 && size(th0,1)==1
    a1 = sqrt(Ia*((2*a3)^(2*a2-1)/gamma(2*a2-1)));
    if tmid - t45s > 0
        T0 = (tmid - t45s);
    else
        T0 = 0;
    end
    th = [a1 a2 a3 T0];
    IAs = (a1^2)*gamma(2*a2-1)/((2*a3)^(2*a2-1));
    IATs = gamcdf((0:N-1)/(N-1),2*a2-1,2*a3);
end