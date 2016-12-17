% Five parcellation approaches. 
% 2015-6-16 08:29:24

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

% clear,clc;

addpath('NIfTI_20140122/');

mkdir('sub_weight');
mkdir('sub_eigen');

mkdir('MSC_sub_parc');
mkdir('SLIC_sub_parc');

mkdir('MSC_mean_parc');
mkdir('MSC_twolevel_weight');
mkdir('MSC_twolevel_eigen');
mkdir('MSC_twolevel_parc');

mkdir('MKSC_parc');

mkdir('SLIC_mean_parc');
mkdir('SLIC_twolevel_weight');
mkdir('SLIC_twolevel_eigen');
mkdir('SLIC_twolevel_parc');

load sSub.mat;
load sK.mat;

nSub=length(sSub);
nK=length(sK);

% preprocess
mkdir('prep');
parc_parpool(20);
parfor iSub=1:nSub
    parc_normalize(iSub);
end

% sub_weight, sub_eigen
stat=[];
for iSub=1:nSub
    cSub=sSub(iSub);
    if ~exist(sprintf('sub_eigen/sub%05d.mat',cSub))
        stat=[stat;iSub];
    end
end
n=size(stat,1);
fprintf('The number of tasks: %d. \n',n);
parc_parpool(20);
parfor iSub=1:nSub
    opt=1;
    sub_weight(iSub,opt);
    sub_eigen(iSub);
end

% sub_parc
stat=[];
for iSub=1:nSub
    cSub=sSub(iSub);
    for iK=1:nK
        cK=sK(iK);
        if ~exist(sprintf('SLIC_sub_parc/sub%05d_K%d.mat',cSub,cK))
            stat=[stat;iSub,iK];
        end
    end
end
n=size(stat,1);
fprintf('The number of tasks: %d. \n',n);
parc_parpool(20);
parfor i=1:n
    iSub=stat(i,1);
    iK=stat(i,2);
    MSC_sub_parc(iSub,iK);
    SLIC_sub_parc(iSub,iK);
end

delete(gcp('nocreate'));
mean_weight;
mean_eigen;

parc_parpool(2);
parfor iK=1:nK
    MKSC_parc(iK);
end

parc_parpool(20);
parfor iK=1:nK
    MSC_mean_parc(iK);
    MSC_twolevel_weight(iK);
    MSC_twolevel_eigen(iK);
    MSC_twolevel_parc(iK);

    SLIC_mean_parc(iK);
    SLIC_twolevel_weight(iK);
    SLIC_twolevel_eigen(iK);
    SLIC_twolevel_parc(iK);
end


