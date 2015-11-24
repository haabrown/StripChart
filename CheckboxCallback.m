function [ ] = CheckboxCallback( hObject,evt,i )
%CheckboxCallback The callback fucntion for a checkbox.

global includedValues; % imported the global because otherwise callbacks can't update variable
value = get(hObject,'Value');
includedValues(i) = value;

end

