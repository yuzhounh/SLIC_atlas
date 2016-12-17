% Load the eigenvectos and save them for MKSC. 
% 2016-5-28 17:07:50

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

nSub=length(sSub);

tic;
for iSub=1:nSub
    cSub=sSub(iSub);
    load(sprintf('sub_eigen/sub%05d.mat',cSub)); % feature matrix
    X(:,:,iSub)=EV;
    
    perct(toc,iSub,nSub);
end

save('eigvecs.mat','X','-v7.3');