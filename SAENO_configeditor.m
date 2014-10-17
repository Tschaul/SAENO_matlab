function varargout = SAENO_configeditor(varargin)
% SAENO_CONFIGEDITOR MATLAB code for SAENO_configeditor.fig
%      SAENO_CONFIGEDITOR, by itself, creates a new SAENO_CONFIGEDITOR or raises the existing
%      singleton*.
%
%      H = SAENO_CONFIGEDITOR returns the handle to a new SAENO_CONFIGEDITOR or the handle to
%      the existing singleton*.
%
%      SAENO_CONFIGEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAENO_CONFIGEDITOR.M with the given input arguments.
%
%      SAENO_CONFIGEDITOR('Property','Value',...) creates a new SAENO_CONFIGEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAENO_configeditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAENO_configeditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAENO_configeditor

% Last Modified by GUIDE v2.5 08-Jul-2013 13:18:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAENO_configeditor_OpeningFcn, ...
                   'gui_OutputFcn',  @SAENO_configeditor_OutputFcn, ...
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


% --- Executes just before SAENO_configeditor is made visible.
function SAENO_configeditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAENO_configeditor (see VARARGIN)


% Choose default command line output for SAENO_configeditor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAENO_configeditor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% SET UP WORKFLOWIMAGES

handles.dirh=mfilename('fullpath');
handles.dirh=handles.dirh(1:end-18);

flist=dir([ handles.dirh '/guimedia/configeditor/*.png' ]);

handles.workflowimages=struct;

for i=1:numel(flist)
    
    im=imread([ handles.dirh '/guimedia/configeditor/' flist(i).name]);

    hname=flist(i).name(1:end-4);
    
    handles.workflowimages.(hname)=im;
    
end

% LOAD DEFAULT CONFIG

handles.defaults=loadConfigFile([ handles.dirh '/defaults.txt' ] );
handles.modules=loadConfigFile( [ handles.dirh '/modules.txt' ] );

handles.selectedmodule='meta';

if numel(varargin)>0
    
    handles.openedfilename=char(varargin{1});
    handles.config=loadConfigFile([ handles.dirh '/defaults.txt' ]);
    
    disp(handles.openedfilename)
    
    newconfig=loadConfigFile(handles.openedfilename);

    fields = fieldnames(newconfig);

    for i=1:numel(fields)

        handles.config.(char(fields(i)))=newconfig.(char(fields(i)));

    end


    set(handles.openedfile,'String',['Opened File: ' handles.openedfilename ]);
    
else
    handles.openedfilename='';
    handles.config=loadConfigFile([ handles.dirh '/defaults.txt' ]);
end

configeditor_RenderWorkflow(hObject, eventdata, handles);
configeditor_RenderEditor(hObject, eventdata, handles);

% SAVE CHANGES
guidata(hObject,handles);



function configeditor_RenderWorkflow(hObject, eventdata, handles)


im=handles.workflowimages.background;

im=combineimages(im,handles.workflowimages.(['module_' handles.selectedmodule]));

if handles.config.BOXMESH=='1'
    im=combineimages(im,handles.workflowimages.('path_bmtrue'));
else
    im=combineimages(im,handles.workflowimages.('path_bmfalse'));
end

%disp(handles.config.MODE)

if strcmp(handles.config.MODE,'relaxation')==1
    im=combineimages(im,handles.workflowimages.('path_relaxation'));
else
    if handles.config.FIBERPATTERNMATCHING=='1'
        im=combineimages(im,handles.workflowimages.('path_fbtrue'));
    else
        im=combineimages(im,handles.workflowimages.('path_fbfalse'));
    end
    
    if strcmp(handles.config.MODE,'regularization')==1
        im=combineimages(im,handles.workflowimages.('path_regularization'));
    elseif strcmp(handles.config.MODE,'computation')==1
        im=combineimages(im,handles.workflowimages.('path_computation'));
    end
    
end


delete(allchild(handles.workflow));
set(handles.workflow,'NextPlot','add');


handles.workflowimage=image(im);

set(handles.workflowimage,'HitTest','off');

set(handles.workflow,'XTick',[]);
set(handles.workflow,'YTick',[]);
set(handles.workflow,'YDir','reverse');
set(handles.workflow,'XLim',[1 size(im,2)]);
set(handles.workflow,'YLim',[1 size(im,1)]);

function configeditor_RenderEditor(hObject, eventdata, handles)

set(handles.modulename,'String',handles.selectedmodule);

data=cell(1,1);

modulefields= fieldnames(handles.modules); 

r=1;

for i=1:numel(modulefields)
    
    if strcmp(handles.modules.(char(modulefields(i))),handles.selectedmodule)
        
        data{r,1}=char(modulefields(i));
        data{r,2}=handles.config.(char(modulefields(i)));
        
        r=r+1;
        
    end
    
end

set(handles.moduleeditor,'Data',data);




% --- Outputs from this function are returned to the command line.
function varargout = SAENO_configeditor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on mouse press over axes background.
function workflow_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to workflow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%disp('clicked on axes')
cp=get(hObject,'CurrentPoint');

x=cp(1,1);
y=cp(1,2);


modulenames = fieldnames(handles.workflowimages); 

for i=1:numel(modulenames)
    modulename=modulenames{i};
    
    if numel(modulename)>5 && strcmp(modulename(1:6),'module')==1
     
        im=handles.workflowimages.(modulename);
        
        val=(im(round(y),round(x),1)/3+im(round(y),round(x),2)/3+im(round(y),round(x),3)/3);
        
        if val<255 && strcmp(handles.selectedmodule,modulename(8:end))==0
            handles.selectedmodule=modulename(8:end);
            configeditor_RenderWorkflow(hObject, eventdata, handles)
            configeditor_RenderEditor(hObject, eventdata, handles)
        end
        
    end
    
end


guidata(hObject,handles)


% --- Executes on mouse press over figure background.
function figure1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('clicked on figure')


function im=combineimages(im1,im2),

gray=im2(:,:,1)/3+im2(:,:,2)/3+im2(:,:,3)/3;

mask=logical((gray<250));


im=im2;

red1=im1(:,:,1);
red2=im2(:,:,1);
red3=red1;
red3(mask)=red2(mask);
im(:,:,1)=red3;

red1=im1(:,:,2);
red2=im2(:,:,2);
red3=red1;
red3(mask)=red2(mask);
im(:,:,2)=red3;

red1=im1(:,:,3);
red2=im2(:,:,3);
red3=red1;
red3(mask)=red2(mask);
im(:,:,3)=red3;


% --- Executes when entered data in editable cell(s) in moduleeditor.
function moduleeditor_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to moduleeditor (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
data=get(hObject,'Data');
field=data{eventdata.Indices(1),1};
newvalue=eventdata.EditData;

handles.config.(field)=newvalue;


guidata(hObject,handles);

if strcmp(handles.selectedmodule,'meta')==1
    configeditor_RenderWorkflow(hObject, eventdata, handles)
end


% --- Executes on button press in openbutton.
function openbutton_Callback(hObject, eventdata, handles)
% hObject    handle to openbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname,fpath] = uigetfile('*.txt','Open a config file...');

handles.openedfilename=[fpath fname];


handles.config=loadConfigFile([ handles.dirh '/defaults.txt' ]);
newconfig=loadConfigFile([ fpath '/' fname ]);

fields = fieldnames(newconfig);

for i=1:numel(fields)
    
    handles.config.(char(fields(i)))=newconfig.(char(fields(i)));
    
end


configeditor_RenderWorkflow(hObject, eventdata, handles);
configeditor_RenderEditor(hObject, eventdata, handles);
            
set(handles.openedfile,'String',['Opened File: ' fpath fname ]);

guidata(hObject,handles);

% --- Executes on button press in savebutton.
function savebutton_Callback(hObject, eventdata, handles)
% hObject    handle to savebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if strcmp(handles.openedfilename,'')==1
    saveasbutton_Callback(hObject, eventdata, handles);
else
    saveConfigFile(handles.config,[ handles.openedfilename ]);   
end


% --- Executes on button press in saveasbutton.
function saveasbutton_Callback(hObject, eventdata, handles)
% hObject    handle to saveasbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname,fpath] = uiputfile('*.txt','Save config file as...');

handles.openedfilename=[ fpath fname ];

set(handles.openedfile,'String',['Opened File: ' fpath fname ]);

guidata(hObject,handles);

savebutton_Callback(hObject, eventdata, handles);
