%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        IRF filter 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [s,h,sdot,hdot] = filterIRF(th,N,Ts,tmid)

%   IRFfilter computes the non-stationary IRF filter
%
%   [s,h] = IRFfilter (TH,N,Ts)
%
%   TH : IRF filter parameters 
%   N : number of samples
%   Ts : sampling period

% IRF non-stationary filter
%================================================
omega_mid = th(1);
omega_dot = th(2);
zeta_f = th(3);
omega_f = omega_mid + omega_dot*Ts*((0:N-1)-tmid);

% Construction of matrix Omega having in its row omega_f
Omega = kron(ones(N,1),omega_f);
% Construction of matrix Tdif which has its lower triangular part the
% diferrences t-tau
Tdif = zeros(N);
for i=1:N
    Tdif(i:N,i) = (0:N-i)';
end

% IRF filter computation (h(t,tau) is constructed instead of h(t-tau,tau)
% in [1]; look at the end of this file for the original much slower implementation)
h = (Omega/sqrt(1-zeta_f^2)).*exp(-zeta_f*Omega.*Tdif*Ts).*...
    sin(sqrt(1-zeta_f^2)*Omega.*Tdif*Ts);

Sh = kron(ones(1,N),sum(h.^2,2));

% Normalized IRF filter
s = zeros(N);
s(2:end,:) = h(2:end,:)./sqrt(Sh(2:end,:));

if nargout>2
	hdot = (Omega/sqrt(1-zeta_f^2)).*...
        (exp(-zeta_f*Omega.*Tdif*Ts).*(-zeta_f*Omega*Ts).*sin(Omega.*Tdif*Ts*sqrt(1-zeta_f^2)) + ... 
	exp(-zeta_f*Omega.*Tdif*Ts).*cos(Omega.*Tdif*Ts*sqrt(1-zeta_f^2)).*(Omega.*sqrt(1-zeta_f^2)*Ts));
	
	Shdot = kron(ones(1,N),sum(h.*hdot,2));
	sdot = zeros(N);
	sdot(2:end,:) = (hdot(2:end,:) - h(2:end,:).*(Shdot(2:end,:)./Sh(2:end,:)))./sqrt(Sh(2:end,:));
end

% Simplified approach following equations in [1]
% =========================================================================
% for t = 1:N
%     % IRF filter
%     for tau = 1:t
%         h(t-tau+1,tau) = (omega_f(tau)/sqrt(1-zeta_f^2))*...
%             exp(-zeta_f*omega_f(tau)*(t-tau))*sin(omega_f(tau)*sqrt(1-zeta_f^2)*(t-tau));
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