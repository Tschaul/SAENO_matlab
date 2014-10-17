function newStruct=getFirstByName(theStruct,name)

for i=1:numel(theStruct),

    if strcmp(theStruct(i).Name,name)==1

        newStruct=theStruct(i);
        return;

    end

end

newStruct=struct();