function img_parc=parc_distinct(img_parc)
% Make regions distinct and then renumber. Zero for background and 
% positive integers for clusters in img. 
% 2014-10-25 21:38:24

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

sLabel=unique(img_parc);
nLabel=length(sLabel);
maxLabel=max(sLabel);
for iLabel=2:nLabel % consider labels other than 0
    % binary image with the current label
    cLabel=sLabel(iLabel);
    bw=img_parc==cLabel;
    
    % count the number of clusters with the current label and assign a
    % label to each cluster
    conn=26; % 26 connectivity
    [L,NUM]=bwlabeln(bw,conn);
    nCluster=NUM;
    label_map=L;
    if nCluster>1
        for iCluster=2:nCluster
            maxLabel=maxLabel+1;
            ix=label_map==iCluster;
            img_parc(ix)=maxLabel;
        end
    end
end

% renumber regions
img_tmp=img_parc;
sLabel=unique(img_parc);
nLabel=length(sLabel);
for iLabel=2:nLabel % consider labels other than 0
    cLabel=sLabel(iLabel);
    img_tmp(img_parc==cLabel)=iLabel-1;
end
img_parc=img_tmp;