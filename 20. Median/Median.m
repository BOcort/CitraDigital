function varargout = Median(varargin)
% Median MATLAB code for Median.fig
%      Median, by itself, creates a new Median or raises the existing
%      singleton*.
%
%      H = Median returns the handle to a new Median or the handle to
%      the existing singleton*.
%
%      Median('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Median.M with the given input arguments.
%
%      Median('Property','Value',...) creates a new Median or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Median_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Median_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Median

% Last Modified by GUIDE v2.5 11-Apr-2025 17:24:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Median_OpeningFcn, ...
                   'gui_OutputFcn',  @Median_OutputFcn, ...
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


% --- Executes just before Median is made visible.
function Median_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Median (see VARARGIN)

% Choose default command line output for Median
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Median wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Median_OutputFcn(hObject, eventdata, handles) 
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

% Cek dimensi gambar (RGB atau grayscale)
[rows, cols, channels] = size(I);
I = double(I); % Konversi ke tipe double untuk perhitungan

% Inisialisasi matriks hasil
B = zeros(rows, cols, channels, 'like', I);

% Terapkan median filtering
if channels == 3 % Jika gambar RGB
    for channel = 1:channels
        % Median filtering untuk setiap channel RGB
        B(:, :, channel) = medfilt2(I(:, :, channel), [3 3]);
    end
else % Jika gambar grayscale
    B = medfilt2(I, [3 3]); % Median filtering untuk grayscale
end

% Konversi hasil ke uint8
B = uint8(B);

% Tampilkan hasil median filtering di axes2
set(open.figure1, 'CurrentAxes', open.axes2);
imshow(B); % Menampilkan gambar hasil filtering
set(open.axes2, 'Userdata', B); % Simpan hasil di Userdata
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
