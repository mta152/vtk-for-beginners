function vtkHandler = ModelsPlacement(modelStruct)

% Load VTK Library
import Kitware.VTK.*;

modelCount = numel(fieldnames(modelStruct));

modelNames = fieldnames(modelStruct);

% Create a rendering window and renderer
vtkHandler.renderer = vtkRenderer.New();
vtkHandler.renWin = vtkRenderWindow.New();
vtkHandler.renWin.AddRenderer(vtkHandler.renderer);
 
% Create a renderwindowinterctor
vtkHandler.iRen = vtkRenderWindowInteractor.New();
vtkHandler.iRen.SetRenderWindow(vtkHandler.renWin);

% Change interactor style to trackball camera
iStyle = vtkInteractorStyleTrackballCamera.New(); 
vtkHandler.iRen.SetInteractorStyle(iStyle);

for i = 1:modelCount
    % Load the source file
    vtkHandler.originalSource{i} = vtkOBJReader.New();
    vtkHandler.originalSource{i}.SetFileName(modelStruct.(modelNames{i}).filePath);
    
    % Create mapper
    vtkHandler.mapper{i} = vtkPolyDataMapper.New();
    vtkHandler.mapper{i}.SetInputConnection(vtkHandler.originalSource{i}.GetOutputPort());
    
    % Create actor
    vtkHandler.actor{i} = vtkActor.New();
    vtkHandler.actor{i}.SetMapper(vtkHandler.mapper{i});
    
    % Transform actor
    SetActorTransform(vtkHandler.actor{i}, txfConvert(modelStruct.(modelNames{i}).txf));
     
    % Add Actor to the renderer
    vtkHandler.renderer.AddActor(vtkHandler.actor{i});
end

% Force to render
vtkHandler.iRen.Initialize();
vtkHandler.renWin.Render();