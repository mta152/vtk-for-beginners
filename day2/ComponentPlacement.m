clc; clear all;

% Load VTK Library
NET.addAssembly([ADD YOUR ACTIVIZ .NET DIR HERE]);
import Kitware.VTK.*;

% Specify model directory
modelPath = '\cad-models';

% Setup model structure using Stand_Neutral.HSIM
load('cad-models\Stance_Neutral.mat');

mTorIdx = find(strcmp('T',{LocalHandles.Objects.Bodies.Name}));      % Torso
mPelIdx = find(strcmp('E',{LocalHandles.Objects.Bodies.Name}));      % Pelvis
mFemIdx = find(strcmp('D',{LocalHandles.Objects.Bodies.Name}));      % Femur
mTibIdx = find(strcmp('C',{LocalHandles.Objects.Bodies.Name}));      % Tibia
mFootIdx = find(strcmp('B',{LocalHandles.Objects.Bodies.Name}));     % Foot

mModels.torso.filePath = [pwd modelPath '\TorsoMT_Origin.obj'];
mModels.torso.txf = LocalHandles.Objects.Bodies(mTorIdx).Transformations(1,:);

mModels.pelvis.filePath = [pwd modelPath '\E_Pelvis2.obj'];
mModels.pelvis.txf = LocalHandles.Objects.Bodies(mPelIdx).Transformations(1,:);

mModels.femur.filePath = [pwd modelPath '\D_Femur2.obj'];
mModels.femur.txf = LocalHandles.Objects.Bodies(mFemIdx).Transformations(1,:);

mModels.tibia.filePath = [pwd modelPath '\C_Tibia2.obj'];
mModels.tibia.txf = LocalHandles.Objects.Bodies(mTibIdx).Transformations(1,:);

mModels.foot.filePath = [pwd modelPath '\B_Foot2.obj'];
mModels.foot.txf = LocalHandles.Objects.Bodies(mFootIdx).Transformations(1,:);

% Place and visualize all models
vtkHandler = ModelsPlacement(mModels);
disp('Visualization starts...')