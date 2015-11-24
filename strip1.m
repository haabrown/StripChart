% This is the main code that generates and maintains the strip charts as
% needed for the QB50 sensor testing/monitoring.

close all;
clear all;
delete(instrfindall); % needed to avoid locking up the serial port

% Version Check

curver = version('-release');

% Given constant limits

found = 0; % serial port not found
iniSize = 10; % number of values that should be in the .ini file
Timeout = 60; % wait a full minute before giving up on the serial port. 
SolarCatcher = -982;    % a special voltage for the solar temps
labels = {'EPS 8V4 Voltage';'EPS 5V Voltage';'EPS 3V3 Voltage';...
    'PV1 Voltage';'PV2 Voltage';'Battery Voltage';...
    'Fuel Gauge VCELL';'CDH 5V Voltage';'CDH Battery Voltage';...
    'INMS 5V Voltage';'INMS 3V5 Voltage';...
    'EPS 8V4 Current';'EPS 5V Current';'EPS 3V3 Current';...
    'PV1 Current';'PV2 Current';'Battery IC';'Battery ID';...
    'INMS 5V Current';'INMS 3V5 Current';...
    'Battery T1';'Battery T2';'T3';'T1';'T2';'8.5 V Board Temperature';...
    '3V5/5V Board Temperature';'CDH Temperature';'Comm Temperature';...
    'INMS TH Temperature';}; % names of the phyical values
datum = cell(30,1); % place to store the physical values
datum(:) = {0}; % initialzing the datum
data = [labels,datum]; % NEVER CHANGE THIS

% Read in the .ini file

filename = 'QB50.ini'; % default .ini file
Initializations = importdata(filename); % read in the 
textIni = Initializations.textdata(); % seperating out the .ini part
dataIni = Initializations.data(); % seperating out the part value
Inputs = length(textIni); % getting the number of .ini pairs
if Inputs ~= iniSize % if the .ini file doesn't match what we expect
    error('Invalid .ini file, consult the documentation to make sure you have enough fields.');
    return
end

% Parse the .ini file

for i = 1:iniSize % the order of things in the .ini file doesn't matter, as long as there are enough things
    n = textIni{i}; % current .ini label
    curdat = dataIni(i); % corresponding .ini value 
    switch n % switch yses the label to properly assign the value
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
        case 'BaudRate'
            BaudRate = curdat;
        case 'ProvidedPort' % handling differences in operating systems
            if isunix
                ProvidedPort = strcat('/dev/ttyUSB',num2str(curdat)); 
            elseif ispc
                ProvidedPort = strcat('COM',num2str(curdat));
            else
                Error('Operating system not planned for at this time.')
            end
        otherwise % otherwise, print out the invalid label so the user knows what went wrong
            n
            Error('Above .ini field is not valid at this time.')
            return
    end
end

% Testing the serial port

ports = instrhwinfo('serial'); % get a list of available ports
ports = ports.SerialPorts; % obtain the names of the ports
numports = length(ports); % get the number of available ports
for i = 1:numports
    curport = ports{i}; % array of char arrays
    if strcmp(ProvidedPort,curport)
        found = 1; % testing a serial port provided by the user against 
                     % the existing serial ports on the hardware
        break;
    end
end

if (~found) % when the asked for port isn't there, exit the program
    ProvidedPort
    error('The above serial port is not valid. Please check the hardware connection and the .ini file and try again.')
end

% Setting up the serial object

sObj = serial(ProvidedPort); % build the serial object
set(sObj,'BaudRate',BaudRate,'Timeout',Timeout); % set the properties
fopen(sObj); % open the formatted serial port
 
 % The arrays needed to 'prime' the plot

 maxStripVal = floor(str2/str);
 x = 1:maxStripVal;
 x2 = 0*ones(maxStripVal,1);
 x3 = ones(maxStripVal,1);
 
 % Setting up the initial plots with the limits hidden
 
 figure1 = figure;
 subplot(3,1,1);
 hold on;
 VXLine = plot(x,x3*VMax,'w'); % drawing a hidden maximum line for the voltage
 VILine = plot(x,x3*VMin,'w'); % drawing a hidden minimum line for the voltage
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
 set(gca,'XTick',[]);
 title('Voltage')
 ylabel('Voltage (V)')
 subplot(3,1,2);
 hold on;
 AXLine = plot(x,x3*AMax,'w'); % drawing a hidden maximum line for the current
 AILine = plot(x,x3*AMin,'w'); % drawing a hidden minimum line for the current
 hLine12 = plot(x,x2*AMin); % EPS 8V4 Current
 hLine13 = plot(x,x2*AMin); % EPS 5V Current
 hLine14 = plot(x,x2*AMin); % EPS 3V3 Current
 hLine15 = plot(x,x2*AMin); % PV1 Current
 hLine16 = plot(x,x2*AMin); % PV2 Current
 hLine17 = plot(x,x2*AMin); % Battery IC
 hLine18 = plot(x,x2*AMin); % Battery ID
 hLine19 = plot(x,x2*AMin); % INMS 5V Current
 hLine20 = plot(x,x2*AMin); % INMS 3V5 Current 
 set(gca,'XTick',[]);
 title('Current')
 ylabel('Current (A)')
 subplot(3,1,3);
 hold on;
 TXLine = plot(x,x3*TMax,'w'); % drawing a hidden maximum line for the temperature
 TILine = plot(x,x3*TMin,'w'); % drawing a hidden minimum line for the temperature
 hLine21 = plot(x,x2*TMin); % Battery T1
 hLine22 = plot(x,x2*TMin); % Battery T2
 hLine23 = plot(x,x2*TMin); % T3
 hLine24 = plot(x,x2*TMin); % T1
 hLine25 = plot(x,x2*TMin); % T2
 hLine26 = plot(x,x2*TMin); % 8.5 V Board Temperature
 hLine27 = plot(x,x2*TMin); % 3V5/5V Board Temperature
 hLine28 = plot(x,x2*TMin); % CDH Temperature
 hLine29 = plot(x,x2*TMin); % Com Temperature
 hLine30 = plot(x,x2*VMin); % INMS TH Temperature
 title('Temperature')
 ylabel('Temperature (C)')
 
 set(figure(1),'Units','Normalized','OuterPosition',[0.5 0 0.5 1]); % place the figure on the screen
 
 % Setting up the data tables
 
 figure2 = figure('Position', [100 100 752 250]);
 set(figure(2),'Units','Normalized','OuterPosition',[0 0 0.5 1]);
 columnname = {'         Hardware Label         ', 'Value'};
 d = data;
 t = uitable('Parent',figure2, ...
    'ColumnName',columnname, ...
    'Data',d,'Units','Normalized');
pos = get(figure2,'Position');
if strcmp(curver,'2014b') || strcmp(curver,'2015a') || strcmp(curver,'2015b')
    t.Position = [0 t.Extent(4)/2 t.Extent(3) t.Extent(4)]; % position in the new system
else
    % here is where we set the position in the old notation
    setter = get(t,'Extent');
    set(t,'Position',[0 setter(4)/2 setter(3) setter(4)]);
end
 
 figure(figure1); % pass focus back to the main strip charts for now
 
 % Setting up for the loop
 
 continuer = 1;
 
 % Adding the stop button
 
 C = uicontrol('String','Stop','Callback','continuer = 0;','parent',...
     figure1,'Units','Normalized');
 set(C,'Position', [0.5 0.05 0.06 0.02]);
 
 % Opening the Logging Methods
 
 if strcmp(curver,'2014b') || strcmp(curver,'2015a') || strcmp(curver,'2015b')
    DateString = datestr(datetime('now'),'mmddyyyyHHMMSS');
 else
     DateString = datestr(clock,'mmddyyyyHHMMSS');
 end
 
 binaryname = ['HouseKeepingPackets' DateString '.bat']  % file for storing hex values
 filename = ['HouseKeepingLog' DateString '.log'] % file for storing physical values
 
 % Running the main loop
 
 StripChart('Initialize',gca,'Packets') % start up the StripChart library
 while(continuer)
    [binary,datum] = GetData(sObj); % read a new data set
    ToLog(binary,datum,binaryname,filename); % log the read data
    for counterer = 21:30 % reduce accuracy of temperatures (Palo requested)
        datum{counterer} = ceil(datum{counterer}*10)/10;
    end
    newdata = [labels,datum]; % set up the new labels+data pairs
    % update the plots
    StripChart('update',hLine,datum{1});
    StripChart('update',hLine2,datum{2});
    StripChart('update',hLine3,datum{3});
    StripChart('update',hLine4,datum{4});
    StripChart('update',hLine5,datum{5});
    StripChart('update',hLine6,datum{6});
    StripChart('update',hLine7,datum{7});
    StripChart('update',hLine8,datum{8});
    StripChart('update',hLine9,datum{9});
    StripChart('update',hLine10,datum{10});
    StripChart('update',hLine11,datum{11});
    StripChart('update',hLine12,datum{12});
    StripChart('update',hLine13,datum{13});
    StripChart('update',hLine14,datum{14});
    StripChart('update',hLine15,datum{15});
    StripChart('update',hLine16,datum{16});
    StripChart('update',hLine17,datum{17});
    StripChart('update',hLine18,datum{18});
    StripChart('update',hLine19,datum{19});
    StripChart('update',hLine20,datum{20});
    % catch divide by 0 errors
    if datum{21} == SolarCatcher
        StripChart('update',hLine21,0); 
    else
        StripChart('update',hLine21,datum{21});
    end
    if datum{22} == SolarCatcher
        StripChart('update',hLine22,0);
    else
        StripChart('update',hLine22,datum{22});
    end
    if datum{23} == SolarCatcher
        StripChart('update',hLine23,0);
    else
        StripChart('update',hLine23,datum{23});
    end
    if datum{24} == SolarCatcher
        StripChart('update',hLine24,0);
    else
        StripChart('update',hLine24,datum{24});
    end
    if datum{25} == SolarCatcher
        StripChart('update',hLine25,0);
    else
        StripChart('update',hLine25,datum{25});
    end
    StripChart('update',hLine26,datum{26});
    StripChart('update',hLine27,datum{27});
    StripChart('update',hLine28,datum{28});
    StripChart('update',hLine29,datum{29});
    StripChart('update',hLine30,datum{30});
    set(t,'Data',newdata); % This is how we update the table
    set(C,'Position', [0.5 0.05 0.06 0.02]);
    % add coloring to the table as needed
    for i = 1:11 
        curdat = datum{i};
        if curdat < VMin || curdat > VMax
            newdata = TurnRed(t,newdata,i);
        end
    end
    for i = 12:20
        curdat = datum{i};
        if curdat < AMin || curdat > AMax
             newdata = TurnRed(t,newdata,i);
        end
    end
    for i = 21:30
        curdat = datum{i};
        if curdat == SolarCatcher
            newdata = TurnBlue(t,newdata,i);
        elseif curdat < TMin || curdat > TMax
             newdata = TurnRed(t,newdata,i);
        end
    end
    drawnow % update the screen
 end
 
 % Cleaning up the serial object
 
 fclose(sObj); % close the object
 delete(sObj); % delete it
 clear sObj; % free it