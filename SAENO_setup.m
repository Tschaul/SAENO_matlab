
dirh=mfilename('fullpath');
dirh=dirh(1:end-12);

load([dirh '/setup.mat']);

prompt = {'Full path to binary:','Default number of processes:','Flags for start command'};
dlg_title = 'Input';
num_lines = 1;
def = {binary,num2str(defaultprocs),startflags};
answer = inputdlg(prompt,dlg_title,num_lines,def);

if numel(answer)>0
    binary=answer{1};
    defaultprocs=str2num(answer{2});
    startflags=answer{3};

    save([dirh '/setup.mat'],'binary','defaultprocs','startflags')
end