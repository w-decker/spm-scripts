%%%% Estimate motion %%%% 

% 'Setting up and checking some things' is essentially prepping for the analysis component. It
% can be modified as needed. 
% 
% 'Estimating motion based on batch outout' is
% based on the SPM GUI and will run similarly to how the GUI would. I.e.,
% you will see the commands and their output in the command window just as
% you would if you were using the GUI. 
%
% 'Estimating motion using spm_realign' is techinally the same as the
% previous section except without the GUI baggage that would occur in the
% command window

%% Setting up and checking some things

% subject IDs
subjects = [01 02 03 04 05 06 07 08 09 10];

% directory
datadir = string(pwd); % or set to whatever

% get environment info
user = getenv('USER');

% get files in datadir
files = dir(datadir);

% check for compressed files (*.nii.gz)
for i=1:length(files)

    % split
    split_name = split(files.name(i), '.');

    % check
    if strcmpi(split_name(end), 'gz')
        gunzip([files.folder files.name])
    else
        sprintf('%c is already unzipped.', files.name(i))
    end
end

% rework datadir for other things

files = {files.name}.';
files = files(3:end);
folder = {files.folder(3:end)}.';
folder = folder(3:end);
    
%% Estimating motion based on batch output

% get number of subjects
n = length(files);

for i =1:n

    data_info = spm_vol(files(i));
    n_vols = length({data_info.n}.');
   
    % set empty cell
    matlabbatch{1}.spm.spatial.realign.estimate.data = {};

    % populate cell with each volume
    for v=1:n_vols
         matlabbatch{1}.spm.spatial.realign.estimate.data{i} = {[folder files(i) ',' num2str({v})]};
    end

    % transpose
    matlabbatch{1}.spm.spatial.realign.estimate.data.'
        
    % estimate motion
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.quality = 0.9;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.sep = 4;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.fwhm = 5;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.rtm = 1;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.interp = 2;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.wrap = [0 0 0];
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.weight = '';
end

%% Estimating motion using spm_realign

% get number of subjects
n = length(files);

% set flags struct
flags = struct('quality', 0.9, 'sep', 4, 'fwhm', 5, 'rtm', 1, 'interp', 2, 'wrap', [0 0 0]);

for i =1:n

    data_info = spm_vol(files(i));
    n_vols = length({data_info.n}.');
   
    % set empty cell
    P = {};

    % populate cell with each volume
    for v=1:n_vols
         P{i} = {[folder files(i) ',' num2str({v})]};
    end

    % transpose
    P.'
        
    % estimate motion
    spm_realign(P, flags);

end

