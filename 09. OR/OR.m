function varargout = OR(varargin)
% OR MATLAB code for OR.fig
%      OR, by itself, creates a new OR or raises the existing
%      singleton*.
%
%      H = OR returns the handle to a new OR or the handle to
%      the existing singleton*.
%
%      OR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OR.M with the given input arguments.
%
%      OR('Property','Value',...) creates a new OR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before OR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to OR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help OR

% Last Modified by GUIDE v2.5 11-Apr-2025 14:39:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @OR_OpeningFcn, ...
    'gui_OutputFcn',  @OR_OutputFcn, ...
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


% --- Executes just before OR is made visible.
function OR_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles or user data (see GUIDATA)
% varargin   command line arguments to OR (see VARARGIN)

% Choose default command line output for OR
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes OR wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = OR_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles or user data (see GUIDATA)

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
% handles    structure with handles or user data (see GUIDATA)

function pushbutton3_Callback(hObject, eventdata, handles)
open=guidata(gcbo);
[namafile,direktori]=uigetfile({'*.jpg;*.bmp;*.tif'}, 'OpenImage');
I=imread(fullfile(direktori, namafile));
set(open.figure1,'CurrentAxes',open.axes5);
set(imagesc(I));
set(open.axes5,'Userdata',I);
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles or user data (see GUIDATA)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
open = guidata(gcbo);

% Ambil data dari axes1 dan axes5
A = get(open.axes1, 'Userdata'); % Gambar pertama
B = get(open.axes5, 'Userdata'); % Gambar kedua

% Pastikan gambar tidak kosong
if isempty(A)
    errordlg('Gambar di axes1 kosong! Silakan muat gambar terlebih dahulu.', 'Error');
    return;
end
if isempty(B)
    errordlg('Gambar di axes5 kosong! Silakan muat gambar terlebih dahulu.', 'Error');
    return;
end

% Konversi gambar ke grayscale jika berwarna
if ndims(A) == 3
    A = rgb2gray(A);
end
if ndims(B) == 3
    B = rgb2gray(B);
end

% Konversi gambar ke biner (thresholding manual)
A = A > 128; % Gunakan ambang batas 128
B = B > 128; % Gunakan ambang batas 128

% Pastikan dimensi sama, lakukan resize jika perlu
[r1, c1] = size(A);
[r2, c2] = size(B);
if r1 ~= r2 || c1 ~= c2
    B = imresize(B, [r1, c1]); % Sesuaikan ukuran B ke A
end

% Inisialisasi hasil
C = zeros(r1, c1);

% Operasi OR piksel demi piksel
for x = 1:r1
    for y = 1:c1
        C(x, y) = or(A(x, y), B(x, y));
    end
end

% Tampilkan hasil di axes6
set(open.figure1, 'CurrentAxes', open.axes6);
imshow(C); % Hasil biner tidak perlu uint8
set(open.axes6, 'Userdata', C);



% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles or user data (see GUIDATA)
