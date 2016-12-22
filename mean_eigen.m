function mean_eigen
% Extract features from the mean weight matrix by Ncut.
% 2016-5-28 17:06:25

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

load parc_graymatter.mat;
load mean_weight.mat;

K0=1000;
delta=10; % for redundancy
[EV,EDD]=Ncut_eigen(W,K0+delta);  

nTrivial=sum(EDD<1e-4);  % the number of trivial eigenvalues
if nTrivial>delta
    error('Please increase the "delta" value and try again.');
end

EV=EV(:,end-nTrivial-K0+1:end-nTrivial);  % noly keep the nontrivial eigenvectors
EDD=EDD(end-nTrivial-K0+1:end-nTrivial);

time=toc/3600;
save('mean_eigen.mat','EV','EDD','nTrivial','time');
fprintf('Time to calculate eigenvectors: %0.2f hours. \n',time);
