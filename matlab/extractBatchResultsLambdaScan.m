name='*1*e*';

folders=dir([ name ]);

nl=length(folders);

if exist([ folders(1).name '/results.txt' ],'file')>0
    results=loadConfigFile( [ folders(1).name '/results.txt' ] );
else
    results=loadConfigFile( [ folders(2).name '/results.txt' ] );
end
snames=fieldnames(results); 

resultsall=struct();
D={};

resultsall.LAMBDA=zeros(nl,1);

for loopIndex = 1:numel(snames) 
    
    resultsall.(snames{loopIndex})=zeros(nl,1);
    resultsall.(snames{loopIndex})(1)=str2double(results.(snames{loopIndex}));
    D{1,loopIndex+1}=snames{loopIndex};
    D{2,loopIndex+1}=results.(snames{loopIndex});
    
end

vmeans=[];
countmeans=0;

for i=1:nl
    
    disp(folders(i).name)
    
    if exist([ folders(i).name '/results.txt' ],'file')>0
    
        results=loadConfigFile( [ folders(i).name '/results.txt' ] );
        
        resultsall.LAMBDA(i)=str2num(folders(i).name);

        if isfield(results, 'ERROR') && numel(results.ERROR)==0
            countmeans=countmeans+1;
            vmeans=[vmeans;zeros(1,numel(snames))];
        end
        
        D{i+1,1}=folders(i).name;
        
        for loopIndex = 1:numel(snames) 
            if isfield(results, snames{loopIndex})
                resultsall.(snames{loopIndex})(i)=str2double(results.(snames{loopIndex}));
                D{i+1,loopIndex+1}=results.(snames{loopIndex});
                if isfield(results, 'ERROR') && numel(results.ERROR)==0 && numel(results.(snames{loopIndex}))~=0
                    vmeans(countmeans,loopIndex)=vmeans(countmeans,loopIndex)+str2num(results.(snames{loopIndex}));
                end
            end
        end
        
    end
    
end

means=mean(vmeans,1);
stderr=std(vmeans,1)/sqrt(size(vmeans,1));

for loopIndex = 1:numel(snames) 
    D{nl+2,loopIndex+1}=means(loopIndex);
    D{nl+3,loopIndex+1}=stderr(loopIndex);
    resultsall.(['MEAN_' snames{loopIndex}])=means(loopIndex);
    resultsall.(['STDERR_' snames{loopIndex}])=stderr(loopIndex);
end
    
save('resultsall.mat','resultsall');
xlswrite('resultsall.xls',D);