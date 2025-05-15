function varargout = Kompersi(varargin)
% Kompersi MATLAB code for Kompersi.fig
%      Kompersi, by itself, creates a new Kompersi or raises the existing
%      singleton*.
%
%      H = Kompersi returns the handle to a new Kompersi or the handle to
%      the existing singleton*.
%
%      Kompersi('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Kompersi.M with the given input arguments.
%
%      Kompersi('Property','Value',...) creates a new Kompersi or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Kompersi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Kompersi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Kompersi

% Last Modified by GUIDE v2.5 11-Apr-2025 17:33:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Kompersi_OpeningFcn, ...
                   'gui_OutputFcn',  @Kompersi_OutputFcn, ...
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


% --- Executes just before Kompersi is made visible.
function Kompersi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Kompersi (see VARARGIN)

% Choose default command line output for Kompersi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Kompersi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Kompersi_OutputFcn(hObject, eventdata, handles) 
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

% Inisialisasi file untuk menyimpan hasil encoding RLE
fileID = fopen('RLE_konversi_rgb.txt', 'w');

% Proses setiap saluran warna (R, G, B)
for channel = 1:3
    % Ambil saluran warna
    I_channel = I(:, :, channel);
    
    % Konversi saluran warna ke vektor
    I_vector = I_channel(:);
    
    % Run-Length Encoding (RLE)
    rle = [];
    currpixel = I_vector(1); % Pixel pertama
    count = 0;
    
    for i = 1:length(I_vector)
        if I_vector(i) == currpixel
            count = count + 1;
        else
            rle = [rle, currpixel, count];
            currpixel = I_vector(i);
            count = 1;
        end
    end
    
    % Tambahkan pasangan nilai terakhir
    rle = [rle, currpixel, count];
    
    % Simpan hasil encoding ke file (tambahkan saluran ke file)
    fprintf(fileID, '%d ', rle);
    fprintf(fileID, '\n'); % Tambahkan newline untuk memisahkan saluran
end

fclose(fileID);

% Tampilkan pesan berhasil
msgbox('Data RLE telah dikompresi dan disimpan di folder proyek dengan nama "RLE_konversi_rgb.txt"', 'Sukses');
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
