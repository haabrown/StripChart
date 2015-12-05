% This is the file that reads the log files generated by the strip chart
% program (specifically, the .log files that contained the translated
% inputs).

close all;
clear all;
format long; % otherwise MATLAB loses the seconds

% Constant values

fileType = '*.log'; % the supported file types
numberOfValues = 30; % the number of checkboxes to be made available
taskbarSize = 0.037; % Height of the windows taskbar
screenSize = 1-taskbarSize; % measuring the avialable screen room
heightVal = screenSize/(numberOfValues); % the divider
labels = {'EPS 8V4 Voltage';'EPS 5V Voltage';'EPS 3V3 Voltage';...
    'PV1 Voltage';'PV2 Voltage';'Battery Voltage';...
    'Fuel Gauge VCELL';'CDH 5V Voltage';'CDH Battery Voltage';...
    'INMS 5V Voltage';'INMS 3V5 Voltage';...
    'EPS 8V4 Current';'EPS 5V Current';'EPS 3V3 Current';...
    'PV1 Current';'PV2 Current';'Battery IC';'Battery ID';...
    'INMS 5V Current';'INMS 3V5 Current';...
    'Battery T1';'Battery T2';'T3';'T1';'T2';'8.5 V Board Temperature';...
    '3V5/5V Board Temperature';'CDH Temperature';'Comm Temperature';...
    'INMS TH Temperature';};
numberOfVoltages = 11; % the number of voltages
numberOfCurrents = 9; % the number of currents
numberOfTemps = 10; % the number of temperatures
global includedValues; % created as a global to convince MATLAB to stop being strange
includedValues = ones(30,1);

% Opening the desired log file (this could be updated to also get .bat
% files).

[FileName,PathName] = uigetfile(fileType,'Select the logfile to plot.');
fileName = strcat(PathName,FileName); % making note of the filename including path

logData = csvread(fileName); % reading the csv file

timeName = strcat(fileName(1:end-3),'time'); % getting the matching time log

timeData = csvread(timeName); % reading the time log

% Creating the checkbox figure (Need to add callback functions)

Checks.f = figure('Position', [100 100 752 250],'toolbar','none',...
    'Name','Data to be plotted.','NumberTitle','off');
set(Checks.f,'Units','Normalized','OuterPosition',[0.25 taskbarSize 0.5 screenSize]);
for i = 1:numberOfValues % initializing the checkboxes
    Checks.c(i) = uicontrol('style','checkbox','units','normalized',...
        'position',[0.3 heightVal*(numberOfValues-i+1) 0.4 heightVal],...
        'string',labels{i},'Value',includedValues(i),'Callback',...
        {@CheckboxCallback,i});
end

% Adding the continue button

Checks.c(numberOfValues+1) = uicontrol('units','normalized',...
    'position',[0.3 0 0.4 heightVal],'string','Continue','Callback',...
    {@ContinueCallback,Checks.f});
    % build the button
uiwait(gcf);    % wait until the continue button is pressed

% Doing all of the plotting

figure(1); % plotting the voltages
hold all;
legend1 = []; % the list of valid legend entries
isPlotted = 0; % monitor variable for plot validity
for i = 1:numberOfVoltages
    if includedValues(i) == 1 % if the user wants this value plotted
        isPlotted = 1; % do make a plot
        plot(timeData,logData(:,i)); % plot this line
        legend1 = [legend1 labels(i)]; % add this physical value to the legend
    end
end

if isPlotted == 0
    close gcf; % if no plot, close the figure
else
    legend(legend1); % otherwise, add the legend
    title('House Keeping Voltages') % adding a title
    xlabel('Time (s)') % labeling the x axis as time in seconds
    ylabel('Voltage (V)') % labeling the y axis as voltages in volts
    set(gcf,'units','normalized','position',[0,0,1,1]); % fullscreening the window to improve viewing
    xt = get(gca, 'XTick'); % grabbing the default ticks
    set(gca,'XTickLabel',num2str(xt(:),'%.0f')) % making them readable
end

figure(2); % plotting the currents
hold all;
legend2 = []; % the list of valid legend entries
isPlotted = 0; % monitor variable for plot validity
for i = numberOfVoltages+1:numberOfVoltages+numberOfCurrents
    if includedValues(i) == 1 % if the user wants this value plotted
        isPlotted = 1; % do make the plot
        plot(timeData,logData(:,i)); % plot this line
        legend2 = [legend2 labels(i)]; % add this physical value to the legend
    end
end
if isPlotted == 0
    close gcf; % if no plot, close the figure
else
    legend(legend2); % otherwise, add the legend
    title('House Keeping Currents') % adding a title
    xlabel('Time (s)') % labeling the x axis as time in seconds
    ylabel('Current (A)') % labeling the y axis as current in amps
    set(gcf,'units','normalized','position',[0,0,1,1]); % fullscreening the window to improve viewing
    xt = get(gca, 'XTick'); % grabbing the default ticks
    set(gca,'XTickLabel',num2str(xt(:),'%.0f')) % making them readable
end

figure(3); % plotting the temperatures
hold all;
legend3 = []; % the list of valid legend entries
isPlotted = 0; % monitor variable for plot validity
for i = numberOfVoltages+numberOfCurrents+1:numberOfVoltages+numberOfCurrents+numberOfTemps
    if includedValues(i) == 1 % if the user wants this value plotted
        isPlotted = 1; % do make the plot
        plot(timeData,logData(:,i)); % plot this line
        legend3 = [legend3 labels(i)]; % add this physical value to the legend
    end
end
if isPlotted == 0
    close gcf; % if no plot, close the figure
else
    legend(legend3); % otherwise, add the legend
    title('House Keeping Temperatures') % adding a title
    xlabel('Time (s)') % labeling the x axis as time in seconds
    ylabel('Temperature (C)') % labeling the y axis as temperature in degrees Celcius
    set(gcf,'units','normalized','position',[0,0,1,1]); % fullscreening the window to improve viewing
    xt = get(gca, 'XTick'); % grabbing the default ticks
    set(gca,'XTickLabel',num2str(xt(:),'%.0f')) % making them readable
end