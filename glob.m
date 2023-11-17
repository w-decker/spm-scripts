function [g] = glob(a, str)
%GLOB Filter array-like object with string conditional
%   A array-like object
%   str String to find in the data and filter with

    if isstruct(a) == true
        error("Please provide the fieldname of %s as a cell array. \n" + ...
            "Example: {struct.fieldname}.'", char(inputname(1)))
    end

    g = [];
    for i=1:length(a)
        if contains(a{i}, str) == true
            g{end + 1} = a{i};
        else
            disp("'" + a{i} + "'" + " does not match filter, " + ...
                "" + "'" + str + "'.")
        end
    end

end