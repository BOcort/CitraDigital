function varargout = Mirroring(varargin)
% Mirroring MATLAB code for Mirroring.fig
%      Mirroring, by itself, creates a new Mirroring or raises the existing
%      singleton*.
%
%      H = Mirroring returns the handle to a new Mirroring or the handle to
%      the existing singleton*.
%
%      Mirroring('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Mirroring.M with the given input arguments.
%
%      Mirroring('Property','Value',...) creates a new Mirroring or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Mirroring_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Mirroring_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Mirroring

% Last Modified by GUIDE v2.5 11-Apr-2025 15:15:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Mirroring_OpeningFcn, ...
                   'gui_OutputFcn',  @Mirroring_OutputFcn, ...
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


% --- Executes just before Mirroring is made visible.
function Mirroring_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Mirroring (see VARARGIN)

% Choose default command line output for Mirroring
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Mirroring wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Mirroring_OutputFcn(hObject, eventdata, handles) 
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

% Validasi input gambar
if isempty(I)
    errordlg('Gambar di axes1 kosong! Silakan muat gambar terlebih dahulu.', 'Error');
    return; 
end

% Pastikan gambar adalah RGB atau grayscale
if size(I, 3) ~= 1 && size(I, 3) ~= 3
    errordlg('Gambar harus dalam format RGB atau grayscale!', 'Error');
    return;
end

% Proses mirroring (horizontal)
[brs, kol, saluran] = size(I); % Dapatkan dimensi gambar
J = zeros(brs, kol, saluran, 'uint8'); % Inisialisasi hasil mirroring
for x = 1:brs
    for y = 1:kol
        J(x, y, :) = I(x, kol - y + 1, :); % Membalik kolom untuk tiap baris
    end
end

% Tampilkan hasil mirroring di axes2
set(open.figure1, 'CurrentAxes', open.axes2);
imshow(J); % Menampilkan hasil mirroring
title('Hasil Mirroring');
set(open.axes2, 'Userdata', J); % Simpan hasil ke userdata
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
