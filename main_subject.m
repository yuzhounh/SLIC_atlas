% Save the indices of the subjects. 
% 2016-12-12 17:14:12

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

% the indices of the resting state fMRI
sFile=dir('data/sub*');
nSub=length(sFile);
sSub=zeros(nSub,1);
tic;
for iSub=1:nSub
    filename=sFile(iSub,1).name;
    cSub=str2num(filename(4:8));
    sSub(iSub,1)=cSub;
    perct(toc,iSub,nSub);
end
save('sSub.mat','sSub');