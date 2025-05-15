function varargout = Pembagian(varargin)
% Pembagian MATLAB code for Pembagian.fig
%      Pembagian, by itself, creates a new Pembagian or raises the existing
%      singleton*.
%
%      H = Pembagian returns the handle to a new Pembagian or the handle to
%      the existing singleton*.
%
%      Pembagian('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Pembagian.M with the given input arguments.
%
%      Pembagian('Property','Value',...) creates a new Pembagian or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Pembagian_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Pembagian_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Pembagian

% Last Modified by GUIDE v2.5 11-Apr-2025 01:17:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Pembagian_OpeningFcn, ...
    'gui_OutputFcn',  @Pembagian_OutputFcn, ...
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


% --- Executes just before Pembagian is made visible.
function Pembagian_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Pembagian (see VARARGIN)

% Choose default command line output for Pembagian
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Pembagian wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Pembagian_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function J = clipping(I)
for x = 1 : size(I,1)
    for y = 1 : size(I,2)
        if I(x,y) > 255
            J(x,y) = 255;
        elseif I(x,y) < 0
            J(x,y) = 0;
        else
            J(x,y) = I(x,y);
        end
    end
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
open=guidata(gcbo);
[namafile,direktori]=uigetfile({'*.jpg;*.bmp;*.tif'}, 'OpenImage');
I=imread(fullfile(direktori, namafile));
set(open.figure1,'CurrentAxes',open.axes1);
set(imagesc(I));
set(open.axes1,'Userdata',I);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
open = guidata(gcbo);
I = double(get(open.axes1, 'Userdata'));


% Operasi Pembagian langsung di dalam pushButton
for x = 1:size(I,1)
    for y = 1:size(I,2)
        J(x,y) = I(x,y) ./ 2;
    end
end
% Tampilkan hasil di axes
set(open.figure1, 'CurrentAxes', open.axes2);
imagesc(I); % Menampilkan citra hasil clipping
set(open.axes2, 'Userdata', I);


% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
