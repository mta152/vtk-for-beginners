clc; clear all;

% Load VTK Library
NET.addAssembly([ADD YOUR ACTIVIZ .NET DIR HERE]);
import Kitware.VTK.*;

% Load Femur
femurPath = 'D:\GitHub\vtk-for-beginners\cad-models\femur.stl';

femurReader = vtkSTLReader.New();
femurReader.SetFileName(femurPath);
femurReader.Update();

femurMapper = vtkPolyDataMapper.New();
femurMapper.SetInputConnection(femurReader.GetOutputPort());

femurActor = vtkActor.New();
femurActor.SetMapper(femurMapper);

% Load Tibia
tibiaPath = 'D:\GitHub\vtk-for-beginners\cad-models\tibia.stl';

tibiaReader = vtkSTLReader.New();
tibiaReader.SetFileName(tibiaPath);
tibiaReader.Update();

tibiaMapper = vtkPolyDataMapper.New();
tibiaMapper.SetInputConnection(tibiaReader.GetOutputPort());

tibiaActor = vtkActor.New();
tibiaActor.SetMapper(tibiaMapper);

% Change femur and tibia color
femurActor.GetProperty().SetColor(1,0,0); % RGB
tibiaActor.GetProperty().SetColor(0,1,0);

femurActor.GetProperty().LightingOff();

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

% add our femurActor to the renderer
renderer.AddActor(femurActor);
renderer.AddActor(tibiaActor);

% Enable user interface interactor
iren.Initialize();
renderWindow.Render();
iren.Start();