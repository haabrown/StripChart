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

for i = 1:8
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
 hLine = plot(x,x2*VMin);
 set(gca,'XTick',[]);
 title('Voltage')
 ylabel('Voltage (V)')
 subplot(3,1,2);
 hold on;
 AXLine = plot(x,x2*AMax,'w');
 AILine = plot(x,x2*AMin,'w');
 hLine2 = plot(x,x2*AMin);
 set(gca,'XTick',[]);
 title('Current')
 ylabel('Current (A)')
 subplot(3,1,3);
 hold on;
 TXLine = plot(x,x2*TMax,'w');
 TILine = plot(x,x2*TMin,'w');
 hLine3 = plot(x,x2*TMin);
 hLine4 = plot(x,x2*TMin);
 title('Temperature')
 ylabel('Temperature (C)')
 
 % Setting up the data tables
 
 figure2 = figure('Position', [100 100 752 250]);
 t = uitable('Parent',figure2,'Position', [25 50 700 200]);
 
 figure(figure1); % pass focus back to the main strip charts for now
 
 % Setting up for the loop
 
 continuer = 1;
 i = 1;
 
 % Adding the stop button
 
 pos = get(gcf,'pos');
 C = uicontrol('String','Stop','Callback','continuer = 0;');
 C.Position = [(pos(3)/2)-20 10 60 20];
 
 % Opening the Logging Methods
 
 DateString = datestr(datetime('now'),'mmddyyyyHHMMSS');
 filename = ['HouseKeepingLog' DateString '.log']
 %dlmwrite(filename,data) - Demo of how to use the log file in the program
 
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
    drawnow
    i = i+1;
 end