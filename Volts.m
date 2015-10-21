function [ Volt ] = Volts(byte)

Volt = double(uint8(byte))*0.128; % Volts