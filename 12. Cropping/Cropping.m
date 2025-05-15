function varargout = Cropping(varargin)
% Cropping MATLAB code for Cropping.fig
%      Cropping, by itself, creates a new Cropping or raises the existing
%      singleton*.
%
%      H = Cropping returns the handle to a new Cropping or the handle to
%      the existing singleton*.
%
%      Cropping('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Cropping.M with the given input arguments.
%
%      Cropping('Property','Value',...) creates a new Cropping or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Cropping_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Cropping_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Cropping

% Last Modified by GUIDE v2.5 11-Apr-2025 14:55:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Cropping_OpeningFcn, ...
                   'gui_OutputFcn',  @Cropping_OutputFcn, ...
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


% --- Executes just before Cropping is made visible.
function Cropping_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Cropping (see VARARGIN)

% Choose default command line output for Cropping
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Cropping wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Cropping_OutputFcn(hObject, eventdata, handles) 
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

% Ambil data gambar dari axes1
I = get(open.axes1, 'Userdata');

% Ambil ukuran gambar
[brs, kol, dim] = size(I); % Mendukung gambar RGB (dim dapat 3 untuk RGB, 1 untuk grayscale)

% Definisikan koordinat cropping
x1 = 50; % Baris awal untuk crop
x2 = 200; % Baris akhir untuk crop
y1 = 50; % Kolom awal untuk crop
y2 = 200; % Kolom akhir untuk crop

% Lakukan cropping dengan mengatur piksel di luar area menjadi 0
if dim == 3 % Jika gambar RGB
    I(1:x1, :, :) = 0; % Baris di atas x1 menjadi 0
    I(x2:brs, :, :) = 0; % Baris di bawah x2 menjadi 0
    I(:, 1:y1, :) = 0; % Kolom di sebelah kiri y1 menjadi 0
    I(:, y2:kol, :) = 0; % Kolom di sebelah kanan y2 menjadi 0
else % Jika gambar grayscale
    I(1:x1, :) = 0; % Baris di atas x1 menjadi 0
    I(x2:brs, :) = 0; % Baris di bawah x2 menjadi 0
    I(:, 1:y1) = 0; % Kolom di sebelah kiri y1 menjadi 0
    I(:, y2:kol) = 0; % Kolom di sebelah kanan y2 menjadi 0
end

% Tampilkan hasil cropping di axes2
set(open.figure1, 'CurrentAxes', open.axes2);
imshow(I); % Menampilkan hasil cropping
set(open.axes2, 'Userdata', I);
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
