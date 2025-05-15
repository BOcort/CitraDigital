function varargout = lowPasFilter(varargin)
% lowPasFilter MATLAB code for lowPasFilter.fig
%      lowPasFilter, by itself, creates a new lowPasFilter or raises the existing
%      singleton*.
%
%      H = lowPasFilter returns the handle to a new lowPasFilter or the handle to
%      the existing singleton*.
%
%      lowPasFilter('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in lowPasFilter.M with the given input arguments.
%
%      lowPasFilter('Property','Value',...) creates a new lowPasFilter or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lowPasFilter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lowPasFilter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lowPasFilter

% Last Modified by GUIDE v2.5 11-Apr-2025 16:34:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lowPasFilter_OpeningFcn, ...
                   'gui_OutputFcn',  @lowPasFilter_OutputFcn, ...
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


% --- Executes just before lowPasFilter is made visible.
function lowPasFilter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lowPasFilter (see VARARGIN)

% Choose default command line output for lowPasFilter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lowPasFilter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lowPasFilter_OutputFcn(hObject, eventdata, handles) 
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

% Deteksi dimensi gambar (grayscale atau RGB)
[rows, cols, channels] = size(I);

% Konversi ke tipe double untuk operasi konvolusi
I = double(I);

% Definisikan kernel (contoh: filter rata-rata 3x3)
k = ones(3) / 9;

% Inisialisasi matriks hasil dengan dimensi yang sama
Hsl = zeros(rows, cols, channels, 'like', I);

% Terapkan konvolusi secara terpisah untuk setiap channel jika RGB
for channel = 1:channels
    Hsl(:, :, channel) = conv2(I(:, :, channel), k, 'same'); % Konvolusi dengan 'same' agar ukuran output sama
end

% Konversi hasil ke uint8 untuk ditampilkan
Hsl = uint8(Hsl);

% Tampilkan hasil konvolusi di axes2
set(open.figure1, 'CurrentAxes', open.axes2);
imshow(Hsl); % Menampilkan gambar hasil dengan format penuh
set(open.axes2, 'Userdata', Hsl); % Simpan hasil di Userdata
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
