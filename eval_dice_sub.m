function eval_dice_sub(method,iK,iRep)
% The group-to-subject reproducibility evaluated by Dice coefficient. 
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

nPart=2;
for iPart=1:nPart
    load(sprintf('%s_parc/K%d_part%d_rep%d.mat',method,cK,iPart,iRep));
    A=img_parc(msk_gray);
    A=pdist(A);
    A=A==0;
    A=sparse(double(A));
    
    load sSub.mat;
    load(sprintf('randset_%d.mat',3-iPart)); % load the other part of subjects
    sSub=sSub(randset(:,iRep));
    nSub=length(sSub);
    
    for iSub=1:nSub
        cSub=sSub(iSub);
        
        if ismember(method,{'MSC_mean','MSC_twolevel','MKSC'})
            load(sprintf('MSC_sub_parc/sub%05d_K%d.mat',cSub,cK));
        else
            load(sprintf('SLIC_sub_parc/sub%05d_K%d.mat',cSub,cK));
        end
        
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
        dice(iPart,iSub)=(2*SC)/(SA+SB);
    end
end

time=toc/3600;
fprintf('Time to calculate Dice coefficient: %0.2f hours. \n',time);
save(sprintf('%s_dice_sub/K%d_rep%d.mat',method,cK,iRep),'dice','time');