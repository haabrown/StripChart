function [ Temp ] = TMP100( byte )

Temp = (-1*int8(bitshift(bitand(uint8(hex2dec(byte)),128),-7)))+int8(uint8(bitand(uint8(hex2dec(byte)),127))); % Result is in degrees C
Temp = double(Temp);

% I am not overly happy with this, this may need to be further addressed