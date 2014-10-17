function varargout = SAENO_batchfrecon(varargin)
% SAENO_BATCHFRECON MATLAB code for SAENO_batchfrecon.fig
%      SAENO_BATCHFRECON, by itself, creates a new SAENO_BATCHFRECON or raises the existing
%      singleton*.
%
%      H = SAENO_BATCHFRECON returns the handle to a new SAENO_BATCHFRECON or the handle to
%      the existing singleton*.
%
%      SAENO_BATCHFRECON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAENO_BATCHFRECON.M with the given input arguments.
%
%      SAENO_BATCHFRECON('Property','Value',...) creates a new SAENO_BATCHFRECON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAENO_batchfrecon_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAENO_batchfrecon_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAENO_batchfrecon

% Last Modified by GUIDE v2.5 03-Jul-2014 11:16:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAENO_batchfrecon_OpeningFcn, ...
                   'gui_OutputFcn',  @SAENO_batchfrecon_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before SAENO_batchfrecon is made visible.
function SAENO_batchfrecon_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAENO_batchfrecon (see VARARGIN)

% Choose default command line output for SAENO_batchfrecon
handles.output = hObject;

handles.dirh=mfilename('fullpath');
handles.dirh=handles.dirh(1:end-17);

temp=load([handles.dirh '/setup.mat']);
handles.binary=temp.binary;
handles.defaultprocs=temp.defaultprocs;
handles.startflags=temp.startflags;

set(handles.processes,'String',num2str(handles.defaultprocs));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAENO_batchfrecon wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAENO_batchfrecon_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in selectdirectory.
function selectdirectory_Callback(hObject, eventdata, handles)
% hObject    handle to selectdirectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

newdata={};

folder_name = uigetdir;

handles.selecteddirectory=folder_name;

set(handles.currentdirectory,'String',['Current Directory: ' folder_name]);

dlist=dir([folder_name '/*_alive']);

for i=1:numel(dlist)
    
    if dlist(i).isdir
        
        cellname=dlist(i).name(1:end-6);
        
        xmllist=dir([folder_name '/' dlist(i).name '/*_Properties.xml']);
        
        if(numel(xmllist)~=0)
        
            xmlname=[folder_name '/' dlist(i).name '/' xmllist(1).name];

            [sx,sy,sz,st,dx,dy,dz]=getLeicaStackDimensions(xmlname);

            newdata{i,1}=cellname;

            if sz<11
                zstring='_z%%01d';
            elseif sz<101
                zstring='_z%%02d';
            elseif sz<1001
                zstring='_z%%03d';
            else
                zstring='_z%%04d';
            end

            if st==1
                tstring='';
            elseif st<11
                tstring='_t%01d';
            elseif st<101
                tstring='_t%02d';
            elseif st<1001
                tstring='_t%03d';
            end

            newdata{i,3}=[xmllist(1).name(1:end-15) tstring zstring '_ch00.tif'];

            xmllist=dir([folder_name '/' cellname '_relaxed/*_Properties.xml']);

            newdata{i,4}=[xmllist(1).name(1:end-15) zstring '_ch00.tif'];

            newdata{i,5}='1';
            
            newdata{i,6}=0;
            newdata{i,7}=sz-1;

            newdata{i,8}=dx;
            newdata{i,9}=dz;

            newdata{i,10}=0;

            if st==1
                
                newdata{i,11}=0;
                
            else
                
                newdata{i,11}=st-1;
                
            end
            
        else

            newdata{i,1}=cellname;

            st=0;
            
            while(exist([ folder_name '/' cellname '_alive/' sprintf('t%03d/',st) ])==7) st=st+1; end
                  
            if st==0
                tstring='';
                st=1;
            else
                tstring='t%03d/';
            end

            newdata{i,3}=[ tstring ];

            newdata{i,4}='';

            newdata{i,5}='0';

            newdata{i,6}='';
            newdata{i,7}='';

            newdata{i,8}='';
            newdata{i,9}='';

            newdata{i,10}=0;
            
            newdata{i,11}=st-1;
                
            
        end
        
    end
    
end

set(handles.cellstable,'Data',newdata);

guidata(hObject,handles);



function processes_Callback(hObject, eventdata, handles)
% hObject    handle to processes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of processes as text
%        str2double(get(hObject,'String')) returns contents of processes as a double


% --- Executes during object creation, after setting all properties.
function processes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to processes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%handles.tempfoldername=generateTempfolder();

data=get(handles.cellstable,'Data');

s=size(data);

for i=1:s(1)
    
    mkdir([ handles.selecteddirectory '/' data{i,1} '_results/' ]);
    
end

flist=dir('battemp/*');

for i=1:numel(flist)
    
    if strcmp(flist(i).name,'.')==0 && strcmp(flist(i).name,'..')==0
       
        delete(['battemp/' flist(i).name]);
        
    end
    
end

commands=getCommand(handles);

proc=str2num(get(handles.processes,'String'));

cleanUpBattemp([handles.dirh '/battemp/']);

tempdirname=gererateTempfoldername();

mkdir([handles.dirh '/battemp/' tempdirname]);

for j=1:proc
    
    fname=[ handles.dirh '/battemp/' tempdirname '/temp' sprintf('%03d',j) '.bat' ];
    
    fid=fopen(fname,'w');
    
    ss=size(commands{j});
    
    for i=1:ss(1)
        
        fprintf(fid, '%s\n',strrep(char(commands{j}(i,:)),'%','%%') );
        
    end
    
    fclose(fid);
    
    system( [ 'start ' handles.startflags ' ' fname ]);
    
end

function commands=getCommand(handles)

data=get(handles.cellstable,'Data');

s=size(data);

commands={};

proc=str2num(get(handles.processes,'String'));

for j=1:proc
    
    commands{j}=[];
    
end
    
j=0;
    
regonly=get(handles.regonly,'Value');

for i=1:s(1),
    
    for t=data{i,10}:data{i,11}
    
        st=data{i,11}-data{i,10}+1;
        
        if st==1
            tstring='';
        else
            tstring='t%03d/';
        end
        
        if regonly
            
            cmd=[handles.binary ...
                ' CONFIG ' data{i,2} ...
                ' STACKA ' handles.selecteddirectory '/' data{i,1} '_alive/' sprintf(data{i,3},t) ...
                ' STACKR ' handles.selecteddirectory '/' data{i,1} '_relaxed/' sprintf(data{i,4}) ...
                ' DATAOUT ' handles.selecteddirectory '/' data{i,1} '_results/' sprintf(tstring,t) ...
                ' DATAIN ' handles.selecteddirectory '/' data{i,1} '_results/' sprintf(tstring,t) ...
                ' FIBERPATTERNMATCHING 0'  ...
                ' ' get(handles.addparams,'String') ];
            
            if strcmp(data{i,8},'')==0
                cmd=[cmd ...
                ' VOXELSIZEX ' num2str(data{i,8})  ...
                ' VOXELSIZEY ' num2str(data{i,8})  ...
                    ];
            end
            
            if strcmp(data{i,9},'')==0
                cmd=[cmd ...
                ' VOXELSIZEZ ' num2str(data{i,9})  ...
                    ];
            end
            
            if str2num(data{i,5})~=0
                cmd=[cmd ...
                ' ZFROM ' num2str(data{i,6})  ...
                ' ZTO ' num2str(data{i,7})  ...
                ' USESPRINTF ' num2str(data{i,5})  ...
                    ];
                
            else
                cmd=[cmd ...
                ' USESPRINTF ' num2str(data{i,5})  ...
                    ];
            end
            
            commands{j+1}=[commands{j+1}; cmd];
            
            
        else
        
%             disp(commands{j+1})
            cmd=[handles.binary ...
                ' CONFIG ' data{i,2} ...
                ' STACKA ' handles.selecteddirectory '/' data{i,1} '_alive/' sprintf(data{i,3},t) ...
                ' STACKR ' handles.selecteddirectory '/' data{i,1} '_relaxed/' sprintf(data{i,4}) ...
                ' DATAOUT ' handles.selecteddirectory '/' data{i,1} '_results/' sprintf(tstring,t) ...
                ' ' get(handles.addparams,'String') ];
            
            if strcmp(data{i,8},'')==0
                cmd=[cmd ...
                ' VOXELSIZEX ' num2str(data{i,8})  ...
                ' VOXELSIZEY ' num2str(data{i,8})  ...
                    ];
            end
            
            if strcmp(data{i,9},'')==0
                cmd=[cmd ...
                ' VOXELSIZEZ ' num2str(data{i,9})  ...
                    ];
            end
            
            if str2num(data{i,5})~=0
                cmd=[cmd ...
                ' ZFROM ' num2str(data{i,6})  ...
                ' ZTO ' num2str(data{i,7})  ...
                ' USESPRINTF ' num2str(data{i,5})  ...
                    ];
                
            else
                cmd=[cmd ...
                ' USESPRINTF ' num2str(data{i,5})  ...
                    ];
            end
            
            commands{j+1}=[commands{j+1}; cmd];
            
        end
        
        j=j+1;
        j=mod(j,proc);
    
    end
    
end

function fname=gererateTempfoldername()
s = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

%find number of random characters to choose from
numRands = length(s); 

%specify length of random string to generate
sLength = 10;

randstr=s( round(rand(1,sLength)*numRands) );

timestamp=getUnixtime();

fname=[timestamp '_' randstr];

function timestamp=getUnixtime()

NumDays = daysact('01-Jan-1970', datestr(now,1));
NumHours = str2num(datestr(now,'HH'));
NumMins = str2num(datestr(now,'MM'));
NumSecs = str2num(datestr(now,'SS'));

java.util.Date(); % The date string display

deltaH=ans.getTimezoneOffset()/60; % the timezone offset from UTC

timestamp=num2str( ( ( NumDays*24 + NumHours + deltaH )*60 + NumMins )*60 + NumSecs  );


% --- Executes on button press in regonly.
function regonly_Callback(hObject, eventdata, handles)
% hObject    handle to regonly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of regonly



function addparams_Callback(hObject, eventdata, handles)
% hObject    handle to addparams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of addparams as text
%        str2double(get(hObject,'String')) returns contents of addparams as a double


% --- Executes during object creation, after setting all properties.
function addparams_CreateFcn(hObject, eventdata, handles)
% hObject    handle to addparams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cleanUpBattemp(battempdir)

fdlist=dir(battempdir);

for i=1:length(fdlist),

    if ~strcmp(fdlist(i).name,'.') && ~strcmp(fdlist(i).name,'..')

        timestr=regexp(fdlist(i).name,'_','split');
        timed=str2num(timestr{1});
%         timen=str2num(getUnixtime());
        timen=str2num('1384266901');
        
        
        if (timen-timed)>26784000
            rmdir([ battempdir '/' fdlist(i).name])
        end

    end
end
    
    
    


% --- Executes on button press in setvoxelsizexy.
function setvoxelsizexy_Callback(hObject, eventdata, handles)
% hObject    handle to setvoxelsizexy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=get(handles.cellstable,'Data');

s=size(data);

voxelsizez = inputdlg('Please specify the horizontal (x and y) voxel size. Unit is meters. For a voxel size of 0.72µm put in 0.72e-6','Input', [1 50]);
voxelsizez=voxelsizez{1};

for i=1:s
    data{i,8}=voxelsizez;
end

set(handles.cellstable,'Data',data);

guidata(hObject,handles);

% --- Executes on button press in setvoxelsizez.
function setvoxelsizez_Callback(hObject, eventdata, handles)
% hObject    handle to setvoxelsizez (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=get(handles.cellstable,'Data');

s=size(data);

voxelsizexy = inputdlg('Please specify the horizontal (x and y) voxel size. Unit is meters. For a voxel size of 0.72µm put in 0.72e-6','Input', [1 50]);
voxelsizexy=voxelsizexy{1};

for i=1:s
    data{i,9}=voxelsizexy;
end

set(handles.cellstable,'Data',data);

guidata(hObject,handles);

% --- Executes on button press in rechoseconfig.
function rechoseconfig_Callback(hObject, eventdata, handles)
% hObject    handle to rechoseconfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=get(handles.cellstable,'Data');

s=size(data);

[cfname,cfpath] = uigetfile('*.txt','Select Config File...',[ handles.dirh '/' ] ); 

configfile=[cfpath cfname];

for i=1:s
    data{i,2}=configfile;
end

set(handles.cellstable,'Data',data);

guidata(hObject,handles);


% --- Executes on button press in specwildcardstr.
function specwildcardstr_Callback(hObject, eventdata, handles)
% hObject    handle to specwildcardstr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder_name=handles.selecteddirectory;

set(handles.currentdirectory,'String',['Current Directory: ' folder_name]);

dlist=dir([folder_name '/*_alive']);

wildcardstring=inputdlg('(e.g. "*.tif" or "Frame*ch00.png"). Leave empty to use all files in the folder. The "#" character also works as wildcard.','Please specify image file filter ', [1 80]);
wildcardstring=wildcardstring{1};
wildcardstring=regexprep(wildcardstring,'*','#');

data=get(handles.cellstable,'Data');

for i=1:numel(dlist)
    
    if dlist(i).isdir
        
        cellname=dlist(i).name(1:end-6);

        st=0;

        while(exist([ folder_name '/' cellname '_alive/' sprintf('t%03d/',st) ])==7) st=st+1; end

        if st==0
            tstring='';
            st=1;
        else
            tstring='t%03d/';
        end

        data{i,3}=[tstring wildcardstring];

        data{i,4}=[wildcardstring];   
        
    end
    
end

set(handles.cellstable,'Data',data);

guidata(hObject,handles);



% --- Executes on button press in postprocess.
function postprocess_Callback(hObject, eventdata, handles)
% hObject    handle to postprocess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tmpd=pwd;

cd(handles.selecteddirectory);

extractBatchResults;

cd(tmpd);


