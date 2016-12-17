% Draw illustrations for different parcellation approaches and different
% cluster numbers. 
% 2015-9-4 11:31:16

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

clear,clc;

nii=load_untouch_nii('T1_4mm.nii');
img_bg=nii.img;

iK=200;
iPart=1;
iRep=1;

temp=[];
for method={'MSC_mean','MSC_twolevel','MKSC','SLIC_mean','SLIC_twolevel'}
    method=method{1,1};
    tmp=[];
    for cK=[50,200,1000]
        load(sprintf('%s_parc/K%d.mat',method,cK));
        img_parc=int16(img_parc);
        img_orth=parc_orthview(img_bg,img_parc,1);
        img_orth=double(img_orth/255);
        tmp=[tmp,img_orth];
    end
    temp=[temp;tmp];
end
figure;
imshow(temp);
imwrite(temp,'parc_illustration.tif', 'resolution',1200);