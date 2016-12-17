function mean_weight
% Construct the mean weight matrix.
% 2016-5-28 17:10:08

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
load sSub.mat;
nM=num_gray;
nSub=length(sSub);

Wa=sparse(nM,nM); % averaged weight matrix
for iSub=1:nSub
    cSub=sSub(iSub);
    load(sprintf('sub_weight/sub%05d.mat',cSub));
    W=W-diag(diag(W)); % clear the diagonals
    Wa=(Wa*(iSub-1)+atanh(W))/iSub; % Fisher's Z-transformation
end
W=Wa;
W=tanh(W); % inverse Fisher's Z-transformation

% For empty rows, set the diagonal elements to be ones
[W,nEmpty]=parc_diag(W);

time=toc/3600;
save('mean_weight.mat','W','nEmpty','time','-v7.3');
fprintf('Time to construct group mean weight matrix: %0.2f hours. \n',time);