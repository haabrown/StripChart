% This is where I will be testing the serial code before adding it in to
% the main body of the support software

close all;
clear all;

% Constants

%providedport = '/dev/ttyS0'; % For linux
providedport = 'COM1'; % For Windows
BaudRate = 9600;% The user provided baud rate (will come from .ini file)

found = 0; % Serial port not found

% Get the list of available serial ports

ports = instrhwinfo('serial');
ports = ports.SerialPorts;
numports = length(ports);
for i = 1:numports
    curport = ports{i}; % Array of char arrays
    if strcmp(providedport,curport)
        found = 1; % Testing a serial port provided by the user against 
                     % the existing serial ports on the hardware
        break;
    end
end

if (~found)
    providedport
    error('The above serial port is not valid. Please check the hardware connection and the .ini file and try again.')
end

% Seting up a serial obhject with the now established port

s = serial(providedport); % Create a serial object linked to the provided port
set(s,'BaudRate',BaudRate); % Set the baud rate
fopen(s); 
fprintf(s,'*IDN?')
out = fscanf(s);
fclose(s);
delete(s);
clear s