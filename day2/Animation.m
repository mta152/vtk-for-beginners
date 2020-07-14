clc; clear all;

% Load VTK Library
NET.addAssembly('C:\Program Files\ActiViz.NET 7.1.0 Supported Edition\bin\Kitware.VTK.dll');
import Kitware.VTK.*;

% Specify model directory
modelPath = '\cad-models';

% Setup model structure using Stand_Neutral.HSIM
copyfile([pwd modelPath '\Stance_Neutral.HSIM'],'Temp.mat','f');
load('Temp.mat');
delete('Temp.mat');

mTorIdx = find(strcmp('T',{LocalHandles.Objects.Bodies.Name}));      % Torso
mPelIdx = find(strcmp('E',{LocalHandles.Objects.Bodies.Name}));      % Pelvis
mFemIdx = find(strcmp('D',{LocalHandles.Objects.Bodies.Name}));      % Femur
mTibIdx = find(strcmp('C',{LocalHandles.Objects.Bodies.Name}));      % Tibia
mFootIdx = find(strcmp('B',{LocalHandles.Objects.Bodies.Name}));     % Foot
mCupIdx = find(strcmp('AC',{LocalHandles.Objects.Bodies.Name}));     % Cup
mStemIdx = find(strcmp('FC',{LocalHandles.Objects.Bodies.Name}));    % Femoral Stem
mPatIdx = find(strcmp('F',{LocalHandles.Objects.Bodies.Name}));      % Patella

mModelName = {'B_Foot2.obj', 'C_Tibia2.obj', 'D_Femur2.obj', 'F_Patella2.obj', 'E_Pelvis2.obj', 'AC_AceComp.obj', 'FemComp3.obj', 'TorsoMT_Origin.obj'};
mBodyIdx = {mFootIdx, mTibIdx, mFemIdx, mPatIdx, mPelIdx, mCupIdx, mStemIdx, mTorIdx};
mBodyName = {LocalHandles.Objects.Bodies.Name};

for i = 1:numel(mModelName)
    mModels.(mBodyName{mBodyIdx{i}}).filePath = [pwd modelPath '\' mModelName{i}];
    mModels.(mBodyName{mBodyIdx{i}}).txf = LocalHandles.Objects.Bodies(mBodyIdx{i}).Transformations(1,:);
end

% Place and visualize all models
vtkHandler = ModelsPlacement(mModels);
disp('Visualization starts...')

% Get model kinematics (from ADR_Forward.adr)
copyfile([pwd modelPath '\ADR_Forward.adr'],'Temp.mat','f');
ADRhandles = load('Temp.mat');
delete('Temp.mat');

modelCount = numel(fieldnames(mModels));
modelNames = fieldnames(mModels);
frameCount = length(ADRhandles.Objects.Bodies(1).Transformations);

% Animate
for i = 1:frameCount
    for j = 1:modelCount
        currentModelIdx = find(strcmp(mBodyName{j},{ADRhandles.Objects.Bodies.Name}));
        tempTransform = ADRhandles.Objects.Bodies(currentModelIdx).Transformations(i,:); 
        
        SetActorTransform(vtkHandler.actor{mBodyIdx{j}}, txfConvert(tempTransform));
    end
    vtkHandler.renWin.Render();
    pause(0.02);
end