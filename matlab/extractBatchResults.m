name='*_results';

folders=dir([ name ]);

nl=length(folders);

GETMAXDISPL=1;

if exist([ folders(1).name '/results.txt' ],'file')>0
    results=loadConfigFile( [ folders(1).name '/results.txt' ] );
else 
    results=loadConfigFile( [ folders(1).name '/t000/results.txt' ] );
end

snames=fieldnames(results); 

resultsall=struct();
D={};

for loopIndex = 1:numel(snames) 
    
    resultsall.(snames{loopIndex})=zeros(nl,1);
    resultsall.(snames{loopIndex})(1)=str2double(results.(snames{loopIndex}));
    D{1,loopIndex+1}=snames{loopIndex};
    D{2,loopIndex+1}=results.(snames{loopIndex});
    
end

if GETMAXDISPL
    
    resultsall.MAXDISLP=zeros(nl,1);
    D{1,loopIndex+1}='MAXDISPL';
    
end

vmeans=[];
countmeans=0;

call=2;

for i=1:nl
    
    disp(folders(i).name)
    
    if exist([ folders(i).name '/results.txt' ],'file')>0
    
        results=loadConfigFile( [ folders(i).name '/results.txt' ] );

        if isfield(results, 'ERROR') && numel(results.ERROR)==0
            countmeans=countmeans+1;
            vmeans=[vmeans;zeros(1,numel(snames)+GETMAXDISPL)];
            
            if GETMAXDISPL
                Uf=load([ folders(i).name '/U.dat' ]);
                Uf=sqrt(sum(Uf.^2,2));
                Uf=max(Uf);
                
                D{call,numel(snames)+2}=Uf;
                vmeans(countmeans,end)=Uf;
                resultsall.MAXDISPL(call)=Uf;
                
            end
            
        end
        
        D{call,1}=folders(i).name;
        
        for loopIndex = 1:numel(snames) 
            if isfield(results, snames{loopIndex})
                resultsall.(snames{loopIndex})(call)=str2double(results.(snames{loopIndex}));
                if ~isnan(str2double(results.(snames{loopIndex})))
                    D{call,loopIndex+1}=str2double(results.(snames{loopIndex}));
                else
                    D{call,loopIndex+1}=results.(snames{loopIndex});
                end
                
                if isfield(results, 'ERROR') && numel(results.ERROR)==0 && numel(results.(snames{loopIndex}))~=0
                    vmeans(countmeans,loopIndex)=vmeans(countmeans,loopIndex)+str2num(results.(snames{loopIndex}));
                end
            end
        end
        
        call=call+1;
        
    elseif exist([ folders(i).name '/t000/results.txt' ],'file')>0
        
        t=0;
        
        while exist([ folders(i).name '/t' sprintf('%03d',t) '/results.txt' ],'file')>0
            
            results=loadConfigFile( [ folders(i).name '/t' sprintf('%03d',t) '/results.txt' ] );

            if isfield(results, 'ERROR') && numel(results.ERROR)==0
                countmeans=countmeans+1;
                vmeans=[vmeans;zeros(1,numel(snames))];
            end

            D{call,1}=[ folders(i).name '_t' sprintf('%03d',t) ];

            for loopIndex = 1:numel(snames) 
                if isfield(results, snames{loopIndex})
                    resultsall.(snames{loopIndex})(call)=str2double(results.(snames{loopIndex}));
                    if ~isnan(str2double(results.(snames{loopIndex})))
                        D{call,loopIndex+1}=str2double(results.(snames{loopIndex}));
                    else
                        D{call,loopIndex+1}=results.(snames{loopIndex});
                    end
                    if isfield(results, 'ERROR') && numel(results.ERROR)==0 && numel(results.(snames{loopIndex}))~=0
                        vmeans(countmeans,loopIndex)=vmeans(countmeans,loopIndex)+str2num(results.(snames{loopIndex}));
                    end
                end
            end
        
            call=call+1;
            
            t=t+1;
            
        end
        
    end
    
end

means=mean(vmeans,1);
stderr=std(vmeans,1)/sqrt(size(vmeans,1));

for loopIndex = 1:numel(snames) 
    D{call+2,loopIndex+1}=means(loopIndex);
    D{call+3,loopIndex+1}=stderr(loopIndex);
    resultsall.(['MEAN_' snames{loopIndex}])=means(loopIndex);
    resultsall.(['STDERR_' snames{loopIndex}])=stderr(loopIndex);
end
    
if GETMAXDISPL
   
    D{call+2,numel(snames)+2}=means(numel(snames)+1);
    D{call+3,numel(snames)+2}=stderr(numel(snames)+1);
    resultsall.(['MEAN_MAXDISPL'])=means(numel(snames)+1);
    resultsall.(['STDERR_MAXDISPL'])=stderr(numel(snames)+1);
    
end

save('resultsall.mat','resultsall');
xlswrite('resultsall.xls',D);