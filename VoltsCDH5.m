function [ Volt ] = VoltsCDH5(byte)

Volt = (7/255)*double(uint8(hex2dec(byte))); % Volts