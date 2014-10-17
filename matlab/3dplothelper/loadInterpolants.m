function [Vx,Vy,Vz]=loadInterpolants(foldername,mode,s)

olddir=pwd;

cd(foldername);

if nargin < 3
    s = 0;
end

R=load('R.dat');

cfg=loadConfigFile('config.txt');

if strcmp(mode,'data')==1
    V=load('Ufound.dat');
elseif strcmp(mode,'fit')==1
    V=load('U.dat');
elseif strcmp(mode,'forces')==1
    if exist('Fden.dat','file')>0
        V=-load('Fden.dat');
    else
        V=-load('F.dat');
        grain=str2num(cfg.BM_GRAIN);
        V=V./grain.^3;
    end
else
    V=load('Ufound.dat');
    V=V-load('U.dat');
%     'noise'
end


if strcmp(mode,'data')
    S=load('Sfound.dat');
%     size(cfg.VB_MINMATCH)
%      cfg.VB_MINMATCH
    if(size(S,2)>1)
        active=(S(:,2)>str2double(cfg.VB_MINMATCH));
    else
        active=(S>str2double(cfg.VB_MINMATCH));
    end
else
    active=(max(abs(V),[],2)>0);
end

cd(olddir);

% va=reshape(active,[n n n]);
% 
% kera=ones(2*s+5,2*s+5,2*s+5);
% kera=kera/sum(kera(:));
% 
% va=imfilter(va,kera,'symmetric');
% 
% active=(va(:)==1);

if(s~=0)

%     s
    n=floor(size(V,1)^(1/3)+0.5);
    
    vx=reshape(V(:,1),[n n n]);
    vy=reshape(V(:,2),[n n n]);
    vz=reshape(V(:,3),[n n n]);
    

    [xk,yk,zk]=meshgrid(-s:s,-s:s,-s:s);
    rk=sqrt(xk.^2+yk.^2+zk.^2);
    ker=exp(-rk.^2/(s^2));
    ker=ker/sum(ker(:));

    vx=imfilter(vx,ker,'symmetric');
    vy=imfilter(vy,ker,'symmetric');
    vz=imfilter(vz,ker,'symmetric');
    
    V=[vx(:) vy(:) vz(:)];

end


V=V(active,:);
R=R(active,:);

Vx=TriScatteredInterp(R(:,1),R(:,2),R(:,3),V(:,1));
Vy=TriScatteredInterp(R(:,1),R(:,2),R(:,3),V(:,2));
Vz=TriScatteredInterp(R(:,1),R(:,2),R(:,3),V(:,3));

