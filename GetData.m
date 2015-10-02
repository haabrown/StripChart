function [ updated, data ] = GetData(i)
    % GetData Converts a housekeeping packet into a new data column
    %   The GetData function polls the UART line to see if housekeeping
    %   data is available - if so, it will convert it into a column of data
    %   in the format used by strip1.m
    
    % For now this just dummy updates data at every loop iteration
    
    updated = 1; % 1 for an update, 0 for no change
    z = sin(2*pi*i/1000)+2;
    z2 = -1*z;
    data = {z;z2;z;z2;z;z2;z;z2;z;z2;z;z2;z;z2;z;z2;z;z2;z;z2;z;z2;z;z2;...
        20*z;20*z2;20*z;20*z2;20*z;20*z2;20*z};
    
end