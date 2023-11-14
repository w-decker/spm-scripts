function fmriunzip(path)
%FMRIUNZIP Unzip nii.gz files in specified directory
%   PATH Absolute path to the directory containing nii.gz files

% make into structure
datadir = dir(fullfile(path));
datanames = {datadir.name}.';
folders = {datadir.folder}.';

for i=1:length(datanames)

    % split
    split_name = split(datanames{i}, '.');

    % check if file is compressed
    if strcmpi(split_name(end), 'gz')
        gunzip([folders{i} filesep datanames{i}])
    else
        sprintf('%c is already unzipped.', datanames{i});
    end
end









end