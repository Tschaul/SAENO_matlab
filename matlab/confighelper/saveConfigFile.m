function saveConfigFile(cfg,fname)

fields=fieldnames(cfg);

myfile = fopen(fname ,'wt');

for i=1:numel(fields)
    
    fprintf(myfile, '%s = %s\n',char(fields(i)),cfg.(char(fields(i))));
end

fclose(myfile); 