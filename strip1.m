% Strip Chart first Written Test

% Be aware that this code is currently not backwards compatible past 2014b

close all;
clear all;

% Given constant limits

%VMax = 10;
%VMin = 0;
%AMax = 4;
%AMin = 0;
%TMax = 200;
%TMin = -55;
iniSize = 8;

% Read in the .ini file

filename = 'QB50.ini'; % default .ini file
Initializations = importdata(filename);
textIni = Initializations.textdata();
dataIni = Initializations.data();
Inputs = length(textIni);
if Inputs ~= iniSize
    error('Invalid .ini file, consult the documentation to make sure you have 8 fields.');
    return
end

% Parse the .ini file

for i = 1:iniSize
    n = textIni{i};
    curdat = dataIni(i);
    switch n
        case 'VMax'
            VMax = curdat;
        case 'VMin'
            VMin = curdat;
        case 'AMax'
            AMax = curdat;
        case 'AMin'
            AMin = curdat;
        case 'TMax'
            TMax = curdat;
        case 'TMin'
            TMin = curdat;
        case 'PacketTime'
            str = curdat;
        case 'MaxPackets'
            str2 = curdat;
        otherwise
            n
            Error('Above .ini field is not valid at this time.')
            return
    end
end
 
 % The arrays needed to 'prime' the plot

 maxStripVal = floor(str2/str);
 x = 1:maxStripVal;
 x2 = 0*ones(maxStripVal,1);
 
 % Setting up the initial plots with the limits hidden
 
 figure1 = figure;
 subplot(3,1,1);
 hold on;
 VXLine = plot(x,x2*VMax,'w');
 VILine = plot(x,x2*VMin,'w');
 hLine = plot(x,x2*VMin); % EPS 8V4 Voltage
 hLine2 = plot(x,x2*VMin); % EPS 5V Voltage
 hLine3 = plot(x,x2*VMin); % EPS 3V3 Voltage
 hLine4 = plot(x,x2*VMin); % PV1 Voltage
 hLine5 = plot(x,x2*VMin); % PV2 Voltage
 hLine6 = plot(x,x2*VMin); % Battery Voltage
 hLine7 = plot(x,x2*VMin); % Fuel Gauge VCELL
 hLine8 = plot(x,x2*VMin); % CDH 5V Voltage
 hLine9 = plot(x,x2*VMin); % CDH Battery Voltage
 hLine10 = plot(x,x2*VMin); % INMS 5V Voltage
 hLine11 = plot(x,x2*VMin); % INMS 3V5 Voltage
 hLine12 = plot(x,x2*VMin); % INMS TH Voltage
 set(gca,'XTick',[]);
 title('Voltage')
 ylabel('Voltage (V)')
 subplot(3,1,2);
 hold on;
 AXLine = plot(x,x2*AMax,'w');
 AILine = plot(x,x2*AMin,'w');
 hLine13 = plot(x,x2*AMin); % EPS 8V4 Current
 hLine14 = plot(x,x2*AMin); % EPS 5V Current
 hLine15 = plot(x,x2*AMin); % EPS 3V3 Current
 hLine16 = plot(x,x2*AMin); % PV1 Current
 hLine17 = plot(x,x2*AMin); % PV2 Current
 hLine18 = plot(x,x2*AMin); % Battery IC
 hLine19 = plot(x,x2*AMin); % Battery ID
 hLine20 = plot(x,x2*AMin); % INMS 5V Current
 hLine21 = plot(x,x2*AMin); % INMS 3V5 Current
 hLine22 = plot(x,x2*AMin); % INMS TH Current
 set(gca,'XTick',[]);
 title('Current')
 ylabel('Current (A)')
 subplot(3,1,3);
 hold on;
 TXLine = plot(x,x2*TMax,'w');
 TILine = plot(x,x2*TMin,'w');
 hLine23 = plot(x,x2*TMin); % Battery T1
 hLine24 = plot(x,x2*TMin); % Battery T2
 hLine25 = plot(x,x2*TMin); % T3
 hLine26 = plot(x,x2*TMin); % T1
 hLine27 = plot(x,x2*TMin); % T2
 hLine28 = plot(x,x2*TMin); % 8.5 V Board Temperature
 hLine29 = plot(x,x2*TMin); % 3V5/5V Board Temperature
 hLine30 = plot(x,x2*TMin); % CDH Temperature
 hLine31 = plot(x,x2*TMin); % Com Temperature
 title('Temperature')
 ylabel('Temperature (C)')
 
 % Setting up the data tables
 
 figure2 = figure('Position', [100 100 752 250]);
 columnname = {'Hardware Label', 'Value'};
 d = {'EPS 8V4 Voltage' 0}; 
 t = uitable('Parent',figure2,'Position', [25 50 700 200], ...
    'ColumnName',columnname, ...
    'Data', d);
 
 figure(figure1); % pass focus back to the main strip charts for now
 
 % Setting up for the loop
 
 continuer = 1;
 i = 1;
 
 % Adding the stop button
 
 pos = get(gcf,'pos');
 C = uicontrol('String','Stop','Callback','continuer = 0;');
 C.Position = [(pos(3)/2)-20 10 60 20];
 
 % Opening the Logging Methods
 
 curver = version('-release');
 
 if strcmp(curver,'2014b') | strcmp(curver,'2015a') | strcmp(curver,'2015b')
    curver
    DateString = datestr(datetime('now'),'mmddyyyyHHMMSS');
    filename = ['HouseKeepingLog' DateString '.log']
    %dlmwrite(filename,data) - Demo of how to use the log file in the program
 else
    curver
    % Here is where the older logfile creation will go
 end
 % Running the main loop
 
 StripChart('Initialize',gca,'Packets')
 %set(gcf, 'Position', get(0,'Screensize'));
 while(continuer)
    z = sin(2*pi*i/1000)+2;
    z2 = -1*z;
    StripChart('Update',VXLine,VMax);
    StripChart('Update',VILine,VMin);
    StripChart('Update',hLine,z)
    StripChart('Update',AXLine,AMax);
    StripChart('Update',AILine,AMin);
    StripChart('Update',hLine2,z2+5)
    StripChart('Update',TXLine,TMax);
    StripChart('Update',TILine,TMin);
    StripChart('Update',hLine3,20*z)
    StripChart('Update',hLine4,20*z2)
    pos = get(gcf,'pos');
    C.Position = [(pos(3)/2)-20 10 60 20];
    newdata = {'EPS 8V4 Voltage' z};
    set(t,'Data',newdata); % This is how we update the table
    drawnow
    i = i+1;
 end