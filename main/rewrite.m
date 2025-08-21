function [fid] = rewrite(filename,matrix)
if ~isempty(matrix)
    fid = fopen(filename,'wt');
    [m,n] = size(matrix);
    for i=1:m
        for j=1:n
            if j==n
                fprintf(fid,'%g\n',matrix(i,j));
            else
                fprintf(fid,'%g\t',matrix(i,j));
            end
        end
    end
    fprintf(fid,'\n');
    fclose(fid);
else
    fid = fopen(filename,'wt');
    fclose(fid);
end
return