% This is where I will be testing the serial code before adding it in to
% the main body of the support software

close all;
clear all;

% Get the list of available serial ports

ports = instrhwinfo('serial');
ports = ports.SerialPorts;
ports = ports{1}; % Array of char arrays
var = '/dev/ttyS0';
if var == ports
    'Hello There' % Testing a serial port provided by the user against 
                  % the existing serial ports on the hardware
end