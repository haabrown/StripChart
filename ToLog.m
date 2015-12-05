function [ ] = ToLog( binary, datum, binaryfile, logfile, timelog )
    % ToLog Logs an incoming data column to the provided log file.
    
    dlmwrite(binaryfile,binary','-append'); % Place a single binary set
    dlmwrite(logfile,datum','-append'); % Transpose column to row and log
    curtime = datevec(now);
    elapsed = (curtime(3)*3600*24)+(curtime(4)*3600)+(curtime(5)*60)+curtime(6);
    dlmwrite(timelog,elapsed,'-append','precision',16);
    
end