function varargout = Decoding(varargin)
% Decoding MATLAB code for Decoding.fig
%      Decoding, by itself, creates a new Decoding or raises the existing
%      singleton*.
%
%      H = Decoding returns the handle to a new Decoding or the handle to
%      the existing singleton*.
%
%      Decoding('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Decoding.M with the given input arguments.
%
%      Decoding('Property','Value',...) creates a new Decoding or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Decoding_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Decoding_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Decoding

% Last Modified by GUIDE v2.5 11-Apr-2025 20:26:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Decoding_OpeningFcn, ...
    'gui_OutputFcn',  @Decoding_OutputFcn, ...
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


% --- Executes just before Decoding is made visible.
function Decoding_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Decoding (see VARARGIN)

% Choose default command line output for Decoding
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Decoding wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Decoding_OutputFcn(hObject, eventdata, handles)
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

% Pilih file teks untuk decoding
[filename, filepath] = uigetfile('*.txt', 'Pilih File RLE untuk Dekompresi');
if isequal(filename, 0) || isequal(filepath, 0)
    % Jika file tidak dipilih
    errordlg('Anda belum memilih file!', 'Error');
    return;
end
fullpath = fullfile(filepath, filename);

% Baca file teks yang dipilih
fileID = fopen(fullpath, 'r');
if fileID == -1
    % Jika file tidak dapat dibuka
    errordlg('Tidak dapat membuka file yang dipilih!', 'Error');
    return;
end

% Baca dimensi gambar dari baris pertama file
rows = fscanf(fileID, '%d', 1); % Baris
cols = fscanf(fileID, '%d', 1); % Kolom
channels = fscanf(fileID, '%d', 1); % Saluran warna (grayscale: 1, RGB: 3)

% Inisialisasi matriks untuk hasil dekompresi
Decompressed = zeros(rows, cols, channels, 'uint8');

% Dekompresi RLE untuk setiap saluran
for channel = 1:channels
    % Baca data RLE dari file
    rle = fscanf(fileID, '%d', [1, Inf]);
    
    % Inisialisasi data saluran
    channel_data = zeros(rows, cols);
    index = 1;
    kali = 0;
    
    % Dekompresi menggunakan data RLE
    for x = 1:rows
        for y = 1:cols
            % Validasi panjang array RLE
            if index + 1 > length(rle)
                errordlg('Data RLE tidak cukup untuk mendekompresi gambar ini!', 'Error');
                fclose(fileID);
                return;
            end
            
            kali = kali + 1;
            if kali == rle(index + 1)
                channel_data(x, y) = rle(index); % Simpan nilai piksel
                index = index + 2; % Pindah ke pasangan berikutnya
                kali = 0; % Reset penghitung
            else
                channel_data(x, y) = rle(index); % Nilai piksel tetap
            end
        end
    end
    
    % Simpan hasil dekompresi saluran ke matriks hasil
    Decompressed(:, :, channel) = uint8(channel_data);
end

fclose(fileID);

% Tampilkan hasil dekompresi di axes2
set(open.figure1, 'CurrentAxes', open.axes2);
imshow(Decompressed); % Tampilkan gambar hasil
title(['Hasil Dekompresi: ', filename]);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
