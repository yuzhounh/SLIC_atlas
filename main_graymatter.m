% Save some useful information of the graymatter mask.  
% 2016-12-13 21:27:33

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

file_mask='graymatter.nii';

nii=load_untouch_nii(file_mask);
img_gray=double(nii.img);
msk_gray=img_gray~=0;
ind_gray=find(msk_gray);
num_gray=length(ind_gray);
siz=size(msk_gray);

save('parc_graymatter.mat','msk_gray','ind_gray','num_gray','siz');