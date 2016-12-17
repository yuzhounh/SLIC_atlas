function MSC_sub_parc(iSub,iK)
% Individual subject level parcellation by MSC.
% 2016-5-28 17:06:53

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
cSub=sSub(iSub);

load(sprintf('sub_eigen/sub%05d.mat',cSub));

label=Ncut_kway(EV,cK);
tmp=zeros(siz);
tmp(msk_gray)=label;
img_parc=tmp;
K=length(unique(label)); % actual cluster number

% save to .mat file
time=toc/3600;
save(sprintf('MSC_sub_parc/sub%05d_K%d.mat',cSub,cK),'img_parc','K','time');
fprintf('Time to do parcellation: %0.2f hours. \n',time);

% save to .nii file
file_mask='graymatter.nii';
file_out=sprintf('MSC_sub_parc/sub%05d_K%d.nii',cSub,cK);
parc_nii(file_mask,file_out,img_parc);