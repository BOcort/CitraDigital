function varargout = rotate(varargin)
% rotate MATLAB code for rotate.fig
%      rotate, by itself, creates a new rotate or raises the existing
%      singleton*.
%
%      H = rotate returns the handle to a new rotate or the handle to
%      the existing singleton*.
%
%      rotate('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in rotate.M with the given input arguments.
%
%      rotate('Property','Value',...) creates a new rotate or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rotate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rotate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rotate

% Last Modified by GUIDE v2.5 11-Apr-2025 23:27:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rotate_OpeningFcn, ...
                   'gui_OutputFcn',  @rotate_OutputFcn, ...
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


% --- Executes just before rotate is made visible.
function rotate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rotate (see VARARGIN)

% Choose default command line output for rotate
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rotate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rotate_OutputFcn(hObject, eventdata, handles) 
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

% Tentukan sudut rotasi
T = 45; % Sudut rotasi dalam derajat

% Dapatkan ukuran gambar
[m, n, dim] = size(I);

% Menentukan pusat rotasi (Xp, Yp)
Xp = round(m / 2);
Yp = round(n / 2);

% Matriks koordinat asli
[X, Y] = meshgrid(1:n, 1:m);

% Matriks koordinat baru setelah rotasi
Xrot = round(Xp + (X - Xp) * cosd(T) - (Y - Yp) * sind(T));
Yrot = round(Yp + (X - Xp) * sind(T) + (Y - Yp) * cosd(T));

% Buat matriks kosong untuk citra hasil rotasi
J = zeros(size(I), 'like', I);

% Memasukkan piksel ke koordinat baru
for x = 1:m
    for y = 1:n
        if Xrot(x, y) > 0 && Xrot(x, y) <= n && ...
                Yrot(x, y) > 0 && Yrot(x, y) <= m
            J(Yrot(x, y), Xrot(x, y), :) = I(x, y, :);
        end
    end
end

% Tampilkan hasil rotasi di axes2
set(open.figure1, 'CurrentAxes', open.axes2);
imshow(J); % Menampilkan hasil rotasi
set(open.axes2, 'Userdata', J);
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
