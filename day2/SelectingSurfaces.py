import vtk
import os

filename =  os.getcwd() + "\\cad-models\\E_Pelvis2.obj" 
reader = vtk.vtkOBJReader()
reader.SetFileName(filename)
 
mapper = vtk.vtkPolyDataMapper()
mapper.SetInputConnection(reader.GetOutputPort())

actor = vtk.vtkActor()
actor.SetMapper(mapper)

# Create a rendering window and renderer
ren = vtk.vtkRenderer()
renWin = vtk.vtkRenderWindow()
renWin.AddRenderer(ren)
 
# Create a renderwindowinteractor
iren = vtk.vtkRenderWindowInteractor()
iren.SetRenderWindow(renWin)

# style = vtk.vtkInteractorStyleDrawPolygon()
# iren.SetInteractorStyle(style)

# Assign actor to the renderer
ren.AddActor(actor)

# Enable user interface interactor
iren.Initialize()
renWin.Render()
iren.Start()