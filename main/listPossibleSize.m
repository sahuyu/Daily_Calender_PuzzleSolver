function [ListOfPossibleSize] = listPossibleSize(PuzzlePiecesBlockNo)
    NoPuzzlePieces = length(PuzzlePiecesBlockNo);
    List = zeros(2^NoPuzzlePieces,1);
    for i=0:length(List)-1
        binstr = dec2bin(i,NoPuzzlePieces)=='1';
        List(i+1) = sum(PuzzlePiecesBlockNo(binstr));
    end
    List = unique(List);
    ListOfPossibleSize = List(2:end,1);
end