%% Master script for Spitschan et al. (2017)
%
% Reference: Spitschan M, Bock A, Ryan J, Frazzetta G, Brainard DH, Aguirre
% GK (2017) The human visual cortex response to melanopsin-directed
% stimulation is accompanied by a distinct perceptual experience, bioRxiv,
% https://doi.org/10.1101/138768

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (0) Dependencies and path
% This script relies heavily on automatic path configuration using
% ToolboxToolbox:
%           https://github.com/ToolboxHub/ToolboxToolbox
%
% Once installed, use the following to obtain the "reference" repositories.
% This will download the repositories and allow you to call their
% dependencies using the calls to tbUse below.
projRoot = tbGetPref('projectRoot', tbGetPref('projectRoot', fullfile(tbUserFolder(), 'projects')));
tbUseProject('spitschan_2017_NatureNeuro', 'ToolboxRoot', projRoot);

% Data are hosted on figshare. 
% For steps (3)-(5), all necessary raw data are in the tar ball archive
% spitschan_2017_data.tgz.a{a-p}. The MD5 sums are:
%     MD5 (spitschan_2017_data.tgz.aa) = a74aa0d6ec05ec88ea35bc02c705b567
%     MD5 (spitschan_2017_data.tgz.ab) = c678cd5f6b79600426129f8f214b31ad
%     MD5 (spitschan_2017_data.tgz.ac) = 4b9214d8bfbfa63a3781366d21ea2c9a
%     MD5 (spitschan_2017_data.tgz.ad) = 075e0deae646fe5dcdb4787a46949a61
%     MD5 (spitschan_2017_data.tgz.ae) = 1b31d028b24b578190f915bf76687033
%     MD5 (spitschan_2017_data.tgz.af) = b9f89764cba5d9b0373a40b6980b9871
%     MD5 (spitschan_2017_data.tgz.ag) = f8fb6f95769a08b62aab0256270f831d
%     MD5 (spitschan_2017_data.tgz.ah) = 547d70a478484effbdb7b1d5613d7b4a
%     MD5 (spitschan_2017_data.tgz.ai) = 9f41be4082d7865d985d96ceda2caa3d
%     MD5 (spitschan_2017_data.tgz.aj) = 6e4029d853e842b149b132f72e24c921
%     MD5 (spitschan_2017_data.tgz.ak) = 7d3b6e43c3e516be8041a42530ec8399
%     MD5 (spitschan_2017_data.tgz.al) = 448a993018cbecc5e3778d98243970ec
%     MD5 (spitschan_2017_data.tgz.am) = e0a7073fbb2e30592fc60ac6bc0aaa90
%     MD5 (spitschan_2017_data.tgz.an) = 6925c994898dcea4138c177e4aa9a484
%     MD5 (spitschan_2017_data.tgz.ao) = bae8b0ab38d2dd12334b686d9d5496b4
%     MD5 (spitschan_2017_data.tgz.ap) = 4196514bfe46233c7fc4c1224b864b04
%
% The perceptual data are provided in:
%     MD5 (spitschan_2017_psychodata.tgz.aa) = 6c7d7d43100788523d54abed00821531

% The pupil data are provided as pre-packaged packets here (but they can
% also be re-generated from the raw data above):
%     MD5 (spitschan_2017_pupilpackets.tgz.aa) = a3f191c875cbd6823aa3d1b882b46448

% Please check the integrity of the files before using them. Uncompress the
% tarball into a directory and set the path here:
ppsRawDataDir = '~/Desktop/spitschan_2017_data';
ppsPupilPacketsDir = '~/Desktop/spitschan_2017_pupilpackets';
ppsPsychoDir = '/Users/spitschan/Desktop/spitschan_2017_psychodata';
analysisDir = '~/Desktop/spitschan_2017_analysis';

% Make the output directories
if ~isdir(analysisDir);
   mkdir(analysisDir);
   mkdir(analysisDir, 'figures');
   mkdir(analysisDir, 'tables');
end

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
%
% The pupil analysis can be done either with the raw data or with pre-made
% packets. Set the flag accordingly in pupilPMEL_main.

%% (3a) Set up ToolboxToolbox configuration for pupil analysis
tbUseProject('pupilMelanopsinMRIAnalysis');

%% (3b) Pupil data analysis
pupilPMEL_main(ppsRawDataDir, ppsPupilPacketsDir, analysisDir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (4) Psychophysical data analysis
% Reference repository:
%           https://github.com/gkaguirrelab/pupilMelanopsinMRIAnalysis

%% (4a) Set up ToolboxToolbox configuration for psychophysical data analysis
tbUseProject('psychoMelanopsinAnalysis');

%% (4b) Pupil data analysis
psychoMelAnalysis_main(ppsPsychoDir, analysisDir);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% (5) Physiological splatter analysis
% Reference repository:
%           https://github.com/gkaguirrelab/splatterMelanopsinMRIAnalysis

%% (5a) Set up ToolboxToolbox configuration for splatter analysis
tbUseProject('splatterMelanopsinMRIAnalysis');

%% (5b) Splatter data analysis
splatterMel_AttentionTask(ppsRawDataDir);
splatterMel_PerceptualDataSplatter(ppsRawDataDir);
splatterMel_PhysiologicalSplatterAnalysis(ppsRawDataDir);
splatterMel_SpectraTable(ppsRawDataDir);
splatterMel_SpectralPlots(ppsRawDataDir);
splatterMel_SplatterAnalysis(ppsRawDataDir);