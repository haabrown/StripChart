function [ updated, binary, data ] = GetData(i)
    % GetData Converts a housekeeping packet into a new data column
    %   The GetData function polls the UART line to see if housekeeping
    %   data is available - if so, it will convert it into a column of data
    %   in the format used by strip1.m
    
    % For now this just dummy updates data at every loop iteration
    
    updated = 1; % 1 for an update, 0 for no change
    z = sin(2*pi*i/1000)+2;
    z2 = -1*z;
    if mod(i,2) == 0
        z3 = z;
    else
        z3 = z2;
    end
    
    % It appears that a housekeep packet is 128 bytes, with 34 of those
    % containing the information we need to plot
    
    binary = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
    voltages = [Volts(binary(44)),Volts(binary(45)),Volts(binary(46)),Volts(binary(50)),Volts(binary(51)),VoltsBatt(binary(61)),double(binary(66)),VoltsCDH5(binary(42)),VoltsCDHB(binary(43)),Volts(binary(69)),Volts(binary(70)),0];
        % Missing the INMS TH Voltage
    currents = [Curs(binary(47)),Curs(binary(48)),Curs(binary(49)),Curs(binary(52)),Curs(binary(53)),CursBatt(binary(62)),CursBatt(binary(63)),Curs(binary(71)),Curs(binary(72)),0];
        % Missing the INMS TH Current
    temps = [ThermBatt(binary(54:55)),ThermBatt(binary(56:57)),ThermSolar(binary(60)),ThermSolar(binary(58)),ThermSolar(binary(59)),TMP100(binary(64)),TMP100(binary(65)),TMP100(binary(41)),TMP100(binary(74))];
    %data = {z;z3;z;z2;z;z2;z;z2;z;z2;z;z2;z;z3;z;z2;z;z2;z;z2;z;z2;z;z2;...
      %  20*z;20*z2;20*z;20*z2;20*z;20*z2;20*z};
    data = [voltages,currents,temps]';
   	data = num2cell(data);
end