function varargout = EnDeCode(varargin)
% ENDECODE MATLAB code for EnDeCode.fig
%      ENDECODE, by itself, creates a new ENDECODE or raises the existing
%      singleton*.
%
%      H = ENDECODE returns the handle to a new ENDECODE or the handle to
%      the existing singleton*.
%
%      ENDECODE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENDECODE.M with the given input arguments.
%
%      ENDECODE('Property','Value',...) creates a new ENDECODE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EnDeCode_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EnDeCode_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EnDeCode

% Last Modified by GUIDE v2.5 11-Apr-2025 21:22:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EnDeCode_OpeningFcn, ...
                   'gui_OutputFcn',  @EnDeCode_OutputFcn, ...
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


% --- Executes just before EnDeCode is made visible.
function EnDeCode_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EnDeCode (see VARARGIN)

% Choose default command line output for EnDeCode
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes EnDeCode wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EnDeCode_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
set(handles.edit1, 'String', ''); % Reset input teks
set(handles.edit2, 'String', ''); % Reset output encoded
set(handles.edit3, 'String', ''); % Reset efisiensi encoding
set(handles.edit4, 'String', ''); % Reset efisiensi decoding
set(handles.edit5, 'String', ''); % Reset decoded teks
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% Ambil input teks dari Edit Text 1
originalText = get(handles.edit1, 'String');

% Validasi input
if isempty(originalText)
    errordlg('Silakan masukkan teks di Edit Text 1.', 'Error');
    return;
end

encodedText = ''; % Inisialisasi hasil encoding

% Proses encoding menggunakan Run-Length Encoding
while ~isempty(originalText)
    encodedText = [encodedText originalText(1)]; % Tambahkan karakter awal
    count = 1; % Hitung jumlah kemunculan karakter awal
    originalText = originalText(2:end); % Buang karakter awal
    
    % Hitung jumlah kemunculan berturut-turut
    while ~isempty(originalText) && originalText(1) == encodedText(end)
        count = count + 1; % Tambahkan hitungan
        originalText = originalText(2:end); % Hapus karakter berturut-turut
    end
    
    % Tambahkan jumlah ke encodedText
    encodedText = [encodedText num2str(count)];
end

% Hitung efisiensi encoding
originalLength = length(get(handles.edit1, 'String')); % Panjang input asli
encodedLength = length(encodedText); % Panjang hasil encoding
efficiency = encodedLength / originalLength; % Rasio efisiensi

% Tampilkan hasil encoding di Edit Text 2
set(handles.edit2, 'String', encodedText);

% Tampilkan efisiensi di Edit Text 5
set(handles.edit5, 'String', num2str(efficiency));
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% Ambil teks hasil encoding dari Edit Text 4
encodedText = get(handles.edit4, 'String');

% Validasi input
if isempty(encodedText)
    errordlg('Silakan masukkan teks hasil encoding di Edit Text 4.', 'Error');
    return;
end

decodedText = ''; % Inisialisasi hasil decoding

% Proses decoding menggunakan Run-Length Decoding
while ~isempty(encodedText)
    char = encodedText(1); % Ambil karakter pertama
    encodedText = encodedText(2:end); % Hapus karakter pertama
    
    % Ambil jumlah kemunculan karakter
    countStr = '';
    while ~isempty(encodedText) && isstrprop(encodedText(1), 'digit')
        countStr = [countStr encodedText(1)];
        encodedText = encodedText(2:end); % Hapus angka berturut-turut
    end
    
    % Ulangi karakter sesuai jumlah yang ditemukan
    count = str2double(countStr); % Ubah jumlah ke angka
    decodedText = [decodedText repmat(char, 1, count)];
end

% Tampilkan hasil decoding di Edit Text 3
set(handles.edit3, 'String', decodedText);
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
