function SLIC_twolevel_eigen(iK)
% Extract features from the two-level weight matrix by Ncut.
% 2016-5-28 16:51:09

%     SLIC: a whole brain parcellation toolbox
%     Copyright (C) 2016 Jing Wang
%
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
%
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

tic;

load sK.mat;
cK=sK(iK);

load(sprintf('SLIC_twolevel_weight/K%d.mat',cK));
delta=30; % for redundancy
[EV,EDD]=Ncut_eigen(W,cK+delta);  

nTrivial=sum(EDD<1e-4);  % the number of trivial eigenvalues
if nTrivial>delta
    error('Please increase the "delta" value and try again.');
end

EV=EV(:,end-nTrivial-cK+1:end-nTrivial);  % noly keep the nontrivial eigenvectors
EDD=EDD(end-nTrivial-cK+1:end-nTrivial);

time=toc/3600;
save(sprintf('SLIC_twolevel_eigen/K%d.mat',cK),'EV','EDD','nTrivial','time');
fprintf('Time to calculate eigenvectors: %0.2f hours. \n',time);
