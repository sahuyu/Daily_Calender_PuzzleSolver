clear

%% Frame shape
FrameDefault = false(15,15);
FrameDefault([1,2,14,15],[1,15]) = true;
FrameDefault([1,15],[2,14]) = true;

%% Pieces shape
% 1 pieces, start in a 7x7 empty space
% 34 pieces, start in a 5x5 empty space
NoPuzzlePieces = 35;
NoExtra = 1;
PuzzlePieces = repmat({false(5,5)},NoPuzzlePieces,8);
for i=1:NoExtra
    for j=1:8
        PuzzlePieces{i,j} = false(7,7);
    end
end
PuzzlePiecesBlockNo = zeros(NoPuzzlePieces,1);

% □□□□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□
% □□□□□□□ % □□■□□ % ■□□■□ % □■■□□ % ■□□□□ % □■□□□ % □■□■□
% ■■■■■■□ % ■■■■■ % ■■■■□ % ■■■■□ % ■■■■□ % ■■■■□ % □■■■□
% □□□□□□□ % □□□□□ % □□□□□ % □□□□□ % ■□□□□ % □■□□□ % □□■□□
% □□□□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□

PuzzlePieces{1,1}(4,1:6)=true;
PuzzlePieces{3,1}(3,1:5)=true;PuzzlePieces{3,1}(2,3)=true;
PuzzlePieces{4,1}(3,1:4)=true;PuzzlePieces{4,1}(2,[1,4])=true;
PuzzlePieces{5,1}(3,1:4)=true;PuzzlePieces{5,1}(2,2:3)=true;
PuzzlePieces{6,1}(3,1:4)=true;PuzzlePieces{6,1}(2:4,1)=true;
PuzzlePieces{7,1}(3,1:4)=true;PuzzlePieces{7,1}(2:4,2)=true;
PuzzlePieces{8,1}(3,2:4)=true;PuzzlePieces{8,1}(2,[2,4])=true;PuzzlePieces{8,1}(4,3)=true;

% □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□
% □■■■□ % □□■■■ % □■■■□ % □□□■□ % □□■□□ % □□■■□ % □■□□□
% □■■■□ % ■■■□□ % ■■■□□ % ■■■■□ % ■■■■□ % □■■□□ % □■■□□
% □□□□□ % □□□□□ % □□□□□ % ■□□□□ % □■□□□ % ■■□□□ % □■■■□
% □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□

PuzzlePieces{2,1}(2,2:4)=true;PuzzlePieces{2,1}(3,2:4)=true;
PuzzlePieces{9,1}(2,3:5)=true;PuzzlePieces{9,1}(3,1:3)=true;
PuzzlePieces{10,1}(2,2:4)=true;PuzzlePieces{10,1}(3,1:3)=true;
PuzzlePieces{11,1}(3,1:4)=true;PuzzlePieces{11,1}(2,4)=true;PuzzlePieces{11,1}(4,1)=true;
PuzzlePieces{12,1}(3,1:4)=true;PuzzlePieces{12,1}(2,3)=true;PuzzlePieces{12,1}(4,2)=true;
PuzzlePieces{13,1}(2,3:4)=true;PuzzlePieces{13,1}(3,2:3)=true;PuzzlePieces{13,1}(4,1:2)=true;
PuzzlePieces{14,1}(2,2)=true;PuzzlePieces{14,1}(3,2:3)=true;PuzzlePieces{14,1}(4,2:4)=true;

% □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□■□
% □□■□□ % □□□□■ % □□□■□ % □□□■■ % □□■■□ % □■□■□ % □□□■□
% □■■■□ % ■■■■■ % ■■■■■ % ■■■■□ % ■■■■□ % ■■■■□ % ■■■■□
% □■■□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□
% □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□

PuzzlePieces{15,1}(2,3)=true;PuzzlePieces{15,1}(3,2:4)=true;PuzzlePieces{15,1}(4,2:3)=true;
PuzzlePieces{16,1}(3,1:5)=true;PuzzlePieces{16,1}(2,5)=true;
PuzzlePieces{17,1}(3,1:5)=true;PuzzlePieces{17,1}(2,4)=true;
PuzzlePieces{18,1}(3,1:4)=true;PuzzlePieces{18,1}(2,4:5)=true;
PuzzlePieces{19,1}(3,1:4)=true;PuzzlePieces{19,1}(2,3:4)=true;
PuzzlePieces{20,1}(3,1:4)=true;PuzzlePieces{20,1}(2,[2,4])=true;
PuzzlePieces{21,1}(3,1:4)=true;PuzzlePieces{21,1}(1:2,4)=true;

% □□■□□ % □□□□□ % □□□□□ % □□■□□ % □□□□□ % □□□■□ % □□□□□
% □□■□□ % □□■□□ % □■□□□ % □■■■□ % □■□■■ % □■■■□ % □■■■□
% ■■■■□ % ■■■■□ % ■■■■□ % □■□□□ % □■■■□ % □□■□□ % □□■■□
% □□□□□ % □□□■□ % □□□■□ % □■□□□ % □□□□□ % □□■□□ % □□■□□
% □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□

PuzzlePieces{22,1}(3,1:4)=true;PuzzlePieces{22,1}(1:2,3)=true;
PuzzlePieces{23,1}(3,1:4)=true;PuzzlePieces{23,1}(2,3)=true;PuzzlePieces{23,1}(4,4)=true;
PuzzlePieces{24,1}(3,1:4)=true;PuzzlePieces{24,1}(2,2)=true;PuzzlePieces{24,1}(4,4)=true;
PuzzlePieces{25,1}(2,2:4)=true;PuzzlePieces{25,1}(1,3)=true;PuzzlePieces{25,1}(3:4,2)=true;
PuzzlePieces{26,1}(3,2:4)=true;PuzzlePieces{26,1}(2,[2,4,5])=true;
PuzzlePieces{27,1}(2,2:4)=true;PuzzlePieces{27,1}(1,4)=true;PuzzlePieces{27,1}(3:4,3)=true;
PuzzlePieces{28,1}(2,2:4)=true;PuzzlePieces{28,1}(3,3:4)=true;PuzzlePieces{28,1}(4,3)=true;

% □□□■□ % □□□■□ % □□■■□ % □□□□□ % □□□□□ % □□■■□ % □□□□□
% □□■■□ % □■■■□ % □■■□□ % □■■■□ % □■□■□ % □□■□□ % □□□■□
% □■■□□ % □■□□□ % □■□□□ % □■□■□ % □■■■□ % □■■□□ % □■■■□
% □□■□□ % □■□□□ % □■□□□ % □■□□□ % □■□□□ % □■□□□ % □■■□□
% □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□ % □□□□□

PuzzlePieces{29,1}(3,2)=true;PuzzlePieces{29,1}(2:4,3)=true;PuzzlePieces{29,1}(1:2,4)=true;
PuzzlePieces{30,1}(1,4)=true;PuzzlePieces{30,1}(2,2:4)=true;PuzzlePieces{30,1}(3:4,2)=true;
PuzzlePieces{31,1}(1,3:4)=true;PuzzlePieces{31,1}(2,2:3)=true;PuzzlePieces{31,1}(3:4,2)=true;
PuzzlePieces{32,1}(2,2:4)=true;PuzzlePieces{32,1}(3:4,2)=true;PuzzlePieces{32,1}(3,4)=true;
PuzzlePieces{33,1}(2:4,2)=true;PuzzlePieces{33,1}(3,3)=true;PuzzlePieces{33,1}(2:3,4)=true;
PuzzlePieces{34,1}(3:4,2)=true;PuzzlePieces{34,1}(1:3,3)=true;PuzzlePieces{34,1}(1,4)=true;
PuzzlePieces{35,1}(2,4)=true;PuzzlePieces{35,1}(3,2:4)=true;PuzzlePieces{35,1}(4,2:3)=true;

for n=1:NoPuzzlePieces
    PuzzlePiecesBlockNo(n) = sum(PuzzlePieces{n,1},'all');
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
LN = SizeFrame(1)*SizeFrame(2)*8;
ExpandedPuzzlePieces = repmat({false(SizeFrame(1),SizeFrame(2))},NoPuzzlePieces,LN);
ExpandedPuzzlePiecesFlag = false(NoPuzzlePieces,LN);
% 5x5 pieces
ExpandedFrame = true(SizeFrame(1)+4, SizeFrame(2)+4);
ExpandedFrame(3:SizeFrame(1)+2,3:SizeFrame(2)+2) = FrameDefault;
for i=NoExtra+1:NoPuzzlePieces
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
% 7x7 pieces
ExpandedFrame = true(SizeFrame(1)+6, SizeFrame(2)+6);
ExpandedFrame(4:SizeFrame(1)+3,4:SizeFrame(2)+3) = FrameDefault;
for i=1:NoExtra
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
        tempFrame = false(SizeFrame(1)+6, SizeFrame(2)+6);
        tempFrame(R0x:R0x+6,R0y:R0y+6) = PuzzlePieces{i,P0};
        OverlayFrame = tempFrame & ExpandedFrame;
        if sum(OverlayFrame,'all')==0
            ExpandedPuzzlePieces{i,L0} = tempFrame(4:SizeFrame(1)+3,4:SizeFrame(2)+3);
            ExpandedPuzzlePiecesFlag(i,L0) = true;
        end
    end
end

%Remove duplicates
for i=NoPuzzlePieces:NoPuzzlePieces
    tempIndex = zeros(LN,SizeFrame(1),'int64');
    for L0=1:LN
        reshapeMatrix = ExpandedPuzzlePieces{i,L0};
        for j=1:SizeFrame(1)
            % treat matrix of [0,1] as binary
            binValue = num2str(reshapeMatrix(j,:),'%d');
            tempIndex(L0,j) = LongBin2Dec(binValue);
        end
    end
    [~, UniqueIndex, ~] = unique(tempIndex,'rows');
    tempFlag = false(1,LN);
    tempFlag(UniqueIndex) = true;
    ExpandedPuzzlePiecesFlag(i,:) = ExpandedPuzzlePiecesFlag(i,:) & tempFlag;
end

% Randomization
ExpandedPuzzlePieces_temp = ExpandedPuzzlePieces;
ExpandedPuzzlePiecesFlag_temp = ExpandedPuzzlePiecesFlag;
for i=1:NoPuzzlePieces
    newIndx = randperm(LN);
    for j=1:LN
        ExpandedPuzzlePieces{i,j} = ExpandedPuzzlePieces_temp{i,newIndx(j)};
        ExpandedPuzzlePiecesFlag(i,j) = ExpandedPuzzlePiecesFlag_temp(i,newIndx(j));
    end
end
clear ExpandedPuzzlePieces_temp ExpandedPuzzlePiecesFlag_temp

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

% PotentialWeek = ~FrameDefault;
% PotentialWeek([3,6,10],6:10) = false;
% PotentialWeek([4,7,8,9],5:11) = false;
PotentialWeek = false(15,15);
PotentialWeek([12,13],5:11) = true;

Wn = sum(PotentialWeek,"all");
Wlist = zeros(Wn,2);
W_temp = 1;
for i=1:size(PotentialWeek,1)
    for j=1:size(PotentialWeek,2)
        if PotentialWeek(i,j)
            Wlist(W_temp,1) = i;
            Wlist(W_temp,2) = j;
            W_temp = W_temp + 1;
        end
    end
end

Week2String = ['Mon';'Tue';'Wed';'Thu';'Fri';'Sat';'Sun'];
for nn = 2*31+1:9*31

    Month = ceil(nn/(31));
    Day = rem(nn,31);
    if Day==0
        Day = 31;
    end

    PotentialWeekNow = PotentialWeek;

    for ww = 1:Wn
        FrameQuestion = dailyPuzzle_Hexominoes_2(Month,Day);
        FrameQuestion(Wlist(ww,1),Wlist(ww,2)) = true;
        Frame = FrameDefault | FrameQuestion;

        ExactCoverMatrix(end,:) = [reshape(Frame, 1, NoBlocks), false(1,NoPuzzlePieces), true];

        tic
        [Sol, timeout] = AlgorithmXexcov(ExactCoverMatrix',[1:MaxIndex],1);

        if timeout
            PotentialWeekNow(Wlist(ww,1),Wlist(ww,2)) = false;
        else
            if ~isempty(Sol)
                PotentialWeekNow(Wlist(ww,1),Wlist(ww,2)) = true;
            else
                PotentialWeekNow(Wlist(ww,1),Wlist(ww,2)) = false;
            end
        end
    end

    filename = ['output/PotentialWeekNow_',num2str(Month),'_',num2str(Day),'.txt'];
    writematrix(PotentialWeekNow,filename);

end
 
%% Function

function [frame_question] = dailyPuzzle_Hexominoes_2(Month,Day)
    frame_question = false(15,15);
    MN = [3,6; 3,7; 3,8; 3,9; 3,10; 4,5; 4,6; 4,7; 4,8; 4,9; 4,10; 4,11];
    frame_question(MN(Month,1),MN(Month,2)) = true;
    DN = [6,6; 6,7; 6,8; 6,9; 6,10; 7,5; 7,6; 7,7; 7,8; 7,9; 7,10; 7,11; 8,5; 8,6; 8,7; 8,8; 8,9; 8,10; 8,11; 9,5; 9,6; 9,7; 9,8; 9,9; 9,10; 9,11; 10,6; 10,7; 10,8; 10,9; 10,10];
    frame_question(DN(Day,1),DN(Day,2)) = true;
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

function [S, timeout]=AlgorithmXexcov(Q,L,MaxN)
% Q: [MxN logic matrix] the cover matrix, M is the universe, N is the sets with which to try to exactly cover the respective universe 
% L: [1:N]
% MaxN: find the first N solutins
S={};
timeout = false;
[~,i]=min(sum(Q,2));
for j=find(Q(i,:))
   if all(Q(:,j))
      S=[S L(j)];
   else
      J=~any(Q(Q(:,j),:),1);
      [T,~]=AlgorithmXexcov(Q(~Q(:,j),J),L(J),MaxN);
      for m=1:numel(T)
          S=[S [L(j) T{m}]];
      end
   end
   if numel(S)>=MaxN
       return
   end
   elapsed_time = toc;
   if elapsed_time > 20
       timeout = true;
       S={};
       return
   end
end
end
