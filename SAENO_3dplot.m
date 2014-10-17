function varargout = SAENO_3dplot(varargin)
% SAENO_3DPLOT MATLAB code for SAENO_3dplot.fig
%      SAENO_3DPLOT, by itself, creates a new SAENO_3DPLOT or raises the existing
%      singleton*.
%
%      H = SAENO_3DPLOT returns the handle to a new SAENO_3DPLOT or the handle to
%      the existing singleton*.
%
%      SAENO_3DPLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAENO_3DPLOT.M with the given input arguments.
%
%      SAENO_3DPLOT('Property','Value',...) creates a new SAENO_3DPLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAENO_3dplot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAENO_3dplot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAENO_3dplot

% Last Modified by GUIDE v2.5 16-Oct-2013 08:51:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAENO_3dplot_OpeningFcn, ...
                   'gui_OutputFcn',  @SAENO_3dplot_OutputFcn, ...
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


% --- Executes just before SAENO_3dplot is made visible.
function SAENO_3dplot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAENO_3dplot (see VARARGIN)

% Choose default command line output for SAENO_3dplot
handles.output = hObject;

handles.selecteddirectory='';

axes(handles.colorbar);
[X,C]=meshgrid(1:10,0:100);
map=colormap(jet(size(C,1)));
RGB = ind2rgb(C,map);
imagesc(RGB);
set(gca,'YTickLabel',{'0','[unit]','max'},'fontsize',10,'YTick',[1 51 101] )
set(gca,'YAxisLocation','right')
set(gca,'XTick',[] )
axis xy

handles.directorytype='static';
handles.subdirectories={''};
handles.currentsubdir=1;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAENO_3dplot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAENO_3dplot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function viewrange_Callback(hObject, eventdata, handles)
% hObject    handle to viewrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of viewrange as text
%        str2double(get(hObject,'String')) returns contents of viewrange as a double
v=get(handles.autodraw,'Value');
if v==1.0
    redrawAxes(hObject,handles,2);
end

% --- Executes during object creation, after setting all properties.
function viewrange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to viewrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mode.
function mode_Callback(hObject, eventdata, handles)
% hObject    handle to mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mode
v=get(handles.autodraw,'Value');
if v==1.0
    redrawAxes(hObject,handles,1);
end


% --- Executes during object creation, after setting all properties.
function mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

v=get(hObject,'Value');
handles.currentsubdir=floor(v*length(handles.subdirectories));
if handles.currentsubdir==0
    handles.currentsubdir=1;
end
set(handles.subdirtext,'String',handles.subdirectories{handles.currentsubdir});
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in redraw.
function redraw_Callback(hObject, eventdata, handles)
% hObject    handle to redraw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

redrawAxes(hObject,handles,1);

function maxv_Callback(hObject, eventdata, handles)
% hObject    handle to maxv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxv as text
%        str2double(get(hObject,'String')) returns contents of maxv as a double
v=get(handles.autodraw,'Value');
if v==1.0
    redrawAxes(hObject,handles,3);
end

% --- Executes during object creation, after setting all properties.
function maxv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function azimuth_Callback(hObject, eventdata, handles)
% hObject    handle to azimuth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of azimuth as text
%        str2double(get(hObject,'String')) returns contents of azimuth as a double
v=get(handles.autodraw,'Value');
if v==1.0
    redrawAxes(hObject,handles,4);
end


% --- Executes during object creation, after setting all properties.
function azimuth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to azimuth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function elevation_Callback(hObject, eventdata, handles)
% hObject    handle to elevation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of elevation as text
%        str2double(get(hObject,'String')) returns contents of elevation as a double
v=get(handles.autodraw,'Value');
if v==1.0
    redrawAxes(hObject,handles,4);
end

% --- Executes during object creation, after setting all properties.
function elevation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elevation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in loadcell.
function loadcell_Callback(hObject, eventdata, handles)
% hObject    handle to loadcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.selecteddirectory = uigetdir;
set(handles.currentdirectory,'String',['Current Directory: ' handles.selecteddirectory ]);
if strcmp(handles.selecteddirectory(end-7:end),'_results')==1
        
    if exist([ handles.selecteddirectory '/t0' ],'dir') || ... 
            exist([ handles.selecteddirectory '/t00' ],'dir') || ...
            exist([ handles.selecteddirectory '/t000' ],'dir')
        
        handles.directorytype='timesteps';
        handles.subdirectories={};
        
        dlist=dir([ handles.selecteddirectory '/t*' ]);
        
        for i=1:length(dlist)
            handles.subdirectories{i}=dlist(i).name;
        end
            
        handles.currentsubdir=1;
        set(handles.subdirtext,'String',handles.subdirectories{handles.currentsubdir});
        
    else
        handles.directorytype='static'; 
        handles.subdirectories={''};
        handles.currentsubdir=1;
        set(handles.subdirtext,'String',handles.subdirectories{handles.currentsubdir});
        
    end
            
else
    
    handles.directorytype='cells'; 
    handles.subdirectories={};
        
    dlist=dir([ handles.selecteddirectory '/*_results' ]);

    for i=1:length(dlist)
        
        if(exist([ handles.selecteddirectory '/' dlist(i).name '/t000'])==7)
            
            ttt=0;
            
            while(exist([ handles.selecteddirectory '/' dlist(i).name '/t' sprintf('%03d',ttt)])==7)
               
                handles.subdirectories{end+1}=[dlist(i).name '/t' sprintf('%03d',ttt)];
                ttt=ttt+1;
                
            end
            
        else
            handles.subdirectories{end+1}=dlist(i).name;
        end
        
    end
    
    handles.currentsubdir=1;
    set(handles.subdirtext,'String',handles.subdirectories{handles.currentsubdir});
    
end

guidata(hObject, handles);
v=get(handles.autodraw,'Value');
if v==1.0
    redrawAxes(hObject,handles,1);
end

function quivercount_Callback(hObject, eventdata, handles)
% hObject    handle to quivercount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of quivercount as text
%        str2double(get(hObject,'String')) returns contents of quivercount as a double
v=get(handles.autodraw,'Value');
if v==1.0
    redrawAxes(hObject,handles,2);
end

% --- Executes during object creation, after setting all properties.
function quivercount_CreateFcn(hObject, eventdata, handles)
% hObject    handle to quivercount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function options=getOptions(handles)
options=struct();

options.viewrange=str2num(get(handles.viewrange,'String'));
options.maxv=str2num(get(handles.maxv,'String'));
options.azimuth=str2num(get(handles.azimuth,'String'));
options.elevation=str2num(get(handles.elevation,'String'));
options.quivercount=str2num(get(handles.quivercount,'String'));
options.s=str2num(get(handles.smoothen,'String'));
options.bfchannel=str2num(get(handles.bfchannel,'String'));
options.drawmoments=get(handles.drawmoments,'Value');

val=get(handles.mode,'Value');

if val==1
    options.mode='data';
elseif val==2
    options.mode='fit';
elseif val==3
    options.mode='forces'; 
else 
    options.mode='noise'; 
end

function fig=redrawAxes(hObject,handles,stage,export)

fig=0;

if nargin < 4
    export=0;
end

options=getOptions(handles);

if export
    handles.exportfigure=figure('units','centimeter','position',[5 5 10 8.5]);
    fig=handles.exportfigure;
    mainaxes=axes('units','normalized','position',[0 0 0.9 1]);
else
    mainaxes=handles.axes;
    axes(mainaxes);
end

if stage<=1
    
    [handles.Vx,handles.Vy,handles.Vz] = loadInterpolants( [ handles.selecteddirectory '/' ...
        handles.subdirectories{handles.currentsubdir} ], options.mode, options.s);
    
     cfg=loadConfigFile( [ handles.selecteddirectory '/' handles.subdirectories{handles.currentsubdir} '/config.txt' ]);
     
     resname=[ handles.selecteddirectory '/' handles.subdirectories{handles.currentsubdir} '/results.txt' ];
     if exist(resname,'file')>0
        res=loadConfigFile( resname );
        statstr=[ 'ENERGY = ' num2str(res.ENERGY) 'J'...
            ' CONTRACTILITY = ' res.CONTRACTILITY 'N' ...
            ' FMAX = ' res.FMAX 'N' ...
            ' POLARITY = ' res.POLARITY ...
            ' STIFFENING = '  res.STIFFENING ];
        set(handles.cellstats,'String',statstr);
     end
     
%      iaend=find(cfg.STACKA=='/',1,'last');
%      fnamea=cfg.STACKA(iaend+1:end);
%      
%      disp(cfg.STACKA)
%      
%      disp(handles.selecteddirectory)
     
    %%%% if the data has been copied since the main program has run the folders in the config file have changed
    %%%% this fixes this

    if(options.bfchannel>-1)
        
        try
        
            isdend=find(handles.selecteddirectory=='\' | handles.selecteddirectory=='/' ,1,'last');
            seldirname=handles.selecteddirectory(isdend+1:end);

            if strcmp(seldirname(end-6:end),'results')
             trunk=handles.selecteddirectory(1:isdend-1);
            isdend=find(trunk=='\' | trunk=='/' ,1,'last');
            seldirname=trunk(isdend+1:end);
            end

            iasd=findstr(cfg.STACKA,'_alive');
            iasd=iasd(1);
            adirname=cfg.STACKA(1:iasd-1);

            iasd=find(adirname=='\' | adirname=='/' ,1,'last');
            stackname=cfg.STACKA(iasd+1:end);

            fnamea=[ handles.selecteddirectory(1:isdend-1) '/' seldirname '/' stackname];

            bfstackname=strrep(regexprep(fnamea, '_ch0[0-9]', sprintf('_ch%02d',options.bfchannel) ),'\','\\');
            handles.bfprojection=bfprojection(bfstackname,str2num(cfg.ZFROM),str2num(cfg.ZTO));

            handles.bfprojection=medfilt2(handles.bfprojection);

            handles.dxy=str2num(cfg.VOXELSIZEX);
            handles.sx=size(handles.bfprojection,1);
            handles.sy=size(handles.bfprojection,1);

        %     handles.sx*handles.dxy/2
        %     options.viewrange

            if options.viewrange<handles.sx*handles.dxy/2
        %         round(-options.viewrange/handles.dxy+handles.sx/2)
        %         round(options.viewrange/handles.dxy+handles.sx/2)
                handles.bfprojection=handles.bfprojection( ...
                    round(-options.viewrange/handles.dxy+handles.sx/2): ... 
                    round(options.viewrange/handles.dxy+handles.sx/2), ... 
                    round(-options.viewrange/handles.dxy+handles.sx/2): ...
                    round(options.viewrange/handles.dxy+handles.sx/2) );
                handles.sx=size(handles.bfprojection,1);
                handles.sy=size(handles.bfprojection,1);

            end
    
        catch 
            
            warning('Could not load brightfield stack for projection')
            
            options.bfchannel=-1;
            
        end
        
    end

%     options.s
end

if stage<=2
    [handles.VV,handles.RR]=generateQuiver(handles.Vx,handles.Vy,handles.Vz,options.quivercount,options.viewrange);
%     size(handles.VV)
end

if stage<=3

    if(options.maxv==0) 
        handles.maxvplotted=prctile(sqrt(sum(handles.VV.^2,2)),99.9);
    else
        handles.maxvplotted=options.maxv;
    end

    scale=options.viewrange/handles.maxvplotted/10;

    set(gca,'color','black')

    cla(mainaxes)
    
    if strcmp(options.mode,'forces')
        quiver3color(handles.RR,handles.VV,scale,handles.maxvplotted,'hot');
    else
        quiver3color(handles.RR,handles.VV,scale,handles.maxvplotted,'jet');
    end
        
    set(gca,'LineWidth',1)
    
    hold on
    
    if(options.bfchannel>-1)
    
        try
        
            imrange=handles.sx*handles.dxy/2;

            surf([-imrange imrange],[-imrange imrange],repmat(options.viewrange, [2 2]),...
                         handles.bfprojection,'facecolor','texturemap')
            colormap(gray);
        
        
        end
        
    end
    
    
    if options.drawmoments==1
        resname=[ handles.selecteddirectory '/' handles.subdirectories{handles.currentsubdir} '/results.txt' ];
        if exist(resname,'file')>0
            res=loadConfigFile( resname );
            
            ltot=50e-6;
            %l1=str2double(res.Fmax)/(str2double(res.Fmax)+str2double(res.F2)+str2double(res.F3))*ltot;
            %l2=str2double(res.F2)/(str2double(res.F1)+str2double(res.F2)+str2double(res.F3))*ltot;
            %l3=str2double(res.F3)/(str2double(res.F1)+str2double(res.F2)+str2double(res.F3))*ltot;
            
            cmsx=str2double(res.CMS_X);
            cmsy=str2double(res.CMS_Y);
            cmsz=str2double(res.CMS_Z);
            v1x=str2double(res.VMAX_X);
            v1y=str2double(res.VMAX_Y);
            v1z=str2double(res.VMAX_Z);
%             v2x=str2double(res.V2_X);
%             v2y=str2double(res.V2_Y);
%             v2z=str2double(res.V2_Z);
%             v3x=str2double(res.V3_X);
%             v3y=str2double(res.V3_Y);
%             v3z=str2double(res.V3_Z);
            
            plot3([cmsx-ltot*v1x cmsx+ltot*v1x],[cmsy-ltot*v1y cmsy+ltot*v1y],[cmsz-ltot*v1z cmsz+ltot*v1z],'w');
            %plot3([cmsx-l2*v2x cmsx+l2*v2x],[cmsy-l2*v2y cmsy+l2*v2y],[cmsz-l2*v2z cmsz+l2*v2z],'w');
            %plot3([cmsx-l3*v3x cmsx+l3*v3x],[cmsy-l3*v3y cmsy+l3*v3y],[cmsz-l3*v3z cmsz+l3*v3z],'w');
            
        end
    end
    
    hold off
    
end

if stage<=4

    xlim([-options.viewrange options.viewrange]);
    ylim([-options.viewrange options.viewrange]);
    zlim([-options.viewrange options.viewrange]);
    %set(gcf,'units','centimeters');
    %set(gcf,'position',[0 0 16 12]);

    set(gca,'XTick',[])
    set(gca,'YTick',[])
    set(gca,'ZTick',[])

    if strcmp(options.mode,'forces')
        maxvstr=sprintf('%3.2f',handles.maxvplotted*1e-6);
        unitstr='[pN/µm^3]';
    else
        maxvstr=sprintf('%3.2f',handles.maxvplotted*1e6);
        unitstr='[µm]';
    end

    axes(mainaxes);
    axis ij
    set(gca,'ZDir','reverse')

    view(options.azimuth,options.elevation);
    
    if export
        figure(handles.exportfigure);
        colorbaraxes=axes('units','normalized','position',[0.85 0.05 0.05 0.9]);
        [X,C] = meshgrid(1:10,0:100);
        if strcmp(options.mode,'forces')
            map = colormap(hot(size(C,1)));
        else
            map = colormap(jet(size(C,1)));
        end            
        RGB = ind2rgb(C,map);
        imagesc(RGB);
        set(colorbaraxes,'YAxisLocation','right');
        set(colorbaraxes,'XTick',[] );
        axis xy
        set(colorbaraxes,'YTickLabel',{'0',maxvstr},'fontsize',10,'YTick',[1 101] )

        text(20,51,unitstr,'rotation',90,'interpreter','none','HorizontalAlignment','center','fontsize',10)
        
%         th=rotateticklabel(colorbaraxes);

        set(gcf,'PaperPositionMode','auto')
        set(gcf, 'InvertHardCopy', 'off');
        set(gcf, 'color', 'w');

    else
        colorbaraxes=handles.colorbar;
        axes(colorbaraxes);
        set(colorbaraxes,'YTickLabel',{'0',unitstr,maxvstr},'fontsize',10,'YTick',[1 51 101] );
    end
    
    colormap(gray);
    
end



guidata(hObject, handles);

% --- Executes on button press in export.
function export_Callback(hObject, eventdata, handles)
% hObject    handle to export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v=get(handles.autodraw,'Value');
if v==1.0
    redrawAxes(hObject,handles,3, 1);
end



function smoothen_Callback(hObject, eventdata, handles)
% hObject    handle to smoothen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of smoothen as text
%        str2double(get(hObject,'String')) returns contents of smoothen as a double
v=get(handles.autodraw,'Value');
if v==1.0
    redrawAxes(hObject,handles,1);
end


% --- Executes during object creation, after setting all properties.
function smoothen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to smoothen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bfchannel_Callback(hObject, eventdata, handles)
% hObject    handle to bfchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bfchannel as text
%        str2double(get(hObject,'String')) returns contents of bfchannel as a double


% --- Executes during object creation, after setting all properties.
function bfchannel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bfchannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exportall.
function exportall_Callback(hObject, eventdata, handles)
% hObject    handle to exportall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fnameuser,folder] = uiputfile;

if ischar(fnameuser) && ischar(folder)

idot=find(fnameuser=='.',1,'last');

fnamebase=fnameuser(1:idot-1);
fnameending=fnameuser(idot:end);

for i=1:numel(handles.subdirectories)

    handles.currentsubdir=i;
    set(handles.subdirtext,'String',handles.subdirectories{i});
    guidata(hObject, handles);

    fig=redrawAxes(hObject,handles,0, 1);
    
    sanstr=strrep(strrep(handles.subdirectories{i}, '/', '_'), '_results', '');
    
    fname=[folder '/' fnamebase '_' sanstr fnameending];
    
    print(fig,'-dpng','-zbuffer','-r600',fname);
    
    close(fig);
    
end

end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over exportall.
function exportall_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to exportall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in autodraw.
function autodraw_Callback(hObject, eventdata, handles)
% hObject    handle to autodraw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of autodraw


% --- Executes on button press in azplus.
function azplus_Callback(hObject, eventdata, handles)
% hObject    handle to azplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v=str2num(get(handles.azimuth,'String'));
set(handles.azimuth,'String',num2str(v+5));
v=get(handles.autodraw,'Value');
if v==1.0
    redrawAxes(hObject,handles,4);
end
    


% --- Executes on button press in azminus.
function azminus_Callback(hObject, eventdata, handles)
% hObject    handle to azminus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v=str2num(get(handles.azimuth,'String'));
set(handles.azimuth,'String',num2str(v-5));
v=get(handles.autodraw,'Value');
if v==1.0
    redrawAxes(hObject,handles,4);
end


% --- Executes on button press in elevplus.
function elevplus_Callback(hObject, eventdata, handles)
% hObject    handle to elevplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v=str2num(get(handles.elevation,'String'));
set(handles.elevation,'String',num2str(v+5));
v=get(handles.autodraw,'Value');
if v==1.0
    redrawAxes(hObject,handles,4);
end

% --- Executes on button press in elevminus.
function elevminus_Callback(hObject, eventdata, handles)
% hObject    handle to elevminus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
v=str2num(get(handles.elevation,'String'));
set(handles.elevation,'String',num2str(v-5));
v=get(handles.autodraw,'Value');
if v==1.0
    redrawAxes(hObject,handles,4);
end


% --- Executes on button press in drawmoments.
function drawmoments_Callback(hObject, eventdata, handles)
% hObject    handle to drawmoments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of drawmoments
v=str2num(get(handles.elevation,'String'));
set(handles.elevation,'String',num2str(v-5));
v=get(handles.autodraw,'Value');
if v==1.0
    redrawAxes(hObject,handles,3);
end
