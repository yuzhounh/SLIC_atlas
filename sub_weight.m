function sub_weight(iSub,opt)
% Construct the individual subject level weight matrix. Six different 
% kinds of weight matrices are defined with different weighting functions
% (correlation or Gaussian) and different sparsifying schemes (spaital
% constraint, the k largest values in each row and each column, global
% threshold). 
% 2015-11-6 15:17:03

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

load parc_cavb.mat;
nM=size(cavb,1);
N=sum(cavb(:))-nM; % number of nonzero elements in the weight matrix

k=17; % for opt=3 or 4, keep the largest k values in each row and column

load sSub.mat;
cSub=sSub(iSub);
load(sprintf('prep/sub%05d.mat',cSub)); % the preprocessed imaging data

R=img_gray*img_gray'; % cross-correlation
Rd=median(R(:)); % median of all correlation values
G=exp(-(1-R)/(1-Rd)); % weight by a Gaussian kernel

% clear the diagonals
R=R-diag(diag(R));
G=G-diag(diag(G));

if opt==1
    % 1, correlation with spatial constraint, no threshold
    W=R;
    W=sparse(W.*cavb);
elseif opt==2
    % 2, Gaussian with spatial constraint
    W=G;
    W=sparse(W.*cavb);
elseif opt==3
    % 3, correlation, the k largest values in each row and each column
    W=R;
    flag=zeros(nM);
    for i=1:nM
        w=W(i,:);
        [~,idx]=sort(w,'descend'); % sort each row
        flag(i,idx(1:k))=1;
    end
    for i=1:nM
        w=W(:,i);
        [~,idx]=sort(w,'descend'); % sort each row
        flag(idx(1:k),i)=1;
    end
    W=sparse(W.*flag);
elseif opt==4
    % 4, Gaussian, the k largest values in each row and each column
    W=G;
    flag=zeros(nM);
    for i=1:nM
        w=W(i,:);
        [~,idx]=sort(w,'descend'); % sort each row
        flag(i,idx(1:k))=1;
    end
    for i=1:nM
        w=W(:,i);
        [~,idx]=sort(w,'descend'); % sort each row
        flag(idx(1:k),i)=1;
    end
    W=sparse(W.*flag);
elseif opt==5
    % 5, correlation, threshold
    W=R;
    tmp=sort(W(:),'descend');
    threshold=tmp(N);
    W=W.*(W>=threshold);
    W=sparse(W);
elseif opt==6
    % 6, Gaussian, threshold
    W=G;
    tmp=sort(W(:),'descend');
    threshold=tmp(N);
    W=W.*(W>=threshold);
    W=sparse(W);
end

% Ratio of the number of nonzero elements in the weight matrix to the
% number of connected edges in the spatial constraint
ratio=sum(W(:)~=0)/N;

% For empty rows, set the diagonal elements to be ones
[W,nEmpty]=parc_diag(W);

time=toc/3600;
save(sprintf('sub_weight/sub%05d.mat',cSub),'W','ratio','nEmpty','time','-v7.3');
fprintf('Time to construct weight matrix: %0.2f hours. \n',time);