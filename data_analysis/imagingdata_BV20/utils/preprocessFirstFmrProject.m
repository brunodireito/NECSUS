function [ fmrProject , pathString ] = preprocessFirstFmrProject(configs, fmrProjectNamePath , sliceVector)
% preprocessFirstFmrProject Summary of this function goes here
%   Detailed explanation goes here

% new nomenclature
% fmrProjectNamePath = strrep(fmrProjectNamePath,'_','-');
alignRun=fmrProjectNamePath;
fmrProjectNamePath = char(fmrProjectNamePath);

%% open FmrProject
fmrProjectName = fullfile( configs.dataRootSession, 'func', fmrProjectNamePath, 'PROJECT', 'PROCESSING', [ configs.filesSignature '_' alignRun '_bold.fmr']);

fmrProject = configs.bvqx.OpenDocument( fmrProjectName );

disp(['Preprocessing ' alignRun ' Run...']);

%% -------------------------------------
% PreProcessing step 1 - slice time correction
%-------------------------------------

% First param: Scan order 0 -> Ascending, 1 -> Asc-Interleaved, 2 -> Asc-Int2,
% 10 -> Descending, 11 -> Desc-Int, 12 -> Desc-Int2
% Second param: Interpolation method: 0 -> trilinear, 1 -> cubic spline, 2 -> sinc
[ type , pathString ] = detSliceOrder(sliceVector);
fmrProject.CorrectSliceTiming( type , 1);

SliceCorrectedFmrProject = fmrProject.FileNameOfPreprocessdFMR;

fmrProject.Close;


%% -------------------------------------
% PreProcessing step 2 - Correct motion
%-------------------------------------
fmrProject = configs.bvqx.OpenDocument(SliceCorrectedFmrProject);

TargetVolume = 1;

% the current doc (input FMR) knows the name of the automatically saved output FMR
fmrProject.CorrectMotionEx(TargetVolume, ...% target volume
    2,... % interpolation mode
    true, ... % full dataset
    100,... % number of iterations
    false,... % generate movie
    false); % log file

MotionCorrectedFmrProject = fmrProject.FileNameOfPreprocessdFMR;

fmrProject.Close;

%% -------------------------------------
% Preprocessing step 4: Spatial Gaussian Smoothing (not recommended
% for individual analysis with a 64x64 matrix)
%-------------------------------------

fmrProject = configs.bvqx.OpenDocument(MotionCorrectedFmrProject);

fmrProject.SpatialGaussianSmoothing(2,'mm'); % FWHM value and unit
SpGaussSmoothFmrProject=fmrProject.FileNameOfPreprocessdFMR;

fmrProject.Close; % docFMR.Remove(); % close or remove input FMR

%% -------------------------------------
% PreProcessing step 5: Temporal High Pass Filter, includes Linear Trend Removal
%-------------------------------------

fmrProject = configs.bvqx.OpenDocument(SpGaussSmoothFmrProject);

fmrProject.TemporalHighPassFilterGLMFourier(2);

fmrProject.Close; % docFMR.Remove(); // close or remove input FMR

end