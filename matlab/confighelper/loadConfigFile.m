function cfg=loadConfigFile(fname),

cfg=struct();

fid = fopen(fname);

tline = fgetl(fid);

while ischar(tline)
        
    if numel(tline)>0
        
        if tline(1)=='#'
            tline = fgetl(fid);
            continue
        end

        k = strfind(tline, '=');
    
    
        if strcmp(tline(k+1),' ')==1

            value=tline((k+2):end);

        else

            value=tline((k+1):end);

        end

%         kk = strfind(value, ' ')
        
%         if kk~=[]
%             
%             value=value(1:(k-1));
%             
%         end
        
        if strcmp(tline(k-1),' ')==1

            key=tline(1:(k-2));

        else

            key=tline(1:(k-1));

        end

        cfg.(key)=value;
        
    end
    
    tline = fgetl(fid);
    
end

fclose(fid);

return