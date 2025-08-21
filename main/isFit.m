function [isfit, newFrame] = isFit(Frame, PuzzlePieces, ListOfPossibleSize)

    newFrame = Frame & PuzzlePieces;
    if sum(newFrame,'all')==0
        newFrame = Frame | PuzzlePieces;
        input = bwlabel(~newFrame,4);%input = bwconncomp(~newFrame,4);
        props = regionprops(input, 'Area', 'PixelIdxList');
        ListOfSize = [props.Area]';
        ListOfSize = unique([ListOfSize;ListOfPossibleSize]);
        if length(ListOfSize)~=length(ListOfPossibleSize)
            isfit = false;
        else
            isfit = true;
%             newFrame = Frame | PuzzlePieces;
        end
    else
        isfit = false;
    end

end
%{
function [isfit, newFrame] = isFit(Frame, PuzzlePieces, minPieceSize)

    newFrame = Frame & PuzzlePieces;
    if sum(newFrame,'all')==0
        newFrame = Frame | PuzzlePieces;
        props = regionprops(~newFrame, 'Area', 'PixelIdxList');
        if min([props.Area])<minPieceSize
            isfit = false;
        else
            isfit = true;
            newFrame = Frame | PuzzlePieces;
        end
    else
        isfit = false;
    end

end
%}
%{
function [isfit, newFrame] = isFit(Frame, R, PuzzlePieces)

% Frame, input frame
% R, coordination of new piece (center [x,y])
% PuzzlePieces, Matrix of new piece 5x5

    SizeofFrame = size(Frame);
    tempFrame1 = true(SizeofFrame(1)+4, SizeofFrame(2)+4);
    tempFrame2 = false(SizeofFrame(1)+4, SizeofFrame(2)+4);
    tempFrame1(3:SizeofFrame(1)+2,3:SizeofFrame(2)+2) = Frame;
    tempFrame2(R(1):R(1)+4,R(2):R(2)+4) = PuzzlePieces;
    newFrame = tempFrame1 & tempFrame2;
    if sum(newFrame,'all')==0
        props = regionprops(~newFrame, 'Area', 'PixelIdxList');
        if min([props.Area])<minPieceSize
            isfit = false;
        else
            isfit = true;
            newFrame = tempFrame1 | tempFrame2;
            newFrame = newFrame(3:SizeofFrame(1)+2,3:SizeofFrame(2)+2);
        end
    else
        isfit = false;
    end

end
%}

