
# spm-scripts
This repository contains code used to preprocess fMRI data using [Statistical Parametric Mapping (SPM)](https://www.fil.ion.ucl.ac.uk/spm/).

# What do some of these files do?
>`fmriunzip` Identifies compressed MRI data files and automatically uncompresses them. You must specify a `path`.

>`glob` Parses/filters files in a directory based on a specified filter, like 'nii'.

>`gather` Gathers unzipped MRI datafiles into a structure.

>`preprocess` Main file for preprocessing fMRI data. 

## FYI
`fmriunzip.m` and `glob.m` and a few forthcoming scripts/functions are not pertinent to any level of analysis but provide a cleaner script for parseing files.
