function varargout = Pengurangan(varargin)
% Pengurangan MATLAB code for Pengurangan.fig
%      Pengurangan, by itself, creates a new Pengurangan or raises the existing
%      singleton*.
%
%      H = Pengurangan returns the handle to a new Pengurangan or the handle to
%      the existing singleton*.
%
%      Pengurangan('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Pengurangan.M with the given input arguments.
%
%      Pengurangan('Property','Value',...) creates a new Pengurangan or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Pengurangan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Pengurangan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Pengurangan

% Last Modified by GUIDE v2.5 11-Apr-2025 00:29:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Pengurangan_OpeningFcn, ...
    'gui_OutputFcn',  @Pengurangan_OutputFcn, ...
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


% --- Executes just before Pengurangan is made visible.
function Pengurangan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Pengurangan (see VARARGIN)

% Choose default command line output for Pengurangan
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Pengurangan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Pengurangan_OutputFcn(hObject, eventdata, handles)
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

function pushbutton3_Callback(hObject, eventdata, handles)
open=guidata(gcbo);
[namafile,direktori]=uigetfile({'*.jpg;*.bmp;*.tif'}, 'OpenImage');
I=imread(fullfile(direktori, namafile));
set(open.figure1,'CurrentAxes',open.axes5);
set(imagesc(I));
set(open.axes5,'Userdata',I);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
open = guidata(gcbo);

% Ambil data dari axes1 dan axes4
A = double(get(open.axes1, 'Userdata'));
B = double(get(open.axes5, 'Userdata'));

% Periksa apakah data di axes1 dan axes4 tidak kosong
if isempty(A)
    errordlg('Gambar di axes1 kosong! Silakan muat gambar terlebih dahulu.', 'Error');
    return;
end

if isempty(B)
    errordlg('Gambar di axes5 kosong! Silakan muat gambar terlebih dahulu.', 'Error');
    return;
end

% Pastikan gambar memiliki ukuran yang sesuai
[r1, c1] = size(A);
[r2, c2] = size(B);


fprintf('Dimensi matriks A: %d x %d\n', r1, c1);
fprintf('Dimensi matriks B: %d x %d\n', r2, c2);
if r1 ~= r2 || c1 ~= c2
   
    % Sesuaikan ukuran gambar B agar sama dengan A
    B = imresize(B, [100 100]);
    A = imresize(A, [100 100]);
    [r1, c1] = size(A);
    [r2, c2] = size(B);
end

fprintf('Dimensi matriks A: %d x %d\n', r1, c1);
fprintf('Dimensi matriks B: %d x %d\n', r2, c2);
% Operasi pengurangan piksel
C = A - B;

% Terapkan operasi clipping
C(C > 255) = 255; % Intensitas maksimum
C(C < 0) = 0;     % Intensitas minimum

% Tampilkan hasil di axes2
set(open.figure1, 'CurrentAxes', open.axes6);
imshow(uint8(C)); % Menampilkan hasil
set(open.axes6, 'Userdata', C);


% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
