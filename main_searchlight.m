% Generate a 3*3*3 cubic searchlight mask. 
% 2016-12-13 21:28:09

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

r=1;
nvSL=(2*r+1)^3; % number of voxels in a searchlight
riSL=zeros(nvSL,3);

count=0; 
for i=-r:r
    for j=-r:r
        for k=-r:r
            count=count+1;
            riSL(count,:)=[i,j,k];
        end
    end
end

save('parc_searchlight.mat','riSL','nvSL');

% r=1;
% shape='cube';
% [riSL,nvSL]=parc_searchlight(r,shape);
% save('parc_searchlight.mat','riSL','nvSL');