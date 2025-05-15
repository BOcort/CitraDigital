function varargout = clipping(varargin)
% clipping MATLAB code for clipping.fig
%      clipping, by itself, creates a new clipping or raises the existing
%      singleton*.
%
%      H = clipping returns the handle to a new clipping or the handle to
%      the existing singleton*.
%
%      clipping('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in clipping.M with the given input arguments.
%
%      clipping('Property','Value',...) creates a new clipping or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before clipping_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to clipping_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help clipping

% Last Modified by GUIDE v2.5 11-Apr-2025 22:36:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @clipping_OpeningFcn, ...
    'gui_OutputFcn',  @clipping_OutputFcn, ...
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


% --- Executes just before clipping is made visible.
function clipping_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to clipping (see VARARGIN)

% Choose default command line output for clipping
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes clipping wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = clipping_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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
I = get(open.axes1, 'Userdata');

% Pastikan gambar dalam format grayscale
if ndims(I) == 3
    I = rgb2gray(I);
end

% Inisialisasi matriks J dengan ukuran yang sama dengan I
J = zeros(size(I));

% Operasi Clipping langsung di dalam pushButton
for x = 1:size(I,1)
    for y = 1:size(I,2)
        if I(x,y) > 255
            J(x,y) = 255; % Pemotongan nilai di atas 255
        elseif I(x,y) < 0
            J(x,y) = 0; % Pemotongan nilai di bawah 0
        else
            J(x,y) = I(x,y); % Nilai tetap jika dalam rentang [0, 255]
        end
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
