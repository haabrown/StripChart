function [ Volt ] = VoltsCDHB(byte)

Volt = (70.35/255)*byte; % Volts