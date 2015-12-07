function [ binary, data ] = GetData(sObj)
    % GetData Converts a housekeeping packet into a new data column
    %   The GetData function polls the UART line to see if housekeeping
    %   data is available - if so, it will convert it into a column of data
    %   in the format used by strip1.m
    
    % It appears that a housekeep packet is 128 bytes, with 34 of those
    % containing the information we need to plot
    
    
    binary = fread(sObj,145);
    %binary = ones(145,1)*10; % Used for testing only. Does not read
    %serial.
    voltages = [Volts(binary(48)),Volts(binary(49)),Volts(binary(50)),Volts(binary(54)),Volts(binary(55)),VoltsBatt(binary(65)),FG_VCell(binary(70)),VoltsCDH5(binary(46)),VoltsCDHB(binary(47)),Volts(binary(73)),Volts(binary(74))];
    currents = [Curs(binary(51)),Curs(binary(52)),Curs(binary(53)),Curs(binary(56)),Curs(binary(57)),CursBatt(binary(66)),CursBatt(binary(67)),CursINMS(binary(75)),CursINMS(binary(76))];
    inter1 = dec2hex(binary(58:59)); 
    inter2 = dec2hex(binary(60:61));
    inter1 = strcat(inter1(1,:),inter1(2,:));
    inter2 = strcat(inter2(1,:),inter2(2,:)); % Need to update temps still
    temps = [ThermBatt(hex2dec(inter1)),ThermBatt(hex2dec(inter2)),ThermSolar(binary(64)),ThermSolar(binary(62)),ThermSolar(binary(63)),TMP100(binary(68)),TMP100(binary(69)),TMP100(binary(45)),TMP100(binary(78)),INMSTrans(binary(77))];
    data = [voltages,currents,temps]';
   	data = num2cell(data);
end