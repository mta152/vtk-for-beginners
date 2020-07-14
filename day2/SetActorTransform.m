function SetActorTransform(vActor, mTxF)
import Kitware.VTK.*;

vtk4x4 = vtkMatrix4x4.New();
for irow = 1:4
    for icol = 1:4
        vtk4x4.SetElement(irow-1, icol-1, mTxF(irow, icol));
    end
end

vActor.SetUserMatrix(vtk4x4);