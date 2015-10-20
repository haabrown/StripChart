function [ Volt ] = VoltsBatt(byte)

Volt = (16/255)*double(uint8(hex2dec(byte))); % Volts