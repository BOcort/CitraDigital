function varargout = Perkalian(varargin)
% Perkalian MATLAB code for Perkalian.fig
%      Perkalian, by itself, creates a new Perkalian or raises the existing
%      singleton*.
%
%      H = Perkalian returns the handle to a new Perkalian or the handle to
%      the existing singleton*.
%
%      Perkalian('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Perkalian.M with the given input arguments.
%
%      Perkalian('Property','Value',...) creates a new Perkalian or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Perkalian_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Perkalian_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Perkalian

% Last Modified by GUIDE v2.5 11-Apr-2025 00:38:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Perkalian_OpeningFcn, ...
    'gui_OutputFcn',  @Perkalian_OutputFcn, ...
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


% --- Executes just before Perkalian is made visible.
function Perkalian_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Perkalian (see VARARGIN)

% Choose default command line output for Perkalian
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Perkalian wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Perkalian_OutputFcn(hObject, eventdata, handles)
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




% Operasi Perkalian langsung di dalam pushButton
for x = 1:size(I,1)
    for y = 1:size(I,2)
        J(x,y) = I(x,y) .* 2;
    end
end
% Tampilkan hasil di axes2
set(open.figure1, 'CurrentAxes', open.axes2);
imagesc(J); % Menampilkan citra hasil clipping
colormap('gray'); % Tetapkan colormap grayscale
set(open.axes2, 'Userdata', J);


% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
