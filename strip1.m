% Strip Chart first Written Test

% Use dlmwrite to create a CSV where the reading are logged as we plot.

close all;
clear all;

% Given constant limits

VMax = 10;
VMin = 0;
AMax = 4;
AMin = 0;
TMax = 200;
TMin = -55;
 
 % Query for the Number of Seconds Per Read and the total strip time
 
 continuer2 = 1;
 while continuer2
    str = str2double(input('Enter the time between packets (nearest whole second): ','s'));
    if isnan(str) || fix(str) ~= str
        continue;
    else
        continuer2 = 0;
    end
 end
 
 continuer2 = 1;
 while continuer2
    str2 = str2double(input('Enter the total strip time (nearest whole second): ','s'));
    if isnan(str2) || fix(str2) ~= str2
        continue;
    else
        continuer2 = 0;
    end
 end
 
 % The arrays needed to 'prime' the plot

 maxStripVal = floor(str2/str);
 x = 1:maxStripVal;
 x2 = 0*ones(maxStripVal,1);
 
 % Setting up the initial plots with the limits hidden
 
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
 
 % Setting up for the loop
 
 continuer = 1;
 i = 1;
 
 % Adding the stop button
 
 pos = get(gcf,'pos');
 C = uicontrol('String','Stop','Callback','continuer = 0;');
 C.Position = [(pos(3)/2)-20 10 60 20];
 C.Position;
 
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
    StripChart('Update',hLine2,z2)
    StripChart('Update',TXLine,TMax);
    StripChart('Update',TILine,TMin);
    StripChart('Update',hLine3,20*z)
    StripChart('Update',hLine4,20*z2)
    pos = get(gcf,'pos');
    C.Position = [(pos(3)/2)-20 10 60 20];
    drawnow
    i = i+1;
 end