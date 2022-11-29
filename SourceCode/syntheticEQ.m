function [z,x,q,s] = syntheticEQ(theta,u,Ts,omega_c)

% syntheticEQ computes synthetic ground motion accelerograms based on the
% method describe in [1]
%
% [Z,X,Q,H] = syntheticEQ(Gmodul,Hfilter,u,Ts,omega_c)
%
% theta: modulating function and IRF filter parameter vector
%       case 1: omega_0 : initial freq. of the filter (Hz)
%               omega_n : final freq. of the filter (Hz)
%               zeta_f : damping ratio
%               T0 : process start time
%               T1 : start time of the strong motion phase
%               T2 : end time of the strong motion phase
%               sigma_max : gain of the modulating function during the decaying end
%               alpha : parameter of the modulating function that shape its decaying end
%               beta : parameter of the modulating function that shape its decaying end
%       case 2: omega_0 : initial freq. of the filter (Hz)
%               omega_n : final freq. of the filter (Hz)
%               zeta_f : damping ratio
%               alpha1 : modulating function intensity parameter
%               alpha2 : modulating function shape parameter
%               alpha3 : modulating function duration
% u : input white noise
% Ts : sampling period (s)
% omega_c : highpass filter cut-off frequency (Hz)
%
% Z : highpass filtered synthesized accelerogram (N x 1)
% X : synthesized accelerogram (N x 1)
% H : IRF filter that creates spectral non-stationarities (N x N)
% Q : modeulation function (N x 1)
%
% [1] Rezaeian, S. and A. Der Kiureghian, "A stochastic ground motion model with separable
%		temporal and spectral nonstationarities", Earthquake Engineering & Structural Dynamics,
%		Vol. 37, pp. 1565-1584, 2008.

%   Copyright 1980-2012, The MinaS Inc.
%   $ Version: 0.2 $ $Date: 09/07/2012 $

if isempty(u)
    u = randn(1000,1);
end

% Number of samples
N = length(u);

% IRF non-stationary filter
%================================================
s = filterIRF(theta(1:3),N,Ts);

% Computation of the modulating function
%================================================
q = modulfun(theta(4:end),N,Ts);

% Synthesized earthground motion signal
%================================================
x = q.*(s*u);

% High pass filtering [1,p.1579]
%================================================
omega_c = omega_c/(1/(2*Ts));
fnum = fir1(2,omega_c,'high');
z = filtfilt(fnum,1,x);

% Simplified approach following equations in [1]
% =========================================================================
% for t = 1:N
%     % IRF filter
%     for tau = 1:t
%         h(t-tau+1,tau) = (omega_f(tau)/sqrt(1-zeta_f^2))*...
%             exp(-zeta_f*omega_f(tau)*(t-tau)*Ts)*sin(omega_f(tau)*sqrt(1-zeta_f^2)*(t-tau)*Ts);
%     end
% 
%    for tau = 1:t
%         % Normalized IRF filter
%         if t > 1
%             Sh = 0;
%             for j = 1:t
%                 Sh = Sh + h(t-j+1,j)^2;
%             end
%             s(t,tau) = h(t-tau+1,tau)/sqrt(Sh);
%         else
%             s(t,tau) = h(t-tau+1,tau);
%         end
%    end
% end
% x = zeros(N,1);
% for t = 1:N
%     % Synthesized earthground motion signal
%     x(t) = q(t)*sum(s(t,1:t).*u(1:t,1)');
% end