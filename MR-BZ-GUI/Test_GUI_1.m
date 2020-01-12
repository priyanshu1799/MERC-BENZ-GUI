function varargout = Test_GUI_1(varargin)
% TEST_GUI_1 MATLAB code for Test_GUI_1.fig
%      TEST_GUI_1, by itself, creates a new TEST_GUI_1 or raises the existing
%      singleton*.
% 
%      H = TEST_GUI_1 returns the handle to a new TEST_GUI_1 or the handle to
%      the existing singleton*.
%
%      TEST_GUI_1('CALLBACK',hObject,eventData,handles,...)  calls the local
%      function named CALLBACK in TEST_GUI_1.M with the given input arguments.
%
%      TEST_GUI_1('Property','Value',...) creates a new TEST_GUI_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Test_GUI_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Test_GUI_1_OpeningFcn via varargin.
%      
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)". 
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Test_GUI_1

% Last Modified by GUIDE v2.5 11-Jan-2020 17:07:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Test_GUI_1_OpeningFcn, ...
                   'gui_OutputFcn',  @Test_GUI_1_OutputFcn, ...
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

% End initializa    tion code - DO NOT EDIT


% --- Executes just before Test_GUI_1 is made visible.
function Test_GUI_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Test_GUI_1 (see VARARGIN)
    
% Choose default command line output for Test_GUI_1
%% this function is executed every time we open GUI. 
handles.output = hObject;
%Setting up the background and logo of GUI

myImage = imread('back2.jpg');
ah = axes('unit','normalized','position',[0 0 1 1]);
imagesc(myImage);
set(ah,'handlevisibility','off','visible','off');
uistack(ah,'bottom')


myImage = imread('download.png');
axes(handles.axes3);
imshow(myImage);
axis off
 % Update handles structure
guidata(hObject, handles); 



% UIWAIT makes Test_GUI_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Test_GUI_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in BtnUpCarData.
%% -----function to read all car models, data in form of a table 
function BtnUpCarData_Callback(hObject, eventdata, handles)
% hObject    handle to BtnUpCarData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.data=hObject;
try %%--
if get(hObject,'Value')
[FileName,PathName] = uigetfile('*.*','Open File to Upload car Models data set available');
if ~(FileName==0)
C = table2cell(readtable(fullfile(PathName,FileName), 'ReadVariableNames',false)); %%reading car data

%%--creating field datacar in handles struct. so as to import and export data easily b/w function

handles.datacar=C(:,:); 
set(handles.BtnUpCarData,'BackgroundColor','green','ForegroundColor','black');
end 
end

%---------any errror catched in reading data file in displayed--------------%
catch
    msgbox('Input the data in .xls or .csv format','Not Readable')
end
guidata(hObject,handles)





% --- Executes on button press in BtnUpUsrData.
%% -----function to read customer's data including his current financial contract details, in form of a table 
function BtnUpUsrData_Callback(hObject, eventdata, handles)
% hObject    handle to BtnUpUsrData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.data=hObject;
try
if get(hObject,'Value')
    [FileName,PathName] = uigetfile('*.*','Open File to Upload Customers car data and current financial contract');
if ~(FileName==0)
U = table2cell(readtable(fullfile(PathName,FileName),'ReadVariableNames',false)); %U for User Data reading

%%--creating field datauser in handles struct.. so as to import and export data easily b/w functions

handles.datauser=U(:,:); %%creating global variable so the data can be used throughout the program
set(handles.BtnUpUsrData,'BackgroundColor','green','ForegroundColor','black');

end
end
catch
        msgbox('Input the data in .xls or .csv format','Not Readable')
end
guidata(hObject,handles)




% --- Executes on button press in BtnUpModel.
% ---------------------------------------------------------- %
%% -------function to compare old and new car models and display the offer details with new financing options 
%------------------------------------------------------------%
function BtnUpModel_Callback(hObject, eventdata, handles)

if isfield(handles,'datauser') && isfield(handles,'datacar')

    if ~(isempty(handles.datauser) || isempty(handles.datacar))
    
        handles.a = find(strcmp('price',handles.datacar(1,:))); %finding the column of price models dataset 

    if ~(handles.a == 0)
    
     [m n]=find(strcmp(handles.datauser(2,2),handles.datacar)); %finding row of customer car

     if ~(m==0)
      handles.carprice=str2num(handles.datacar{m,handles.a});
      
      %sorting on the basis of price of old car
      
      [data1]=price_short(handles.datacar(:,handles.a),handles.carprice);
      handles.carnumsort=data1; %creating handles field of cars row no. to be sorted and can be used ...
                                %further in the program
      handles.datasort= handles.datacar(data1,:);

    [n m]=size(handles.datasort);

    for i=1:n
    ovrlleff=enginecmp(handles,i);  % engine comparison.
       if ovrlleff>=0
           datanew(i,1)=ovrlleff; % making data set of efficiencies in order of the
       else
           break;
       end
    end
    
    if exist('datanew')
      sortlist=cat(2,handles.datasort,num2cell(datanew));
      handles.datasort1=sortrows(sortlist,m+1,'descend');
      set(handles.recomodel,'Data',handles.datasort1(1:3,:),'ColumnName',cat(2,handles.datacar(1,:),'efficiency_ratio')); 
      handles.mdl=find(strcmp('model',handles.datacar(1,:)));
      set(handles.topmodels,'Enable','on');
      set(handles.topmodels,'String',handles.datasort1(1:3,handles.mdl),'Value',1);
      current_car_model(handles)
      topmodels_Callback(hObject, eventdata, handles);
      
    else
        
        msgbox('DATA ENCAPABLE OF RESULT')
        activation(hObject,'eraseall',handles)


    end
        else
            msgbox('No old car model found in car database matching customers car...Want to use old price options','ERROR');
            
            activation(hObject,'eraseall',handles);
            
    end
     
    else
    msgbox('No price section found Please reupload the correct Data','Wrong File');
    activation(hObject,'eraseall',handles);


    end
    
    
    else
    msgbox("Customer's Data or Models data has not been inputted  ");
    
    end
else
        msgbox("Customer's Data or Models data has not been inputted  ");
        
end
guidata(hObject,handles)




% --- Executes on button press in Refinance.
function Refinance_Callback(hObject, eventdata, handles)
% hObject    handle to Refinance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try

trm  = find(strcmp('term',handles.datauser(1,:)));
dpy  = find(strcmp('downpayment',handles.datauser(1,:)));
rt  = find(strcmp('rate',handles.datauser(1,:)));
dt  = find(strcmp('datepurchase',handles.datauser(1,:)));
term = str2num(handles.datauser{2,trm});
dpay = str2num(handles.datauser{2,dpy});
rate = str2num(handles.datauser{2,rt});
date1 = handles.datauser{2,dt};
loan = handles.carprice-dpay;
emi1=emicalc(loan,rate,term);
date2=datestr(now,'mm/dd/yyyy');
mon = monthsused(date1,date2);
mn=mon;
c=0;     %flag value
for dpay =20:40   %%minimun downpayment allowed is 20% and max limit is 40%
    mon=mn;  
 for i=1:term
   outstanding= emi1*(term-mon);
      
   cost_aftr_dpay= outstanding + (1-(dpay/100))*str2num(handles.datasort1{get(handles.topmodels,'Value'),handles.a});
     %downpayment is caluclated based on the priece of new car 
     
   emi2 =emicalc(cost_aftr_dpay,rate,term);
   if emi2 < (1.3*emi1)
       break;
   else
       mon=mon+1;
   end
   
 end
 
    if mon<term  %% if his offer is satisfied before the completion of  term
      c=1 ; %% if any downpayment satisfies the criteria then flag value is changed
      break;
    end
end

if c==1   %% checking whether any downpayment value satisfies the criteria(emi2 < 1.3*emi1) 
     set(handles.downpay,'Visible','on')
     set(handles.downpay,'String',[num2str(dpay),' %'])
     set(handles.offer,'String',(sprintf("%s%d%s",'Upgradation Can be Offered after ', mon-mn ,' months')),...
        'BackgroundColor','yellow','ForegroundColor','black');
    
       set(handles.oldemi,'String',addComma(emi1)); 
       set(handles.new_emi,'String',addComma(emi2));
       set(handles.interest,'String',addComma((emi2*term-cost_aftr_dpay)));
       set(handles.principal,'String',addComma(cost_aftr_dpay))
       set(handles.total,'String',addComma(emi2*term));
       set(handles.time,'String',[num2str(term),' months']);
       set(handles.rate,'String',[num2str(rate),' %']);
else
    
    msgbox('No financial options look feasible for this one...Try choosing other car model')
    activation(hObject,'erasefinance',handles);
end

catch
    errordlg('Financial Details of Customer INVALID or NOT FOUND..Refinancing UNDONE','Data error')
        activation(hObject,'erasefinance',handles);

end
    



% --- Executes on selection change in topmodels.
function topmodels_Callback(hObject, eventdata, handles)
% hObject    handle to topmodels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns topmodels contents as cell array
%        contents{get(hObject,'Value')} returns selected item from topmodels

set(handles.topmodels,'Visible','on')
set(handles.selectmodel,'Visible','on')
set(handles.uicurrentcar,'Visible','on')
set(handles.txtcurrent,'Visible','on')
value= get(hObject,'Value');
set(handles.Refinance,'Enable','on')
set(handles.model,'String',handles.datasort1(value,handles.mdl));
set(handles.price,'String',['RS. ',addComma(str2num(handles.datasort1{value,handles.a}))]);
ftyp=find(strcmp('fuel type',handles.datacar(1,:)));
mlg=find(strcmp('mileage',handles.datacar(1,:)));
tpspd=find(strcmp('top speed',handles.datacar(1,:)));
if handles.datasort1{value,ftyp}=='P'
    fuel='Petrol ';
else
    fuel='Diesel';
end
set(handles.fuel,'String',fuel);
set(handles.mlg,'String',sprintf('%s%s',handles.datasort1{value,mlg},' km/ltr'));
set(handles.topspeed,'String',sprintf('%s%s',handles.datasort1{value,tpspd},' km/hr'));
Refinance_Callback(hObject, eventdata, handles)
guidata(hObject,handles)




%% this fucntion shows current car details of the customer
function current_car_model(handles)

md=find(strcmp('model',handles.datauser(1,:)));
custName=find(strcmp('customer name',handles.datauser(1,:)));
price=find(strcmp('price',handles.datauser(1,:)));
a=[custName md price];
set(handles.uicurrentcar,'Data',handles.datauser(2,a));
set(handles.uicurrentcar,'ColumnName',handles.datauser(1,a));


% --- Executes on button press in erase
%% function callback to Erase all inputted data in the software.....
function erase_Callback(hObject, eventdata, handles)
% hObject    handle to erase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

activation(hObject,'eraseall',handles)
msgbox('Enter new Data of both Customer and Models','Welcome');










%% ----------------------------------------------------------------------%%
%%-----------------------------------------------------------------------%%
%%-------------------------functions below this belt are used to---------%%
%%-------------------------perform various GUI operations----------------%%
%-------------------like creating, callback &deletion of objects ---------%
%% ----------------------------------------------------------------------%%








  


function rate_Callback(hObject, eventdata, handles)
% hObject    handle to rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rate as text
%        str2double(get(hObject,'String')) reurns contents of rate as a double


% --- Executes during object creation, after setting all properties.
function rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time_Callback(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time as text
%        str2double(get(hObject,'String')) returns contents of time as a double


% --- Executes during object creation, after setting all properties.
function time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function loan_Callback(hObject, eventdata, handles)
% hObject    handle to loan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of loan as text
%        str2double(get(hObject,'String')) returns contents of loan as a double


% --- Executes during object creation, after setting all properties.
function loan_CreateFcn(hObject, eventdata, handles)
% hObject    handle to loan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to principal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of principal as text
%        str2double(get(hObject,'String')) returns contents of principal as a double


% --- Executes during object creation, after setting all properties.
function principal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to principal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total as text
%        str2double(get(hObject,'String')) returns contents of total as a double


% --- Executes during object creation, after setting all properties.
function total_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to interest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of interest as text
%        str2double(get(hObject,'String')) returns contents of interest as a double



% --- Executes during object creation, after setting all properties.
function interest_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to new_emi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of new_emi as text
%        str2double(get(hObject,'String')) returns contents of new_emi as a double



% --- Executes during object creation, after setting all properties.
function new_emi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to new_emi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function recomodel_CellSelectionCallback(hObject, eventdata, handles)


function figure1_DeleteFcn(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function topmodels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to topmodels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on text change in downpay.
function downpay_Callback(hObject, eventdata, handles)
% hObject    handle to downpay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function downpay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to downpay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object deletion, before destroying properties.
% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AllMyTimers = timerfind('Tag', 'myTimers');
if ~isempty(AllMyTimers)
     stop( AllMyTimers );
     delete(AllMyTimers);
end
% Hint: delete(hObject) closes the figure
delete(hObject);
