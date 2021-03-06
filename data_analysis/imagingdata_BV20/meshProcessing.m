% mesh analysis -
% Create meshes (automatic segmentation)
% -> Always adjust contrast values of TAL file and save before automatic
% segmentation.
% Create MTC files

%% SOP 6.1, 6.2

% Initialize COM
configs.bvqx = actxserver('BrainVoyager.BrainVoyagerScriptAccess.1');

[filepath,filename,ext] = fileparts(configs.averageAnatProject);

% Open a VMR project:
vmrProject = configs.bvqx.OpenDocument(fullfile(filepath, [filename '_aTAL' ext]));


%% surface

hem = {'RH', 'LH'};

for h=1:numel(hem)
    % Right hemisphere
    % Get the name of the mesh:
    [filepath,~,~] = fileparts(configs.averageAnatProject)
    srfFile=dir(fullfile(filepath, ['*_' hem{h} '_RECOSM.srf']));
    % Create the SRF name:
    srfname = fullfile(srfFile(1).folder,srfFile(1).name);
    % Load the mesh:
    vmrProject.LoadMesh(srfname);
    
    %
    meshSRF=vmrProject.CurrentMesh;

    %
    meshSRF.MorphingUpdateInterval = 50;
    % SmoothRecoMesh(): special "high-frequency" smoothing: removing jags of reconstructed
    % voxel borders without shrinking mesh
    meshSRF.InflateMesh(800,0.8,'');
    % InflateMesh(): if "" used for 3rd param (area reference mesh), the current mesh
    % at the moment the function is called is used to calculate ref mesh area

    %
    meshSRF.CalculateCurvature
    % how to smooth the curvature map?

    % current srf/mesh and save
    [filepath,filename,ext]=fileparts(srfname);
    currentSRFfileName=fullfile(filepath, [filename '_INFL' ext]);
    meshSRF.SaveAs(currentSRFfileName)
    
    % Define the occipital lobe for each hemisphere
    ok=input(['please select the occipital lobe ROI (save as OC_' hem{h} '.poi). Press any key to continue.']);

end

