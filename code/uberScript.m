%% Master script for Spitschan et al. (2017)
%
% Reference: Spitschan M, Bock A, Ryan J, Frazzetta G, Brainard DH, Aguirre
% GK (2017) The human visual cortex response to melanopsin-directed
% stimulation is accompanied by a distinct perceptual experience, bioRxiv,
% https://doi.org/10.1101/138768

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (0) Dependencies
% This script requires the following repositories to be local on your
% machine:
%           https://github.com/gkaguirrelab/fmriMelanopsinMRIAnalysis/
%           https://github.com/gkaguirrelab/psychoMelanopsinAnalysis/
%           https://github.com/gkaguirrelab/pupilMelanopsinMRIAnalysis/
%           https://github.com/spitschan/splatterMelanopsinMRIAnalysis
%
% It relies heavily on automatic path configuration using ToolboxToolbox:
%           https://github.com/ToolboxHub/ToolboxToolbox

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (1) MRI data processing
% Reference repository:
%           https://github.com/gkaguirrelab/fmriMelanopsinMRIAnalysis

%% (1a) Before starting: make sure all files are in place
% 1. Uncompress the full dataset in your "dataDir". Do not alter the path
% structure of dataDir.
% 2. Uncompress the freesurferSubjects dir and copy the content in your
% freesurfer subject folder.
% 3. Uncompress the anatTemplate archive in your anatTemplateDir.

%% (1b) Set up ToolboxToolbox configuration for fMRI analysis
tbUseProject('fmriMelanopsinMRIAnalysis');

%% (1c) Define initial paths and Parameters.
% <!> NOTE: This need to be adjusted for your local structure.
params.resultsDir = '/data/jag/MELA/MelanopsinMR/results';
params.logDir = '/data/jag/MELA/MelanopsinMR/logs';
params.dataDir = '/data/jag/MELA/MelanopsinMR';
params.anatTemplateDir = '/data/jag/MELA/anat_templates';

%% (1d) Create preprocessing scripts
% <!> NOTE: This cell assumes that the freesurfer subjects files have been copied
% to the local freesurfer subject folder. This will save time while doing
% preprocessing, as the recon all step will be skipped.
fmriMelanopsinMRIAnalysis_createPreprocessingScripts(params);

%% (1e) Run the preprocessing scripts
% <!> NOTE: Evaluating this cell will submit the scripts one by one, one after
% the other. This will likely take serveral days to complete. If you have
% access to a unix cluster architecture, consider navigating in each
% session directoru and launching the job script called
% "submit_<subjectName>_all.sh"
%
% <!> NOTE: At present this only words on OS X and Linux.
system (sprintf (['sh ' params.dataDir '/HERO_asb1/032416/preprocessing_scripts/HERO_asb1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_asb1/040716/preprocessing_scripts/HERO_asb1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_asb1/051016/preprocessing_scripts/HERO_asb1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_asb1/060716/preprocessing_scripts/HERO_asb1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_asb1/060816/preprocessing_scripts/HERO_asb1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_asb1/101916/preprocessing_scripts/HERO_asb1_MaxMel_all.sh']))

system (sprintf (['sh ' params.dataDir '/HERO_aso1/032516/preprocessing_scripts/HERO_aso1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_aso1/033016/preprocessing_scripts/HERO_aso1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_aso1/042916/preprocessing_scripts/HERO_aso1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_aso1/053116/preprocessing_scripts/HERO_aso1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_aso1/060116/preprocessing_scripts/HERO_aso1_MaxMel_all.sh']))

system (sprintf (['sh ' params.dataDir '/HERO_gka1/033116/preprocessing_scripts/HERO_gka1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_gka1/040116/preprocessing_scripts/HERO_gka1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_gka1/050616/preprocessing_scripts/HERO_gka1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_gka1/060216/preprocessing_scripts/HERO_gka1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_gka1/060616/preprocessing_scripts/HERO_gka1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_gka1/101916/preprocessing_scripts/HERO_gka1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_gka1/102416/preprocessing_scripts/HERO_gka1_MaxMel_all.sh']))

system (sprintf (['sh ' params.dataDir '/HERO_mxs1/040616/preprocessing_scripts/HERO_mxs1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_mxs1/040816/preprocessing_scripts/HERO_mxs1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_mxs1/050916/preprocessing_scripts/HERO_mxs1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_mxs1/060916/preprocessing_scripts/HERO_mxs1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_mxs1/061016_Mel/preprocessing_scripts/HERO_mxs1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_mxs1/101916/preprocessing_scripts/HERO_mxs1_MaxMel_all.sh']))
system (sprintf (['sh ' params.dataDir '/HERO_mxs1/102416/preprocessing_scripts/HERO_mxs1_MaxMel_all.sh']))

%% (1f) Make anatomical templates
fmriMelanopsinMRIAnalysis_makeAnatTemplates(params);

%% (1g) Project anatomical templates
fmriMelanopsinMRIAnalysis_projectAnatTemplatesToFunc(params);


%% (1h) Assemble V1 time series for the CRF data
fmriMelanopsinMRIAnalysis_makeAllCRFPackets(params);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (2) Whole-brain chi-square maps

% <!> Fill in


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (3) Pupillometry data analysis
% Reference repository:
%           https://github.com/gkaguirrelab/pupilMelanopsinMRIAnalysis

%% (3a) Before starting: make sure all files are in place

%% (3b) Set up ToolboxToolbox configuration for pupil analysis
tbUseProject('pupilMelanopsinMRIAnalysis');

%% (3c) Pupil data analysis
pupilPMEL_main();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (4) Psychophysical data analysis
% Reference repository:
%           https://github.com/gkaguirrelab/pupilMelanopsinMRIAnalysis

%% (4a) Before starting: make sure all files are in place

%% (4b) Set up ToolboxToolbox configuration for psychophysical data analysis
tbUseProject('psychoMelanopsinMRIAnalysis');

%% (4c) Pupil data analysis
psychoMelAnalysis_main();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (5) Physiological splatter analysis
% Reference repository:
%           https://github.com/gkaguirrelab/splatterMelanopsinMRIAnalysis

%% (5a) Before starting: make sure all files are in place


%% (5b) Set up ToolboxToolbox configuration for splatter analysis
tbUseProject('splatterMelanopsinMRIAnalysis');

%% (5c) Splatter data analysis
splatterMel_AttentionTask();
splatterMel_PerceptualDataSplatter();
splatterMel_PhysiologicalSplatterAnalysis();
splatterMel_SpectraTable();
splatterMel_SpectralPlots();
splatterMel_SplatterAnalysis();