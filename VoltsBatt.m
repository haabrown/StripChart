function [ Volt ] = VoltsBatt(byte)

Volt = (16/255)*double(uint8(byte)); % Volts