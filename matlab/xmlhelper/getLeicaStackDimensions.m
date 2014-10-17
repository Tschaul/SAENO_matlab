function [sx,sy,sz,st,dx,dy,dz]=getLeicaStackDimensions(fname)

newStruct = extractXMLElementFromFile(fname,'Dimensions');

newStruct.Children=clearText(newStruct.Children);

sxst=getFirstByName(newStruct.Children(1).Attributes,'NumberOfElements');
sx=str2num(sxst.Value);

syst=getFirstByName(newStruct.Children(2).Attributes,'NumberOfElements');
sy=str2num(syst.Value);

szst=getFirstByName(newStruct.Children(3).Attributes,'NumberOfElements');
sz=str2num(szst.Value);

dxst=getFirstByName(newStruct.Children(1).Attributes,'Length');
dxust=getFirstByName(newStruct.Children(1).Attributes,'Unit');
if strcmp(dxust.Value,'µm')
    dx=str2num(dxst.Value)/sx*1e-6;
else
    dx=str2num(dxst.Value)/sx;
end

dyst=getFirstByName(newStruct.Children(2).Attributes,'Length');
dyust=getFirstByName(newStruct.Children(2).Attributes,'Unit');
if strcmp(dyust.Value,'µm')
    dy=str2num(dyst.Value)/sy*1e-6;
else
    dy=str2num(dyst.Value)/sy;
end

dzst=getFirstByName(newStruct.Children(3).Attributes,'Length');
dzust=getFirstByName(newStruct.Children(3).Attributes,'Unit');
if strcmp(dzust.Value,'µm')
    dz=str2num(dzst.Value)/sz*1e-6;
else
    dz=str2num(dzst.Value)/sz;
end


if numel(newStruct.Children)>3

    stst=getFirstByName(newStruct.Children(4).Attributes,'NumberOfElements');
    st=str2num(stst.Value);

%     dtst=getFirstByName(newStruct.Children(4).Attributes,'Length');
%     dt=str2num(dtst.Value)/st;
    
else
    
    st=1;
%     dt=0;
    
end

end