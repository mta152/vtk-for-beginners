clc; clear all;
% Load VTK Library
NET.addAssembly([ADD YOUR ACTIVIZ .NET DIR HERE]);
import Kitware.VTK.*;

% Load femur model
femurFile = 'C:\Users\mta\Desktop\vtk-for-beginners\cad-models\femur.stl';
 
femurReader = vtkSTLReader.New();
femurReader.SetFileName(femurFile);
 
femurMapper = vtkPolyDataMapper.New();
femurMapper.SetInputConnection(femurReader.GetOutputPort());

femurActor = vtkActor.New();
femurActor.SetMapper(femurMapper);

% Load tibia model
tibiaFile = 'C:\Users\mta\Desktop\vtk-for-beginners\cad-models\tibia.stl';
 
tibiaReader = vtkSTLReader.New();
tibiaReader.SetFileName(tibiaFile);
 
tibiaMapper = vtkPolyDataMapper.New();
tibiaMapper.SetInputConnection(tibiaReader.GetOutputPort());

tibiaActor = vtkActor.New();
tibiaActor.SetMapper(tibiaMapper);

% Change color and opacity
femurActor.GetProperty().SetColor(1,0,0);
femurActor.GetProperty().SetOpacity(0.5);
tibiaActor.GetProperty().SetColor(0,1,0);

% Create a rendering window and renderer
ren = vtkRenderer.New();
renWin = vtkRenderWindow.New();
renWin.AddRenderer(ren);
 
% Create a renderwindowinterfemurActor
iren = vtkRenderWindowInteractor.New();
iren.SetRenderWindow(renWin);

% Add femurActor to the renderer
ren.AddActor(femurActor);
ren.AddActor(tibiaActor);

% Enable user interface interfemurActor
iren.Initialize();
renWin.Render();
iren.Start();