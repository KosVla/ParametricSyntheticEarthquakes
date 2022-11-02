%% Save earthquake accelerograms in one file
%Routine to read each accelegogram from the PEER earthquake database and
%store all data properly for further modification
%
%GNU General Public License v3.0
%Please cite as:
% Spiridonakos, Minas & Chatzi, Eleni. (2015). 
% Metamodeling of nonlinear structural systems with parametric uncertainty 
% subject to stochastic dynamic excitation. 
% Earthquakes and Structures. 8. 915-934. 10.12989/eas.2015.8.4.915.

local_dir = [pwd,'\'];

cd([local_dir,'PEERexamples'])
listing = ls('*.AT2');

p = 0;
for j = 1:size(listing,1)
    if isempty(strfind(listing(j,:),'DWN')) && isempty(strfind(listing(j,:),'UP'))
        A = importdata(listing(j,:),' ',4);
        A.data = A.data';
        % if length(A.data(:)) < 10000
            p = p+1;
            N(p) = length(A.data(:));
            EQ{p} = A.data(:);
            if isfield(A,'colheaders')
                disp('Y')
                DT(p) = str2double(A.colheaders{4});
            else
                k = strfind(A.textdata{4},' ');
                NoS(p) = str2double(A.textdata{4}(1:k(1)-1));
                q = 1;
                while (k(2)-k(1))==1,k = k(2:end);end
                DT(p) = str2double(A.textdata{4}(k(1)+1:k(2)));
            end
        % end
    end
end
clear A j
save('PEER_ALL','EQ','N','DT');
cd(local_dir)