import vtk

def boxCallback(obj, event):
    # Call back function to resize the cone
    t = vtk.vtkTransform()
    obj.GetTransform(t)
    obj.GetProp3D().SetUserTransform(t)

# Create a Cone
cone = vtk.vtkConeSource()
cone.SetResolution(20)

# Original cone
originalConeMapper = vtk.vtkPolyDataMapper()
originalConeMapper.SetInputConnection(cone.GetOutputPort())
originalConeActor = vtk.vtkActor()
originalConeActor.SetMapper(originalConeMapper)
originalConeActor.GetProperty().SetColor(1,0,0)

# Interactive cone
coneMapper = vtk.vtkPolyDataMapper()
coneMapper.SetInputConnection(cone.GetOutputPort())
coneActor = vtk.vtkActor()
coneActor.SetMapper(coneMapper)

# A renderer and render window
renderer = vtk.vtkRenderer()
renderer.SetBackground(0, 0, 0)
renderer.AddActor(originalConeActor)
renderer.AddActor(coneActor)

renwin = vtk.vtkRenderWindow()
renwin.AddRenderer(renderer)


# An interactor
interactor = vtk.vtkRenderWindowInteractor()
interactor.SetRenderWindow(renwin)
# renStyle = vtk.vtkInteractorStyleTrackballCamera()
# interactor.SetInteractorStyle(renStyle)

# A Box widget
boxWidget = vtk.vtkBoxWidget()
boxWidget.SetInteractor(interactor)
boxWidget.SetProp3D(coneActor)
boxWidget.SetPlaceFactor(1.25)  # Make the box 1.25x larger than the actor
boxWidget.PlaceWidget()
boxWidget.On()

# Connect the event to a function
boxWidget.AddObserver("InteractionEvent", boxCallback)

# Start
interactor.Initialize()
interactor.Start()
