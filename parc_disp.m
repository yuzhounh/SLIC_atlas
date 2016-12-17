function parc_disp(file,opt)
% Display fMRI data by averaging the fourth dimension
% Input:
%     file, fMRI data in .nii or .mat format.
%     opt, options (optional)
%          0, 2*2 style with default colormap (default);
%          1, 2*2 style with random colormap;
%          2, 1*3 style with default colormap;
%          3, 1*3 style with random colormap;
% 2015-1-11 20:47:37

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

if ischar(file)
    [~,~,ext]=fileparts(file);
    if strcmp(ext,'.nii')
        nii=load_untouch_nii(file);
        img=nii.img;
    elseif strcmp(ext,'.mat')
        load(file);
        img=img_parc;
    end
else
    img=file;
end

img=mean(img,4); % do average at the fourth dimension if exist
if nargin==2 && (opt==1 || opt==3) % assign random color to the image
    tmp=img(:);
    randset=randperm(max(tmp));
    image=zeros(size(img));
    for i=1:max(tmp)
        image(img==i)=randset(i);
    end
    img=image;
end
img=img/max(img(:));
[a,b,c]=size(img);

% add space between the imgs
d=2; % the space between imgs

% left up, y-plane
tmp=img(:,ceil(b/2),:);
tmp=reshape(tmp,[a,c]);
py=rot90(tmp);

% right up, x-plane
tmp=img(ceil(a/2),:,:);
tmp=reshape(tmp,[b,c]);
px=fliplr(rot90(tmp));

% left down, z-plane
tmp=img(:,:,ceil(c/2));
tmp=reshape(tmp,[a,b]);
pz=flipud(tmp');

if nargin<2 || opt==0 || opt==1
    img=ones(c+d+b,a+d+b);
    img(1:c,1:a)=py;
    img(1:c,a+1+d:a+b+d)=px;
    img(c+1+d:c+b+d,1:a)=pz;
elseif opt==2 || opt==3
    img=ones(b,2*a+2*d+b);
    img(1:b,1:a)=pz;
    img(ceil((b-c)/2)+1:ceil((b-c)/2)+c,a+d+1:a+d+a)=py;
    img(ceil((b-c)/2)+1:ceil((b-c)/2)+c,2*a+2*d+1:2*a+2*d+b)=px;
end
imshow(img);
% imshow(img,[],'border','tight');

cmp=colormap(jet(1000));
cmp=[0,0,0; cmp; 1,1,1];
colormap(gcf,cmp);