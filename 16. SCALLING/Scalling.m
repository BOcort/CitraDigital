function varargout = Scalling(varargin)
% Scalling MATLAB code for Scalling.fig
%      Scalling, by itself, creates a new Scalling or raises the existing
%      singleton*.
%
%      H = Scalling returns the handle to a new Scalling or the handle to
%      the existing singleton*.
%
%      Scalling('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Scalling.M with the given input arguments.
%
%      Scalling('Property','Value',...) creates a new Scalling or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Scalling_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Scalling_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Scalling

% Last Modified by GUIDE v2.5 11-Apr-2025 15:44:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Scalling_OpeningFcn, ...
                   'gui_OutputFcn',  @Scalling_OutputFcn, ...
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


% --- Executes just before Scalling is made visible.
function Scalling_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Scalling (see VARARGIN)

% Choose default command line output for Scalling
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Scalling wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Scalling_OutputFcn(hObject, eventdata, handles) 
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

% Tentukan faktor scaling untuk sumbu y
scale_y = 2; % Faktor scaling untuk memperbesar dimensi vertikal

% Dapatkan ukuran gambar asli
[m, n, dim] = size(I); % m: baris, n: kolom, dim: jumlah channel (RGB/Grayscale)

% Hitung ukuran baru pada sumbu y
new_m = round(m * scale_y); % Baris baru setelah scaling

% Inisialisasi matriks gambar hasil
J = zeros(new_m, n, dim, 'like', I);

% Lakukan scaling vertikal
for x = 1:new_m
    src_x = round(x / scale_y); % Hitung indeks sumber pada sumbu y
    
    % Validasi indeks sumber agar berada dalam rentang yang valid
    if src_x >= 1 && src_x <= m
        J(x, :, :) = I(src_x, :, :); % Salin baris dari gambar asli ke hasil scaling
    end
end

% Tampilkan hasil scaling di axes2
set(open.figure1, 'CurrentAxes', open.axes2);
imshow(J); % Menampilkan gambar hasil scaling
set(open.axes2, 'Userdata', J);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
