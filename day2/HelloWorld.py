# -*- coding: utf-8 -*-
"""
Created on Fri May 25 11:33:14 2018

@author: manht
"""

import vtk

def main():
  textActor = vtk.vtkTextActor()
  textActor.SetInput("Hello CMR")
  textActor.SetTextScaleModeToProp ()
  tprop = textActor.GetTextProperty()
  tprop.SetFontSize(40)

  earthSource = vtk.vtkEarthSource()

  mapper = vtk.vtkPolyDataMapper()
  mapper.SetInputConnection(earthSource.GetOutputPort())

  actor = vtk.vtkActor()
  actor.SetMapper(mapper)

  renderWindow = vtk.vtkRenderWindow()
  renderer = vtk.vtkRenderer()
  renderWindow.AddRenderer(renderer)
  renderWindow.SetSize(500,500)

  renderWindowInteractor = vtk.vtkRenderWindowInteractor()
  renderWindowInteractor.SetRenderWindow(renderWindow)

  renderer.AddActor(actor)
  renderer.AddActor2D(textActor)

  renderWindow.Render()

  renderWindow.Render()
  renderWindowInteractor.Start()

main()
