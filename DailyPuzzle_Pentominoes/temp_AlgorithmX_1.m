A = zeros(1,7); B = A; C = B; D = C; E = D; F = E;
A([1 4 7]) = 1; B([1 4]) = 1; C([4 5 7]) = 1; D([3 5 6]) = 1; E([2 3 6 7]) = 1; F([2 7]) = 1; 
M = [A; B; B; C; D; E; F]; % the binary 'A' matrix

sol= dlx(M);

%% Knuth's Algorithm X (Dancing Links; Exact Cover)
%% https://www.mathworks.com/matlabcentral/answers/377975-knuth-s-algorithm-x-dancing-links-exact-cover

function [sol, success] = dlx(A)
    sol = dlx_recursion(A, 1:size(A, 1));
    if isempty(sol)
        success = false;
    else
        success = true;
    end
end

function [sol] = dlx_recursion(A, rownum)
    sol = {};   %empty cell array indicates failure   
    %step 1
    if isempty(A)
        %success
        sol = {[]};
        return;
    end
    %step 2
    [~, c] = min(sum(A, 1));
    if ~any(A(:, c))
        %failure
        return;
    end
    %step 3
    possiblerows = find(A(:, c));
    for tryrow = possiblerows.'
        %step 4 for later, only if success
        %step 5
        deletecols = A(tryrow, :) == 1;
        deleterows = any(A(:, deletecols) == 1, 2);
        reducedA = A(:,~deletecols);
        reducedA = reducedA(~deleterows, :);
        reducedrows = rownum(~deleterows);
        %step 6
        [subsol] = dlx_recursion(reducedA, reducedrows);
        if ~isempty(subsol)
            %step 4 
            %add current row to the all the row combinations returned by the recursion
            sol = [sol; cellfun(@(ss) [rownum(tryrow), ss], subsol, 'UniformOutput', false)]; %#ok<AGROW>
        end
    end
    %if all the tryrow ended in failure then sol is still an empty cell array which indicates failure on return
end