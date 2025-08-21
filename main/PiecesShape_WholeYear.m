% 9 pieces, start in a 5x5 empty space
NoPuzzlePieces = 9;
PuzzlePieces = repmat({false(5,5)},NoPuzzlePieces,8);
PuzzlePiecesBlockNo = zeros(NoPuzzlePieces,1);

% ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ
% ¡õ¡õ¡ö¡õ¡õ % ¡õ¡ö¡õ¡õ¡õ % ¡õ¡ö¡ö¡ö¡õ % ¡ö¡ö¡ö¡ö¡õ % ¡õ¡ö¡ö¡ö¡õ % ¡õ¡ö¡ö¡ö¡õ % ¡õ¡ö¡ö¡ö¡õ % ¡õ¡ö¡ö¡õ¡õ % ¡õ¡ö¡ö¡õ¡õ
% ¡õ¡ö¡ö¡ö¡õ % ¡õ¡ö¡ö¡ö¡õ % ¡õ¡ö¡õ¡ö¡õ % ¡ö¡õ¡õ¡õ¡õ % ¡õ¡ö¡ö¡õ¡õ % ¡õ¡õ¡ö¡õ¡õ % ¡õ¡ö¡õ¡õ¡õ % ¡õ¡ö¡ö¡õ¡õ % ¡õ¡õ¡ö¡ö¡õ
% ¡õ¡õ¡ö¡õ¡õ % ¡õ¡õ¡õ¡ö¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ
% ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ % ¡õ¡õ¡õ¡õ¡õ
PuzzlePieces{1,1}(2,3)=true;PuzzlePieces{1,1}(3,2:4)=true;PuzzlePieces{1,1}(4,3)=true;
PuzzlePieces{2,1}(2,2)=true;PuzzlePieces{2,1}(3,2:4)=true;PuzzlePieces{2,1}(4,4)=true;
PuzzlePieces{3,1}(2,2:4)=true;PuzzlePieces{3,1}(3,[2,4])=true;
PuzzlePieces{4,1}(2,1:4)=true;PuzzlePieces{4,1}(3,1)=true;
PuzzlePieces{5,1}(2,2:4)=true;PuzzlePieces{5,1}(3,2:3)=true;
PuzzlePieces{6,1}(2,2:4)=true;PuzzlePieces{6,1}(3,3)=true;
PuzzlePieces{7,1}(2,2:4)=true;PuzzlePieces{7,1}(3,2)=true;
PuzzlePieces{8,1}(2,2:3)=true;PuzzlePieces{8,1}(3,2:3)=true;
PuzzlePieces{9,1}(2,2:3)=true;PuzzlePieces{9,1}(3,3:4)=true;

for n=1:NoPuzzlePieces
    PuzzlePiecesBlockNo(n) = sum(PuzzlePieces{n,1},'all');
end
ListOfPossibleSize = cell(NoPuzzlePieces,1);
for n=1:NoPuzzlePieces
    ListOfPossibleSize{n} = listPossibleSize(PuzzlePiecesBlockNo(n:end));
end

% Flip Vertical, Flip Horizontal, Roate(counterclockwise) 90
% [Boolean number, Boolean number, Boolean number]
for n=1:NoPuzzlePieces
    for i=0:1:7
        temp = PuzzlePieces{n,1};
        binstr = dec2bin(i,3)=='1';
        if binstr(3)
            temp = flip(temp);
        end
        if binstr(2)
            temp = flip(temp,2);
        end
        if binstr(1)
            temp = rot90(temp);
        end
        PuzzlePieces{n,i+1} = temp;
    end
end