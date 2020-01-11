function activation(hObject,select,handles)
switch select
    case 'eraseall'
        if isfield(handles,'datauser') || isfield(handles,'datacar')
            field={'datacar','datauser'};
            handles = rmfield(handles,field);
        end
       set(handles.BtnUpCarData,'BackgroundColor','black','ForegroundColor','white');
       set(handles.BtnUpUsrData,'BackgroundColor','black','ForegroundColor','white');
       set(handles.recomodel,'Data','')
       set(handles.txtcurrent,'Visible','off')
       set(handles.uicurrentcar,'Visible','off')
       set(handles.selectmodel,'Visible','off')
       set(handles.topmodels,'Visible','off')
       set(handles.oldemi,'String','')
       set(handles.new_emi,'String','')
       set(handles.interest,'String','')      
       set(handles.principal,'String','')
       set(handles.total,'String','')
       set(handles.rate,'String','')
       set(handles.time,'String','')
       set(handles.downpay,'String','')
       set(handles.offer,'String','','BackgroundColor',[0.5 0.5 0.5])
    
    case 'erasefinance'
       set(handles.oldemi,'String','')
       set(handles.new_emi,'String','')
       set(handles.interest,'String','')      
       set(handles.principal,'String','')
       set(handles.total,'String','')
       set(handles.rate,'String','')
       set(handles.time,'String','')
       set(handles.downpay,'String','')
       set(handles.offer,'String','','BackgroundColor',[0.5 0.5 0.5])
end
 guidata(hObject,handles)