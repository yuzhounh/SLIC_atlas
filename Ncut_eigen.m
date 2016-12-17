function [EV,EDD]=Ncut_eigen(W,K)
% Ncut solved by eigen-decomposition. 
% 2016-5-28 17:03:35

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

D=diag(sum(W));
E=diag(sparse(1./sqrt(diag(D)))); % D^(-1/2)
[EV,ED]=eigs(E*(D-W)*E+10*eps*speye(size(W)),K,'SM'); % add a small regularization to the normalized graph Laplacian matrix
EDD=diag(ED);
[EDD,ix]=sort(EDD,'descend'); % sort the eigenvalues and eigenvectors in order
EV=EV(:,ix);
EV=E*EV; % y=D^(-1/2)*z
EV=EV./repmat(sqrt(sum(EV.^2,1)),[size(EV,1),1]); % normalized each column to be unit length