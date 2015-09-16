% Strip Chart first Written Test

close all;
clear all;

% Given constant limits

VMax = 10;
VMin = 0;
AMax = 4;
AMin = 0;
TMax = 200;
TMin = -55;

 x = 1:1000;
 x2 = ones(1000,1);
 y = 3*sin(2*pi*x/1000);
 subplot(3,1,1);
 hold on;
 VXLine = plot(x,x2*VMax,'w');
 VILine = plot(x,x2*VMin,'w');
 hLine = plot(x,y);
 set(gca,'XTick',[]);
 title('Voltage')
 ylabel('Voltage (V)')
 subplot(3,1,2);
 hold on;
 AXLine = plot(x,x2*AMax,'w');
 AILine = plot(x,x2*AMin,'w');
 hLine2 = plot(x,y);
 set(gca,'XTick',[]);
 title('Current')
 ylabel('Current (A)')
 subplot(3,1,3);
 hold on;
 TXLine = plot(x,x2*TMax,'w');
 TILine = plot(x,x2*TMin,'w');
 hLine3 = plot(x,y);
 hLine4 = plot(x,y);
 title('Temperature')
 ylabel('Temperature (C)')
 continuer = 1;
 pos = get(gcf,'pos')
 C = uicontrol('String','Stop','Callback','continuer = 0');
 C.Position = [(pos(3)/2)-30 10 60 20];
 C.Position
 StripChart('Initialize',gca,'Time (s)')
 %set(gcf, 'Position', get(0,'Screensize'));
 i = 1;
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
    StripChart('Update',hLine3,z)
    StripChart('Update',hLine4,z2)
    drawnow
    i = i+1;
 end