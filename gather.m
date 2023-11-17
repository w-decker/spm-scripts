function [g] = gather(fun,a, str, path)
%GATHER Gather relevent files into a meaningful framework
%   G = GATHER(fun, A, str) Creates a structure of files with detailed
%   information about each file for fMRI analysis with SPM. FUN is the
%   function handle, @glob. A is an array like object. STR is the query to
%   filter the data by. PATH is the absolute path of the directory that you
%   wish to gather in.
%
%   A = {'dog', 'cat', 'mouse', 'rose', nose'}
%   STR = 'o'
%   G = GATHER(@glob, A, STR)
%% Validate input arguments
if ~isa(fun,'function_handle')
    error(message('MATLAB:gather:funArgNotHandle'));
end
if ~iscell(a)
    error('A must be a cell of string or character values')
end
if ~isfolder(path)
    warning('Your path is invalid. Please ensure that you have typed it correctly')
    p = input(['Do you wish to force validate your path? \n' ...
        'This will create a directory based on the specified PATH. (y/n)']);
    if strcmp(p, 'y')
        mkdir(path)
        sprintf('Folder created at %s', path)
    elseif strcmp(p, 'n') | isempty(p)
        error('Please check your PATH')
    end
end

%% Begin

g = fun(a, str);
files = dir(fullfile(path));
filenames = {files.names}.';

% remove hidden files from struct
for i=1:length(filenames)
    f = char(filenames{i});
    if strcmp(f(1), '.')
        files(i) = [];
    end
end

% remove all files that aren't fMRI data
for i=1:length(filenames)
    f = split(filenames{i}, '.');
    if ~strcmp(f(end), 'nii') && strcmp(f(end), 'gz') && strcmp(f(end-1), 'nii')
        warning(['You have some compressed data files \n' ...
            'Try running FMRIUNZIP to unload these files.'])
    elseif ~contains(filenames{i}, 'nii')
        files(i) = [];
    end
end

g = files;

end