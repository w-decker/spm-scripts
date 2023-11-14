function [g] = glob(A, str)
%GLOB Filter array-like object with string conditional
%   A array-like object
%   str String to find in the data and filter with

    if isstruct(A) == true
        error("Please provide the fieldname of %s as a cell array. \n" + ...
            "Example: {struct.fieldname}.''", char(inputname(1)))
    end

    g = [];
    for i=1:length(A)
        if contains(A{i}, str) == true
            g{end + 1} = A{i};
        else
            disp("'" + A{i} + "'" + " does not match filter, " + ...
                "" + "'" + str + "'.")
        end
    end

end