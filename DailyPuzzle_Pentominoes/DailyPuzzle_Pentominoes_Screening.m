clear

%% Frame shape
FrameDefault = false(8,8);
FrameDefault(3,3) =true;

%% Pieces shape
% 12 pieces, start in a 5x5 empty space
NoPuzzlePieces = 12;
PuzzlePieces = repmat({false(5,5)},NoPuzzlePieces,8);
PuzzlePiecesBlockNo = zeros(NoPuzzlePieces,1);

% □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□
% □□□□□ % □□■□□ % □■■■□ % □■□■□ % □■■■□ % □■□□□ % □□□■□ % □■■□□ % □■□□□ % □□□■■ % □□■□□ % □□□■□
% ■■■■■ % □■■■□ % □□■□□ % □■■■□ % □■□□□ % □■■■□ % □□■■□ % □■■■□ % □■■■□ % □■■■□ % ■■■■□ % ■■■■□
% □□□□□ % □□■□□ % □□■□□ % □□□□□ % □■□□□ % □□□■□ % □■■□□ % □□□□□ % □□■□□ % □□□□□ % □□□□□ % □□□□□
% □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□
PuzzlePieces{1,1}(3,:)=true;
PuzzlePieces{2,1}(3,2:4)=true;PuzzlePieces{2,1}(2:4,3)=true;
PuzzlePieces{3,1}(2,2:4)=true;PuzzlePieces{3,1}(2:4,3)=true;
PuzzlePieces{4,1}(3,2:4)=true;PuzzlePieces{4,1}(2,[2,4])=true;
PuzzlePieces{5,1}(2,2:4)=true;PuzzlePieces{5,1}(3:4,2)=true;
PuzzlePieces{6,1}(3,2:4)=true;PuzzlePieces{6,1}(2,2)=true;PuzzlePieces{6,1}(4,4)=true;
PuzzlePieces{7,1}(4,2:3)=true;PuzzlePieces{7,1}(3,3:4)=true;PuzzlePieces{7,1}(2,4)=true;
PuzzlePieces{8,1}(3,2:4)=true;PuzzlePieces{8,1}(2,2:3)=true;
PuzzlePieces{9,1}(3,2:4)=true;PuzzlePieces{9,1}(2,2)=true;PuzzlePieces{9,1}(4,3)=true;
PuzzlePieces{10,1}(3,2:4)=true;PuzzlePieces{10,1}(2,4:5)=true;
PuzzlePieces{11,1}(3,1:4)=true;PuzzlePieces{11,1}(2,3)=true;
PuzzlePieces{12,1}(3,1:4)=true;PuzzlePieces{12,1}(2,4)=true;

for n=1:NoPuzzlePieces
    PuzzlePiecesBlockNo(n) = sum(PuzzlePieces{n,1},'all');
end

if true
    MaxNperRow = 4;
    NRow = ceil(NoPuzzlePieces/MaxNperRow);
    H2 = tiledlayout(NRow,MaxNperRow,'TileSpacing','compact','Padding','loose');
    for i=1:NoPuzzlePieces
        nexttile
        H20 = pcolor([PuzzlePieces{i,1},zeros(5,1);zeros(1,6)]);
        colormap([1 1 1; 0 0 0]);
        axis equal
        xlim([1 6])
        ylim([1 6])
        set(gca, 'xticklabel', [], 'yticklabel', []);
    end
end

% Flip Vertical, Flip Horizontal, Roate(counterclockwise) 90
% [Boolean number, Boolean number, Boolean number]
for n=1:NoPuzzlePieces
    for i=0:1:7
        temp_p = PuzzlePieces{n,1};
        binstr = dec2bin(i,3)=='1';
        if binstr(3)
            temp_p = flip(temp_p);
        end
        if binstr(2)
            temp_p = flip(temp_p,2);
        end
        if binstr(1)
            temp_p = rot90(temp_p);
        end
        PuzzlePieces{n,i+1} = temp_p;
    end
end

%% Initalization
SizeFrame = size(FrameDefault);
ExpandedFrame = true(SizeFrame(1)+4, SizeFrame(2)+4);
ExpandedFrame(3:SizeFrame(1)+2,3:SizeFrame(2)+2) = FrameDefault;
LN = SizeFrame(1)*SizeFrame(2)*8;

ExpandedPuzzlePieces = repmat({false(SizeFrame(1),SizeFrame(2))},NoPuzzlePieces,LN);
ExpandedPuzzlePiecesFlag = false(NoPuzzlePieces,LN);
for i=1:NoPuzzlePieces
    for L0=1:LN
        R0 = ceil(L0/8);
        P0 = rem(L0,8);
        if P0==0
            P0 = 8;
        end
        R0x = ceil(R0/SizeFrame(2));
        R0y = rem(R0,SizeFrame(2));
        if R0y==0
            R0y = SizeFrame(2);
        end
        tempFrame = false(SizeFrame(1)+4, SizeFrame(2)+4);
        tempFrame(R0x:R0x+4,R0y:R0y+4) = PuzzlePieces{i,P0};
        OverlayFrame = tempFrame & ExpandedFrame;
        if sum(OverlayFrame,'all')==0
            ExpandedPuzzlePieces{i,L0} = tempFrame(3:SizeFrame(1)+2,3:SizeFrame(2)+2);
            ExpandedPuzzlePiecesFlag(i,L0) = true;
        end
    end
end
ValuableDigit = ~reshape(FrameDefault,1,[]);
for i=1:NoPuzzlePieces
    tempIndex = zeros(1,LN,'int64');
    for L0=1:LN
        % treat matrix of [0,1] as binary
        reshapeMatrix = reshape(ExpandedPuzzlePieces{i,L0},1,[]);
        binValue = num2str(reshapeMatrix(ValuableDigit),'%d');
        tempIndex(1,L0) = LongBin2Dec(binValue);
    end
    [~, UniqueIndex, ~] = unique(tempIndex);
    tempFlag = false(1,LN);
    tempFlag(UniqueIndex) = true;
    ExpandedPuzzlePiecesFlag(i,:) = ExpandedPuzzlePiecesFlag(i,:) & tempFlag;
end

Solution_all = [];
NoBlocks = SizeFrame(1)*SizeFrame(2);
MaxIndex = sum(ExpandedPuzzlePiecesFlag,'all') + 1;
ExactCoverMatrix = false(MaxIndex, NoBlocks + NoPuzzlePieces + 1);
% raw: all possible positions of the puzzle pieces; FrameQuestion
% column: each block of the puzzle is filled; each piece is chosen; Question is solved

% Each possible positions of the puzzle pieces
IndexofPuzzlePieces = cell(1,sum(ExpandedPuzzlePiecesFlag,'all'));
Index_temp = 0;
for i=1:NoPuzzlePieces
    for j=1:LN
        if ExpandedPuzzlePiecesFlag(i,j)
            Index_temp = Index_temp+1;
            IndexofPuzzlePieces{Index_temp} = [i,j];
            ExactCoverMatrix(Index_temp,1:NoBlocks) = reshape(ExpandedPuzzlePieces{i,j}, 1, NoBlocks);
            ExactCoverMatrix(Index_temp,NoBlocks+i) = true;
        end
    end
end

%% Qusetion

Week2String = ['Mon';'Tue';'Wed';'Thu';'Fri';'Sat';'Sun'];
for nn = 1:12*31*7

    Month = ceil(nn/(31*7));
    temp = rem(nn,31*7);
    if temp==0
        temp = 31*7;
    end
    Day = ceil(temp/7);
    Week = rem(temp,7);
    if Week==0
        Week=7;
    end

    FrameQuestion = dailyPuzzle_Pentominoes(Month,Day,Week);

    Frame = FrameDefault | FrameQuestion;
    % FrameQuestion
    ExactCoverMatrix(end,:) = [reshape(Frame, 1, NoBlocks), false(1,NoPuzzlePieces), true];

    Solution_all = [];

    u = 1:size(ExactCoverMatrix,2);
    s = cell(1,size(ExactCoverMatrix,1));
    for i=1:size(ExactCoverMatrix,1)
        s{i} = find(ExactCoverMatrix(i,:));
    end
    Sol = AlgorithmX(u,s,true);

    if ~isempty(Sol)
        N_sol = length(Sol);
    else
        N_sol = 0;
    end

fprintf('Daily Puzzle on %s(%s) solved, >%d solution(s) found.\n', date2String(Month,Day),Week2String(Week,:), N_sol);

end
 
%% Function

function [frame_question] = dailyPuzzle_Pentominoes(Month,Day,Week)
    frame_question = false(8,8);
    MN = [1,1; 2,1; 1,2; 3,1; 2,2; 1,3; 4,1; 3,2; 2,3; 1,4; 5,1; 1,5];
    frame_question(MN(Month,1),MN(Month,2)) = true;
    DN = [6,1; 5,2; 4,3; 3,4; 2,5; 1,6; 7,1; 6,2; 5,3; 4,4; 3,5; 2,6; 1,7; 8,1; 7,2; 6,3; 5,4; 4,5; 3,6; 2,7; 1,8; 8,2; 7,3; 6,4; 4,6; 3,7; 2,8; 8,3; 7,4; 4,7; 3,8];
    frame_question(DN(Day,1),DN(Day,2)) = true;
    WN = [8,5; 8,6; 8,7; 8,8; 7,8; 6,8; 5,8];
    frame_question(WN(Week,1),WN(Week,2)) = true;
end

function [Dec] = LongBin2Dec(Bin)
    MaxLen = 52;
    BinLen = length(Bin);
    n = ceil(BinLen ./ MaxLen);
    Dec = zeros(1,'int64');
    for i = 1:n
        BinPart = Bin((i - 1) * MaxLen + 1:min(i * MaxLen, BinLen));
        Dec = Dec .* 2^length(BinPart) + bin2dec(BinPart);
    end
end

function [StringDate] = date2String(Month, Day)
    switch Month
        case 1
            StringDate1 = 'Jan';
        case 2
            StringDate1 = 'Feb';
        case 3
            StringDate1 = 'Mar';
        case 4
            StringDate1 = 'Apr';
        case 5
            StringDate1 = 'May';
        case 6
            StringDate1 = 'Jun';
        case 7
            StringDate1 = 'Jul';
        case 8
            StringDate1 = 'Aug';
        case 9
            StringDate1 = 'Sep';
        case 10
            StringDate1 = 'Oct';
        case 11
            StringDate1 = 'Nov';
        case 12
            StringDate1 = 'Dec';
    end
    switch Day
        case 1
            StringDate2 = '01st';
        case 2
            StringDate2 = '02nd';
        case 3
            StringDate2 = '03rd';
        case 21
            StringDate2 = '21st';
        case 22
            StringDate2 = '22nd';
        case 23
            StringDate2 = '23rd';
        case 31
            StringDate2 = '31st';
        otherwise
            StringDate2 = [num2str(Day,'%02d'), 'th'];
    end
    StringDate = [StringDate1, '-', StringDate2];
end

%% https://www.mathworks.com/matlabcentral/cody/problems/56588-exact-cover/solutions
%% Problem 56588. Exact Cover, Solution 10165687
%% Submitted on 17 Dec 2022 by Tim
%% Knuth's Algorithm X (utilizing the Dancing Links technique)

function x=AlgorithmX(u,s,flag)
    Q=cellfun(@(t)ismember(u',t),s,'uni',0);
    x=excov(cell2mat(Q),1:numel(s));
    if length(x)>0 && flag
        return
    end
end
   
function S=excov(Q,L)
S={};
[~,i]=min(sum(Q,2));
for j=find(Q(i,:))
   if all(Q(:,j))
      S=[S L(j)];
   else
      J=~any(Q(Q(:,j),:),1);
      T=excov(Q(~Q(:,j),J),L(J));
      for m=1:numel(T)
         S=[S [L(j) T{m}]];
      end
   end
end
end
