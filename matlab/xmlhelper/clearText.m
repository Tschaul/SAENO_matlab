function newStruct=clearText(theStruct)

j=1;

for i=1:numel(theStruct),

    if strcmp(theStruct(i).Name,'#text')==0

        newStruct(j)=theStruct(i);

        j=j+1;
        
    end

end
