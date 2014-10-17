function varargout = SAENO_starter(varargin)
% SAENO_STARTER MATLAB code for SAENO_starter.fig
%      SAENO_STARTER, by itself, creates a new SAENO_STARTER or raises the existing
%      singleton*.
%
%      H = SAENO_STARTER returns the handle to a new SAENO_STARTER or the handle to
%      the existing singleton*.
%
%      SAENO_STARTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAENO_STARTER.M with the given input arguments.
%
%      SAENO_STARTER('Property','Value',...) creates a new SAENO_STARTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAENO_starter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAENO_starter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAENO_starter

% Last Modified by GUIDE v2.5 03-Jul-2013 14:15:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAENO_starter_OpeningFcn, ...
                   'gui_OutputFcn',  @SAENO_starter_OutputFcn, ...
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


% --- Executes just before SAENO_starter is made visible.
function SAENO_starter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAENO_starter (see VARARGIN)

% Choose default command line output for SAENO_starter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAENO_starter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAENO_starter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in configeditor.
function configeditor_Callback(hObject, eventdata, handles)
% hObject    handle to configeditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SAENO_configeditor


% --- Executes on button press in batchfrecon.
function batchfrecon_Callback(hObject, eventdata, handles)
% hObject    handle to batchfrecon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SAENO_batchfrecon