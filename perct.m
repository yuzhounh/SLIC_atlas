function perct(t,i,n,k)
%PERCT The program procedure.
% PERCT(T,I,N,K) shows the program procedure and remaining time for loops. 
% Only K countdowns will be displayed. When the program is completed,
% output the total elapsed time with scale .0000 hours. 
% 
% t, time elapsed (seconds) recorded by "tic" and "toc"
% i, the number of loops that are completed
% n, the total number of loops
% k, the number of countdowns to be dispalyed, optional
%
% Example:
%     k=10;
%     tic;
%     for i=1:n
%         ...
%         perct(toc,i,n,k);
%     end
%
% Tips:
% 1, you might save the elapsed time by "time=toc/3600" after all loops
%   are completed.
% 2, "clc" before calling this function if you only want to see the current
%   countdown. 

% Jing Wang
% 2014-12-23

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

% If k exists, output k countdowns; else, output n countdowns. 
if nargin==3 || ( nargin==4 && ismember(i,ceil(n*[1:k]/k)) )
    % percentage
    fprintf('The program has run: %0.2f%%.\n', i*100/n);
    
    % time remaining
    tm=t*(n-i)/i;
    
    % time scale: h, m, s
    if tm>60*60
        h=floor(tm/(60*60));
        m=floor(tm/60-h*60);
        fprintf('Remaining time: %d hours %d minutes.',h,m);
    elseif tm>60
        m=floor(tm/60);
        s=floor(tm-m*60);
        fprintf('Remaining time: %d minutes %d seconds.',m,s);
    elseif tm>0
        s=floor(tm);
        fprintf('Remaining time: %d seconds.',s);
    else % tm=0
        h=t/(60*60);
        fprintf('Total time elapsed: %0.4f hours.',h);
    end
    fprintf('\n\n');
end