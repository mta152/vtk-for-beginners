clc; clear all;

% Load VTK Library
NET.addAssembly([ADD YOUR ACTIVIZ .NET DIR HERE]);
import Kitware.VTK.*;

% Model DIr
filePath = 'D:\GitHub\vtk-for-beginners\cad-models\femur.stl';

reader = vtkSTLReader.New();
reader.SetFileName(filePath);
reader.Update();

mapper = vtkPolyDataMapper.New();
mapper.SetInputConnection(reader.GetOutputPort());

actor = vtkActor.New();
actor.SetMapper(mapper);

mapper1 = vtkPolyDataMapper.New();
mapper1.SetInputConnection(reader.GetOutputPort());

actor1 = vtkActor.New();
actor1.SetMapper(mapper);
actor1.GetProperty().SetColor(1,0,0);

transform = vtkTransform.New();
transform.Translate(10.0, 0 ,0);
actor1.SetUserTransform(transform);

% get a reference to the renderwindow of our renderWindowControl1
renderWindow = vtkRenderWindow.New();

% renderer
renderer = vtkRenderer.New();

% set background color
renderer.SetBackground(0.2, 0.3, 0.4);
renderWindow.AddRenderer(renderer);

% Create a renderwindowinteractor
iren = vtkRenderWindowInteractor.New();
iren.SetRenderWindow(renderWindow);

% add our actor to the renderer
renderer.AddActor(actor);
renderer.AddActor(actor1);

% Enable user interface interactor
iren.Initialize();
renderWindow.Render();
iren.Start();