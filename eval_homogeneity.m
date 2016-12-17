function eval_homogeneity(method,iK,iPart,iRep)
% Functional homogeneity. 
% 2015-5-9 10:58:42

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
nM=num_gray;

load sK.mat;
cK=sK(iK);

load sSub.mat;
load(sprintf('randset_%d.mat',3-iPart)); % load the other part of subjects
sSub=sSub(randset(:,iRep));
nSub=length(sSub);

load(sprintf('%s_parc/K%d_part%d_rep%d.mat',method,cK,iPart,iRep));
img_parc=img_parc(msk_gray);
sC=unique(img_parc); % the label set of the clusters, should be [1:cK]
nC=length(sC);

homogeneity=zeros(nSub,1);
for iSub=1:nSub
    cSub=sSub(iSub);
    load(sprintf('prep/sub%05d.mat',cSub));
    
    % within cluster similarity
    a=zeros(nC,1);
    for iC=1:nC
        cC=sC(iC); % current cluster
        ix=find(img_parc==cC);
        nV=length(ix); % number of voxels in this cluster
        if nV~=1
            tmp=img_gray(ix,:)*img_gray(ix,:)';
            tmp=tmp-diag(diag(tmp)); % clear the diagonals
            tmp=sum(tmp(:))/(nV^2-nV); % don't count the diagonals
            a(iC)=tmp;
        end
    end
    a(a==0)=[]; % clear zeros
    homogeneity(iSub,1)=mean(a);
end
homogeneity=mean(homogeneity);

time=toc/3600;
fprintf('Time to calculate homogeneity: %0.2f hours. \n',time);
save(sprintf('%s_homogeneity/K%d_part%d_rep%d.mat',method,cK,iPart,iRep),'homogeneity','time');