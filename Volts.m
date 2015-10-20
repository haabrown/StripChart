function [ Volt ] = Volts(byte)

Volt = double(uint8(hex2dec(byte)))*0.128; % Volts