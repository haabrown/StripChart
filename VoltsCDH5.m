function [ Volt ] = VoltsCDH5(byte)

Volt = (7/255)*byte; % Volts