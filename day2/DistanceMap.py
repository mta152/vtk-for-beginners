import vtk

# Create sphere 1
sphereSource1 = vtk.vtkSphereSource()
sphereSource1.SetCenter(2, 0, 0)
sphereSource1.SetPhiResolution(100)
sphereSource1.SetThetaResolution(100)
sphereSource1.SetRadius(1)
sphereSource1.Update()
input1 = sphereSource1.GetOutput()

# Create sphere 2
sphereSource2 = vtk.vtkSphereSource()
sphereSource2.SetPhiResolution(100)
sphereSource2.SetThetaResolution(100)
sphereSource2.SetRadius(1)
sphereSource2.Update()
input2 = sphereSource2.GetOutput()

# Remove duplicate vertices on sphere 1
clean1 = vtk.vtkCleanPolyData()
clean1.SetInputData( input1)

# Remove duplicate vertices on sphere 2
clean2 = vtk.vtkCleanPolyData()
clean2.SetInputData( input2)

# Calculate the distance between two sources
distanceFilter = vtk.vtkDistancePolyDataFilter()
distanceFilter.SetInputConnection( 0, clean1.GetOutputPort() )
distanceFilter.SetInputConnection( 1, clean2.GetOutputPort() )
distanceFilter.Update()

# Create mapper
mapper = vtk.vtkPolyDataMapper()
mapper.SetInputConnection( distanceFilter.GetOutputPort() )
mapper.SetScalarRange(
distanceFilter.GetOutput().GetPointData().GetScalars().GetRange()[0],
distanceFilter.GetOutput().GetPointData().GetScalars().GetRange()[1])

# Create actor
actor = vtk.vtkActor()
actor.SetMapper( mapper )

# Add scalar bar
scalarBar = vtk.vtkScalarBarActor()
scalarBar.SetLookupTable(mapper.GetLookupTable())
scalarBar.SetTitle("Distance")
scalarBar.SetNumberOfLabels(4)

# Render distance field and scalar bar
renderer = vtk.vtkRenderer()
renderer.SetBackground(0,0,0)

renWin = vtk.vtkRenderWindow()
renWin.AddRenderer( renderer )

renWinInteractor = vtk.vtkRenderWindowInteractor()
renWinInteractor.SetRenderWindow( renWin )


renderer.AddActor( actor )
renderer.AddActor2D(scalarBar)

""" # Add sphere 2 to the rendering window
mapper2 = vtk.vtkPolyDataMapper()
mapper2.SetInputConnection( sphereSource2.GetOutputPort() )
actor2 = vtk.vtkActor()
actor2.SetMapper( mapper2 )
renderer.AddActor(actor2) """

renWin.Render()
renWinInteractor.Start()