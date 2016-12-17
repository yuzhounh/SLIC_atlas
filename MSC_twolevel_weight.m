function MSC_twolevel_weight(iK)
% Construct the two-level weight matrix for MSC. 
% 2016-5-28 17:04:38

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
load sSub.mat;
load parc_graymatter.mat;

cK=sK(iK);
nSub=length(sSub);
nM=num_gray;

tmp=sparse(1,nM*(nM-1)/2);
for iSub=1:nSub
    cSub=sSub(iSub);
    load(sprintf('MSC_sub_parc/sub%05d_K%d.mat',cSub,cK));
    temp=img_parc(msk_gray); % subject level parcellation
    temp=pdist(temp);
    temp=sparse(double(temp==0)); % adjacency matrix
    tmp=(tmp*(iSub-1)+temp)/iSub; % averged adjacency matrix
    
    perct(toc,iSub,nSub);
end
W=tmp;
W=squareform(W);
W=sparse(W);

% For empty rows, set the diagonal elements to be ones
[W,nEmpty]=parc_diag(W);

time=toc/3600;
save(sprintf('MSC_twolevel_weight/K%d.mat',cK),'W','nEmpty','time','-v7.3');
fprintf('Time to construct 2-level weight matrix: %0.2f hours. \n',time);