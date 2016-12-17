% The main script. 
% 2016-12-12 20:48:08

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

clear,clc,close all;

main_toolbox; % download the NIFTI toolbox and add it to path

% for preparation
main_subject; % the indices of the subjects
main_number; % the initialized cluster numbers
main_searchlight; % searchlight mask
main_graymatter; % graymatter mask
main_cavb; % the coordinates of the adjacent voxels

main_algorithm; % the parcellation algorithms
main_illustration; % draw illustrations