function [success] = createPosFile (vmrFile, fileName)

success=0;

try
    fileID = fopen([fileName '.pos'],'w');
    
    % Fileversion.
    fprintf(fileID,'FileVersion:\t\t%s\n','3');
    % ProjectType.
    fprintf(fileID,'ProjectType:\t\t%s\n','VMR');
    % NrOfSlices.
    fprintf(fileID,'NrOfSlices:\t\t%i\n',vmrFile.DimZ);
    % Slice1CenterX.
    fprintf(fileID,'Slice1CenterX:\t\t%.6f\n',vmrFile.Slice1CenterX);
    % Slice1CenterY.
    fprintf(fileID,'Slice1CenterY:\t\t%.6f\n',vmrFile.Slice1CenterY);
    % Slice1CenterZ.
    fprintf(fileID,'Slice1CenterZ:\t\t%.6f\n',vmrFile.Slice1CenterZ);
    % SliceNCenterX.
    fprintf(fileID,'SliceNCenterX:\t\t%.6f\n',vmrFile.SliceNCenterX);
    % SliceNCenterY.
    fprintf(fileID,'SliceNCenterY:\t\t%.6f\n',vmrFile.SliceNCenterY);
    % SliceNCenterZ.
    fprintf(fileID,'SliceNCenterZ:\t\t%.6f\n',vmrFile.SliceNCenterZ);
    % RowDirX.
    fprintf(fileID,'RowDirX:\t\t%.6f\n',vmrFile.RowDirX);
    % RowDirY.
    fprintf(fileID,'RowDirY:\t\t%.6f\n',vmrFile.RowDirY);
    % RowDirZ.
    fprintf(fileID,'RowDirZ:\t\t%.6f\n',vmrFile.RowDirZ);
    % ColDirX.
    fprintf(fileID,'ColDirX:\t\t%.6f\n',vmrFile.ColDirX);
    % ColDirY.
    fprintf(fileID,'ColDirY:\t\t%.6f\n',vmrFile.ColDirY);
    % ColDirZ.
    fprintf(fileID,'ColDirZ:\t\t%.6f\n',vmrFile.ColDirZ);
    % MatrixRows.
    fprintf(fileID,'MatrixRows:\t\t%i\n',vmrFile.NRows);
    % MatrixColumns.
    fprintf(fileID,'MatrixCols:\t\t%i\n',vmrFile.NCols);
    % FoVRows.
    fprintf(fileID,'FoVRows:\t\t%i\n',vmrFile.FoVRows);
    % FoVCols.
    fprintf(fileID,'FoVCols:\t\t%i\n',vmrFile.FoVCols);
    % SliceThickness.
    fprintf(fileID,'SliceThickness:\t\t%.6f\n',vmrFile.SliceThickness);
    % GapThickness.
    fprintf(fileID,'GapThickness:\t\t%.6f\n',vmrFile.GapThickness);
    % CoordinateSystem.
    fprintf(fileID,'CoordinateSystem:\t\t%i\n',vmrFile.CoordinateSystem);
    

    
    fclose(fileID);
    
catch me
    disp(me)
end

success=1;


end