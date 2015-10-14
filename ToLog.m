function [ ] = ToLog( binary, datum, binaryfile, logfile )
    % ToLog Logs an incoming data column to the provided log file.
    
    dlmwrite(binaryfile,binary,'-append'); % Place a single binary set
    dlmwrite(logfile,datum','-append'); % Transpose column to row and log
end