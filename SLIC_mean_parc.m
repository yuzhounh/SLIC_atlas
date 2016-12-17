function SLIC_mean_parc(iK)
% Group level parcellation by mean SLIC.
% 2016-5-28 16:53:25

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
load mean_eigen.mat;

cK=sK(iK);

label=SLIC(EV,cK); % parcellation results
tmp=zeros(siz);
tmp(msk_gray)=label;
img_parc=tmp;
K=length(unique(label)); % actual cluster number

% save to .mat file
time=toc/3600;
save(sprintf('SLIC_mean_parc/K%d.mat',cK),'img_parc','K','time');
fprintf('Time to do parcellation: %0.2f hours. \n',time);

% save to .nii file
file_mask='graymatter.nii';
file_out=sprintf('SLIC_mean_parc/K%d.nii',cK);
parc_nii(file_mask,file_out,img_parc);