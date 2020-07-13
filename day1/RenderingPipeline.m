clc; clear all;

% Load VTK Library
NET.addAssembly([ADD YOUR ACTIVIZ .NET DIR HERE]);
import Kitware.VTK.*;

% Load model
filename = 'D:\GitHub\vtk-for-beginners\cad-models\femur.stl';
 
reader = vtkSTLReader.New();
reader.SetFileName(filename);
 
mapper = vtkPolyDataMapper.New();
mapper.SetInputConnection(reader.GetOutputPort());

actor = vtkActor.New();
actor.SetMapper(mapper);

% Create a rendering window and renderer
ren = vtkRenderer.New();
renWin = vtkRenderWindow.New();
renWin.AddRenderer(ren);
 
% Create a renderwindowinteractor
iren = vtkRenderWindowInteractor.New();
iren.SetRenderWindow(renWin);

% Assign actor to the renderer
ren.AddActor(actor);

% Enable user interface interactor
iren.Initialize();
renWin.Render();
iren.Start();