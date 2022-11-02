%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      Modulation function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function q = modulfun(th,N,Ts)

%   MODULFUN computes the modulating function 
%
%   Q = MODULFUN(TH,N,Ts)
%
%   TH : modulating function parameters 
%   N : number of samples
%   Ts : sampling period


q = zeros(N,1);

% Parameters
if length(th) == 6
    T0 = th(1);
    T1 = th(2);
    T2 = th(3);
    alpha = th(4);
    beta = th(5);
    sigma_max = th(6);
    
    % Check parameter values
    if (T1<=T0) || (T2<T1)
        error('Inconsistent modulating function time index parameters (T0 < T1 <= T2).')
    end
    if (sigma_max < 0) || (alpha < 0) || (beta < 0)
        error('Inconsistent modulating function parameters (sigma_max, alpha, beta > 0).')
    end

    % Calculation of the modulating function
    for t = 0:N-1
        if t*Ts <= T0
            q(t+1) = 0;
        elseif (t*Ts > T0) && (t*Ts <= T1)
            q(t+1) = sigma_max*(((t*Ts-T0)/(T1-T0))^2);
        elseif (t*Ts > T1) && (t*Ts <= T2)
            q(t+1) = sigma_max;
        else
            q(t+1) = sigma_max*exp(-alpha*((t*Ts-T2)^beta));
        end
    end
    
else % Gamma modulating function
    alpha1 = th(1);
    alpha2 = th(2);
    alpha3 = th(3);
    if length(th)==3
        T0 = 0;
    else
        T0 = th(4);
    end
    
    % Check parameter values
    if (alpha1<=0) || (alpha3<=0) || (alpha2<=1)
        error('Inconsistent modulating function parameters (a1,a3 > 0 and a2 > 1.')
    end
    if (T0<0) || (T0>1)
        error('Inconsistent initial time instant T0 ( 0 <= T <= 1.')
    end
    
    % Calculation of the modulating function
    T = (0:N-1)'/(N-1);
    DT = (T-T0);
    q = alpha1*((DT).^(alpha2-1)).*exp(-alpha3*DT);
    q(DT<0) = 0;
end