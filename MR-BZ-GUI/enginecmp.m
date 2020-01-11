%%---function to compare engine of user car with new car model based on thier efficiencies
%%---fucntion will return overall efficiencies as -1  if the car is.......
%%---insuffient to produce  any result............
%-------------------------------------------------------------------------%
function ovrlleff = enginecmp(handles,value)
%% finding data....cc bhp mileage rpm and maxtorque for both new and old engine

try 
cc1=find(strcmp('cc',handles.datacar(1,:))); %comparing CC of 2 engines
cc2=find(strcmp('cc',handles.datauser(1,:)));
ccold=str2num(handles.datauser{2,cc2});
ccnew=str2num(handles.datacar{handles.carnumsort(value),cc1});

bhp1=find(strcmp('bhp',handles.datacar(1,:))); %comparing CC of 2 engines
bhp2=find(strcmp('bhp',handles.datauser(1,:)));
bhpold=str2num(handles.datauser{2,bhp2});
bhpnew=str2num(handles.datacar{handles.carnumsort(value),bhp1});

mlg1=find(strcmp('mileage',handles.datacar(1,:))); %comparing CC of 2 engines
mlg2=find(strcmp('mileage',handles.datauser(1,:)));
mlgold=str2num(handles.datauser{2,mlg2});
mlgnew=str2num(handles.datacar{handles.carnumsort(value),mlg1});

rpm1=find(strcmp('rpm',handles.datacar(1,:))); %comparing CC of 2 engines
rpm2=find(strcmp('rpm',handles.datauser(1,:)));
rpmold=str2num(handles.datauser{2,rpm2});
rpmnew=str2num(handles.datacar{handles.carnumsort(value),rpm1});

trq1=find(strcmp('torque',handles.datacar(1,:))); %comparing CC of 2 engines
trq2=find(strcmp('torque',handles.datauser(1,:)));
trqold=str2num(handles.datauser{2,trq2});
trqnew=str2num(handles.datacar{handles.carnumsort(value),trq1});

ff1 = find(strcmp('fuel type',handles.datacar(1,:)));
ff2 = find(strcmp('fuel type',handles.datauser(1,:)));

%---------------------Difference between petrol and diesel--------------%
%---------------------specific density and air fuel ratio differs------%
%--------------------for petrol air fuel ratio(taken)= 12.6------------------%
%--------------------for diesel air fuel ratio(taken)= 14.7-------------%
%------------------data taken corresponding to maximum combustion-------%

if handles.datacar{handles.carnumsort(value),ff1} == 'P'  %% this compares whether the car model is petrol or diese 
    K1 = 0.39132 ;                                         %% assigns constants accordingly 
    K2 = 578.931;
else
    K1 = 0.48777;
    K2 = 675.4195;
end
 
if handles.datacar{2,ff1} == 'P' %% this finds whether the car model is petrol or diesel 
    k1 = 0.39132 ;                                         %% assigns constants accordingly 
    k2 = 578.931;
else
    k1 = 0.48777;
    k2 = 675.4195;
end
 
%% calculating fuel flow rate of both engine ----
ffold= (rpmold/mlgold)*k1;
ffnew= (rpmnew/mlgnew)*K1;

%% calculating effeiciencies ---- thermal, volumetric and engine performance coefficient of both engines ----
teold= 0.1339*(bhpold/ffold);
tenew= 0.1339*(bhpnew/ffnew);

veold= (k2*ffold)/(ccold*rpmold);
venew= (K2*ffnew)/(ccnew*rpmnew);

bhepold= (12.48*trqold)/ccold ;
bhepnew= (12.48*trqnew)/ccnew ;

epcold= (bhpold*122.05)/(rpmold*ccold);
epcnew= (bhpnew*122.05)/(rpmnew*ccnew);

%----------------------------------------------------------------------%
%% calculating overall efficiency ratio of new engine and old engine

ovrlleff= (tenew*venew*bhepnew*epcnew)/(teold*veold*bhepold*epcold); 
catch
    errordlg('DATA NOT CONSISTENT With FORMAT PLEASE Check the Data and ReUpload..','ERROR FOUND');
    ovrlleff = -1;
end



