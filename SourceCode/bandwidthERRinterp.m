function [RSS,PM_NM,PM_NMs] = bandwidthERRinterp(th,Y,Ts,tmid,options)

N = length(Y);
omega_c = 0.25;

% Positive minima & negative maxima
PM_NM = zeros(size(Y));
for t = 2:N-1
    if ( all(Y(t-1:t+1)>0) && (Y(t)<Y(t-1) && Y(t)<Y(t+1)) ) || ...
            ( all(Y(t-1:t+1)<0) && (Y(t)>Y(t-1) && Y(t)>Y(t+1)) )
        PM_NM(t) = PM_NM(t-1) + 1;
    else
        PM_NM(t) = PM_NM(t-1);
    end
end
PM_NM(N) = PM_NM(N-1);

% IRF non-stationary filter
%================================================
s = filterIRF(th(1:3),N,Ts,tmid);
% Computation of the modulating function
%================================================
q = modulfun(th(4:end),N,Ts);

PM_NMsim = zeros(length(Y),options.iter);
for i = 1:options.iter
    u = randn(N,1);
    % Synthesized earthground motion signal
    %================================================
    z = q.*(s*u);
    
    % Positive minima & negative maxima
    for t = 2:N-1
        if ( all(z(t-1:t+1)>0) && (z(t)<z(t-1) && z(t)<z(t+1)) ) || ...
                ( all(z(t-1:t+1)<0) && (z(t)>z(t-1) && z(t)>z(t+1)) )
            PM_NMsim(t,i) = PM_NMsim(t-1,i) + 1;
        else
            PM_NMsim(t,i) = PM_NMsim(t-1,i);
        end
    end
    PM_NMsim(N,i) = PM_NMsim(N-1,i);
end

PM_NMs = mean(PM_NMsim,2);
RSS = 100*(norm(PM_NMs-PM_NM)^2)/(norm(PM_NM)^2);