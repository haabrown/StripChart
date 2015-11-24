function [ ] = ContinueCallback(hObject,evt,figure)
%ContinueCallback The callback button for a simple continue button

uiresume(figure); % unpause program execution
close(figure);  % close the checkboxes

end

