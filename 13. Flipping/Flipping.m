function varargout = Flipping(varargin)
% Flipping MATLAB code for Flipping.fig
%      Flipping, by itself, creates a new Flipping or raises the existing
%      singleton*.
%
%      H = Flipping returns the handle to a new Flipping or the handle to
%      the existing singleton*.
%
%      Flipping('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Flipping.M with the given input arguments.
%
%      Flipping('Property','Value',...) creates a new Flipping or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Flipping_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Flipping_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Flipping

% Last Modified by GUIDE v2.5 11-Apr-2025 15:10:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Flipping_OpeningFcn, ...
                   'gui_OutputFcn',  @Flipping_OutputFcn, ...
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


% --- Executes just before Flipping is made visible.
function Flipping_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Flipping (see VARARGIN)

% Choose default command line output for Flipping
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Flipping wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Flipping_OutputFcn(hObject, eventdata, handles) 
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

% Pastikan gambar tidak kosong
if isempty(I)
    errordlg('Gambar di axes1 kosong! Silakan muat gambar terlebih dahulu.', 'Error');
    return;
end

% Ambil ukuran gambar
[brs, kol, dim] = size(I); % Dim: 3 untuk RGB, 1 untuk grayscale

% Inisialisasi matriks hasil flipping
J = zeros(brs, kol, dim, 'like', I); % Sama tipe dengan I (termasuk RGB atau uint8)

% Lakukan flipping secara vertikal (membalik atas ke bawah)
for x = 1:brs
    J(x, :, :) = I(brs - x + 1, :, :); % Membalik baris-baris
end

% Tampilkan hasil flipping di axes2
set(open.figure1, 'CurrentAxes', open.axes2);
imshow(J); % Menampilkan gambar dengan format asli
set(open.axes2, 'Userdata', J); % Simpan hasil flipping di Userdata
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
