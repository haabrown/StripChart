function [ newdata ] = TurnBlue( table, newdata, i )
%TurnBlue Turns a given cell blue because it was floating
%   Turns a cell blue and passes the blue cells forward

label = newdata(i,1);
value = newdata(i,2);
colergen = @(color,text) ['<html><table border=0 width=400 FONT color="white" bgcolor=',color,'><TR><TD>',text,'</TD></TR> </table></html>'];
newdata(i,1) = {colergen('#0000FF',label{1})};
newdata(i,2) = {colergen('#0000FF', num2str(value{1}))};
set(table,'data',newdata);

end