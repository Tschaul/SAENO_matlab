function [VV,RR]=generateQuiver(Vx,Vy,Vz,N,viewrange)

rng(10)

X=rand(N,1)*2*viewrange-viewrange;
Y=rand(N,1)*2*viewrange-viewrange;
Z=rand(N,1)*2*viewrange-viewrange;

VX=Vx(X,Y,Z);
VY=Vy(X,Y,Z);
VZ=Vz(X,Y,Z);

VV=[VX VY VZ];
RR=[X Y Z];

if numel(VV)==0
    VV=0.*RR;
end
