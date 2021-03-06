% This is where I will be testing the serial code before adding it in to
% the main body of the support software

close all;
clear all;

% Testing out hex stuff

%a = 247; % The decimal representation of 10000000

%get7 = 128; % The decimal way to pull out the first bit
%get620 = 127; % The decimal way to pull out the next 7 bits

%uint8(bitshift(bitand(a,get7),-7))
%uint8(bitand(a,get620))

%return

% Constants

providedport = '/dev/ttyUSB0'; % For linux
%providedport = 'COM1'; % For Windows
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
CleanupTest(s);
clear s;