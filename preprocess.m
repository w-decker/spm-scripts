%%%% Preprocess %%%% 

% 'Setting up and checking some things' is essentially prepping for the analysis component. It
% can be modified as needed. 
% 
% 'Preprocessing based on batch outout' is
% based on the SPM GUI and will run similarly to how the GUI would. I.e.,
% you will see the commands and their output in the command window just as
% you would if you were using the GUI. 

%% Setting up and checking some things

% subject IDs
subjects = [01 02 03 04 05 06 07 08 09 10];

% directory
datadir = dir(fullfile(pwd)); % or set to whatever
datapath = '';

% get environment info
user = getenv('USERNAME'); % for Windows 
% user = getenv('USER') % for MacOS

% get files in datadir
g = gather(@glob, {datadir.names}.', 'nii', datapath);
files = {g.name}.';
folder = {g.folder}.';

%% Realigning

% get number of subjects
n = length(files);

% get source 
source_file = [];

for i =1:n

    data_info = spm_vol(files(i));
    n_vols = length({data_info.n}.');
   
    % set empty cell
    matlabbatch{1}.spm.spatial.realign.estwrite.data = {};

    % populate cell with each volume
    for v=1:n_vols
        matlabbatch{1}.spm.spatial.realign.estwrite.data{i} = {[folder files(i) ',' num2str({v})]};
    end

    % estimate and realign
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 2;
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '';
    matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [2 1];
    matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 4;
    matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
    matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
    matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';
    matlabbatch{2}.spm.spatial.normalise.estwrite.subj.vol = {[]};

end

%% Normalizing

% get number of subjects
n = length(files);

for i =1:n

    data_info = spm_vol(files(i));
    n_vols = length({data_info.n}.');
   
    % set empty cell
    matlabbatch{2}.spm.spatial.normalise.estwrite.subj.resample = {};

    % populate cell with each volume
    for v=1:n_vols
         matlabbatch{2}.spm.spatial.normalise.estwrite.subj.resample{i} = {[folder files(i) ',' num2str({v})]};
    end

    % normalize
    matlabbatch{2}.spm.spatial.normalise.estwrite.eoptions.biasreg = 0.0001;
    matlabbatch{2}.spm.spatial.normalise.estwrite.eoptions.biasfwhm = 60;
    matlabbatch{2}.spm.spatial.normalise.estwrite.eoptions.tpm = {'/Users/lendlab/Documents/MATLAB/spm12/tpm/TPM.nii'};
    matlabbatch{2}.spm.spatial.normalise.estwrite.eoptions.affreg = 'mni';
    matlabbatch{2}.spm.spatial.normalise.estwrite.eoptions.reg = [0 0.001 0.5 0.05 0.2];
    matlabbatch{2}.spm.spatial.normalise.estwrite.eoptions.fwhm = 0;
    matlabbatch{2}.spm.spatial.normalise.estwrite.eoptions.samp = 3;
    matlabbatch{2}.spm.spatial.normalise.estwrite.woptions.bb = [-78 -112 -70
                                                                 78 76 85];
    matlabbatch{2}.spm.spatial.normalise.estwrite.woptions.vox = [3 3 3]; % change as needed
    matlabbatch{2}.spm.spatial.normalise.estwrite.woptions.interp = 4;
    matlabbatch{2}.spm.spatial.normalise.estwrite.woptions.prefix = 'w';

end

%% Smoothing

% get number of subjects
n = length(files);

for i =1:n

    data_info = spm_vol(files(i));
    n_vols = length({data_info.n}.');
   
    % set empty cell
    matlabbatch{3}.spm.spatial.smooth.data = {};

    % populate cell with each volume
    for v=1:n_vols
         matlabbatch{3}.spm.spatial.smooth.data{i} = {[folder files(i) ',' num2str({v})]};
    end

    % smooth
    matlabbatch{3}.spm.spatial.smooth.fwhm = [6 6 6];
    matlabbatch{3}.spm.spatial.smooth.dtype = 0;
    matlabbatch{3}.spm.spatial.smooth.im = 0;
    matlabbatch{3}.spm.spatial.smooth.prefix = 's';

end









