function [ Volt ] = VoltsCDHB(byte)

Volt = (70.35/255)*double(uint8(byte)); % Volts