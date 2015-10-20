function [ Temp ] = INMSTrans( byte )

% The provided fraction is 0.8890625 as far as MATLAB can tell in long mode
Temp = (float(uint8(hex2dec(byte)))*0.8890625)-45.55; % Result is in degrees C
    
% May need to reverse the byte input there, depending on what Nico says