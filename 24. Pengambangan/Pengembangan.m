function varargout = Pengembangan(varargin)
% Pengembangan MATLAB code for Pengembangan.fig
%      Pengembangan, by itself, creates a new Pengembangan or raises the existing
%      singleton*.
%
%      H = Pengembangan returns the handle to a new Pengembangan or the handle to
%      the existing singleton*.
%
%      Pengembangan('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Pengembangan.M with the given input arguments.
%
%      Pengembangan('Property','Value',...) creates a new Pengembangan or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Pengembangan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Pengembangan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Pengembangan

% Last Modified by GUIDE v2.5 12-Apr-2025 01:23:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Pengembangan_OpeningFcn, ...
                   'gui_OutputFcn',  @Pengembangan_OutputFcn, ...
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


% --- Executes just before Pengembangan is made visible.
function Pengembangan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Pengembangan (see VARARGIN)

% Choose default command line output for Pengembangan
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Pengembangan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Pengembangan_OutputFcn(hObject, eventdata, handles) 
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
I = get(handles.axes1, 'Userdata');

% Validasi input gambar
if isempty(I)
    errordlg('Gambar di axes1 kosong! Silakan muat gambar terlebih dahulu.', 'Error');
    return;
end

% Pastikan gambar adalah grayscale atau RGB
if size(I, 3) > 1
    I = rgb2gray(I); % Konversi ke grayscale jika gambar RGB
end

% Tentukan nilai ambang (threshold)
T = 128; % Nilai ambang batas (dapat disesuaikan)

% Dapatkan ukuran gambar
[r, c] = size(I);

% Inisialisasi matriks hasil pengambangan
G = zeros(r, c, 'uint8');

% Operasi pengambangan
for x = 1:r
    for y = 1:c
        if I(x, y) >= T
            G(x, y) = 255; % Piksel putih untuk intensitas >= ambang
        else
            G(x, y) = 0; % Piksel hitam untuk intensitas < ambang
        end
    end
end

% Tampilkan hasil pengambangan di axes2
set(handles.figure1, 'CurrentAxes', handles.axes2);
imshow(G); % Tampilkan hasil pengambangan
title(['Hasil Pengambangan (T = ', num2str(T), ')']);

% Simpan hasil di axes2 userdata (jika diperlukan untuk proses lain)
set(handles.axes2, 'Userdata', G);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
