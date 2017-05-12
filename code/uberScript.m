
%
% Overall master script for Spitschan et al. 2017 Nature Neuroscience
%


%%  PART 1. MRI data processing

% reference repo: 
%           https://github.com/gkaguirrelab/fmriMelanopsinMRIAnalysis
% Additional toolboxes deployed by ToolboxToolbox: 
%           MRklar (MaxMel_paper branch) 
%           MRlyze (MaxMel_paper branch) 
%           temporalFittingEngine


%% Before starting: make sure all files are in place
% 1.Decompress the full dataset in your "dataDir". Do not alter the path
% structure of dataDir.

% 2. Decompress the freesurferSubjects dir and copy the content in your
% freesurfer subject folder.

% 3. decompress the anatTemplate archive in your anatTemplatedDir

%% Set toolboxtoolbox configuration for fMRI analysis

tbUseProject('fmriMelanopsinMRIAnalysis');

%% Define initial paths and Parameters

params.resultsDir =  '/data/jag/MELA/MelanopsinMR/results';
params.logDir = '/data/jag/MELA/MelanopsinMR/logs';
params.dataDir = '/data/jag/MELA/MelanopsinMR';
params.anatTemplateDir = '/data/jag/MELA/anat_templates';

%% Create preprocessing scripts
% <!> This cell assumes that the freesurfer subjects files have been copied to
% the local freesurfer subject folder. This will save time while doing
% preprocessing, as the recon all step will be skipped.

fmriMelanopsinMRIAnalysis_createPreprocessingScripts(params);

%% Run the preprocessing scripts
% <!> Evaluating this cell will submit the scripts one by one, one after
% the other. This will likely take serveral days to complete. If you have
% access to a unix cluster architecture, consider navigating in each session
% directoru and launching the job script called "submit_<subjectName>_all.sh"


%%%%%%%%%%  NOTE to GIULIA: this works only on MAC and Linux


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
    
%% Make anatomical templates
fmriMelanopsinMRIAnalysis_makeAnatTemplates(params);

%% Project anatomical templates
fmriMelanopsinMRIAnalysis_projectAnatTemplatesToFunc(params);


%% Assemble V1 time series for the CRF data
fmriMelanopsinMRIAnalysis_makeAllCRFPackets(params);



%%  PART 2. Full brain ChiSquare Maps



% code here



%%  PART 3. Pupil data Analysis



% code here





%%  PART 4. Figure making



% code here





