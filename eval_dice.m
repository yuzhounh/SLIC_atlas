function eval_dice(method,iK,iRep)
% The group-to-group reproducibility evaluated by Dice coefficient. 
% 2015-5-9 10:57:07

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

load parc_graymatter.mat;
nM=num_gray;

load sK.mat;
cK=sK(iK);

iPart=1;
load(sprintf('%s_parc/K%d_part%d_rep%d.mat',method,cK,iPart,iRep));
A=img_parc(msk_gray);
A=pdist(A);
A=A==0;
A=sparse(double(A));

iPart=2;
load(sprintf('%s_parc/K%d_part%d_rep%d.mat',method,cK,iPart,iRep));
B=img_parc(msk_gray);
B=pdist(B);
B=B==0;
B=sparse(double(B));

% union
C=A.*B;

% sum
SA=sum(A(:));
SB=sum(B(:));
SC=sum(C(:));

% Dice's coefficient
dice=(2*SC)/(SA+SB);

time=toc/3600;
fprintf('Time to calculate Dice coefficient: %0.2f hours. \n',time);
save(sprintf('%s_dice/K%d_rep%d.mat',method,cK,iRep),'dice','time');