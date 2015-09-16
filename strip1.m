% Strip Chart first Written Test

close all;
clear all;

 x = 1:1000;
 y = 3*sin(2*pi*x/1000);
 subplot(3,1,1);
 hLine = plot(x,y);
 set(gca,'XTick',[]);
 title('Voltage')
 ylabel('Voltage (V)')
 subplot(3,1,2);
 hLine2 = plot(x,y);
 set(gca,'XTick',[]);
 title('Current')
 ylabel('Current (A)')
 subplot(3,1,3);
 hLine3 = plot(x,y);
 title('Temperature')
 ylabel('Temperature (C)')
 continuer = 1;
 C = uicontrol('String','Stop','Callback','continuer = 0');
 StripChart('Initialize',gca,'Time (s)')
 i = 1;
 while(continuer)
    z = sin(2*pi*i/1000);
    z2 = -1*z;
    StripChart('Update',hLine,z)
    StripChart('Update',hLine2,z2)
    StripChart('Update',hLine3,z)
    drawnow
    i = i+1;
 end