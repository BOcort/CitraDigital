function varargout = ENCODING(varargin)
% ENCODING MATLAB code for ENCODING.fig
%      ENCODING, by itself, creates a new ENCODING or raises the existing
%      singleton*.
%
%      H = ENCODING returns the handle to a new ENCODING or the handle to
%      the existing singleton*.
%
%      ENCODING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENCODING.M with the given input arguments.
%
%      ENCODING('Property','Value',...) creates a new ENCODING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ENCODING_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ENCODING_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ENCODING

% Last Modified by GUIDE v2.5 11-Apr-2025 20:22:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ENCODING_OpeningFcn, ...
                   'gui_OutputFcn',  @ENCODING_OutputFcn, ...
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


% --- Executes just before ENCODING is made visible.
function ENCODING_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ENCODING (see VARARGIN)

% Choose default command line output for ENCODING
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ENCODING wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ENCODING_OutputFcn(hObject, eventdata, handles) 
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

% Dapatkan dimensi gambar
[rows, cols, channels] = size(I);

% Inisialisasi file untuk menyimpan hasil encoding RLE
fileID = fopen('RLE_konversi.txt', 'w');

% Simpan dimensi gambar di baris pertama file
fprintf(fileID, '%d %d %d\n', rows, cols, channels);

% Proses encoding RLE per saluran warna
for channel = 1:channels
    % Ambil saluran warna (grayscale: 1 channel, RGB: per channel)
    I_channel = I(:, :, channel);
    
    % Luruskan matriks menjadi vektor 1D
    I_vector = I_channel(:);
    
    % Mulai encoding
    rle = [];
    currPixel = I_vector(1); % Pixel pertama
    count = 0;
    
    for i = 1:length(I_vector)
        if I_vector(i) == currPixel
            count = count + 1;
        else
            rle = [rle, currPixel, count];
            currPixel = I_vector(i);
            count = 1;
        end
    end
    
    % Tambahkan pasangan nilai terakhir
    rle = [rle, currPixel, count];
    
    % Simpan hasil encoding untuk saluran saat ini ke file
    fprintf(fileID, '%d ', rle);
    fprintf(fileID, '\n'); % Tambahkan baris baru untuk memisahkan saluran
end

fclose(fileID);

% Tampilkan pesan berhasil
msgbox('Data RLE berhasil dikompresi dan disimpan sebagai "RLE_konversi.txt".', 'Sukses');
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
