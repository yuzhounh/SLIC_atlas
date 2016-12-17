% Randomly permutate the subjects and divide them into two equal groups. 
% This operation is repeated for nRep times. 
% 2016-12-12 20:51:32

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

% clear,clc,close all;

nSub=40;
nRep=20;

rng(1);
tmp=[];
for iRep=1:nRep
    tmp=[tmp;randperm(40)];
end
tmp=tmp';

randset=tmp(1:20,:);
save('randset_1.mat','randset');

randset=tmp(21:40,:);
save('randset_2.mat','randset');