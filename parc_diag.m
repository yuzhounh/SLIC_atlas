function [W,nEmpty]=parc_diag(W)
% For empty rows, set the diagonal elements to be ones.
% 2015-11-6 22:19:42

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

tmp=W==0;
tmp=prod(tmp,2);
ix=find(tmp);
nEmpty=length(ix); % number of empty rows
for i=1:nEmpty
    W(ix(i),ix(i))=1;
end