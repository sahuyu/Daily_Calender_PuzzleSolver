clear
addpath('append_pdfs');

%% Pieces shape
PiecesShape_DayOnlyCalender;

%% Frame shape
FrameDefault = false(5,7);
FrameDefault(5,4:7)=true(1,4);

for Day = 1:31

%% Qusetion
FrameQuestion = DayOnlyCalenderPuzzle(Day);
filename = ['output/Result_', num2str(Day,'%02d'), '.txt'];
logfilename = ['output/log.txt'];
if ~isfolder('output')
    mkdir('output');
end

Frame = FrameDefault | FrameQuestion;

%% Initalization
SizeFrame = size(Frame);
ExpandedFrame = true(SizeFrame(1)+4, SizeFrame(2)+4);
ExpandedFrame(3:SizeFrame(1)+2,3:SizeFrame(2)+2) = Frame;
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
for i=1:NoPuzzlePieces
    tempIndex = zeros(1,LN);
    for L0=1:LN
        % treat matrix of [0,1] as binary
        binValue = num2str(reshape(ExpandedPuzzlePieces{i,L0},1,[]));
        tempIndex(1,L0) = bin2dec(binValue);
    end
    [~, UniqueIndex, ~] = unique(tempIndex);
    tempFlag = false(1,LN);
    tempFlag(UniqueIndex) = true;
    ExpandedPuzzlePiecesFlag(i,:) = ExpandedPuzzlePiecesFlag(i,:) & tempFlag;
end

%% Solutions
rewrite(filename,'');
% Output:[Index of puzzle block, Rotation status, X, Y]
Ouptput = zeros(1,NoPuzzlePieces);
for L1=1:LN
    %fprintf('|');
    if ExpandedPuzzlePiecesFlag(1,L1)
    Frame1 = Frame;
    [isfit1, newFrame1] = isFit(Frame1, ExpandedPuzzlePieces{1,L1}, ListOfPossibleSize{2});
    if isfit1
    Ouptput1 = Ouptput;
    Ouptput1(1) = L1;
    for L2=1:LN
        if ExpandedPuzzlePiecesFlag(2,L2)
        Frame2 = newFrame1;
        [isfit2, newFrame2] = isFit(Frame2, ExpandedPuzzlePieces{2,L2}, ListOfPossibleSize{3});
        if isfit2
        Ouptput2 = Ouptput1;
        Ouptput2(2) = L2;
        for L3=1:LN
            if ExpandedPuzzlePiecesFlag(3,L3)
            Frame3 = newFrame2;
            [isfit3, newFrame3] = isFit(Frame3, ExpandedPuzzlePieces{3,L3}, ListOfPossibleSize{4});
            if isfit3
            Ouptput3 = Ouptput2;
            Ouptput3(3) = L3;
            for L4=1:LN
                if ExpandedPuzzlePiecesFlag(4,L4)
                Frame4 = newFrame3;
                [isfit4, newFrame4] = isFit(Frame4, ExpandedPuzzlePieces{4,L4}, ListOfPossibleSize{5});
                if isfit4
                Ouptput4 = Ouptput3;
                Ouptput4(4) = L4;
                for L5=1:LN
                    if ExpandedPuzzlePiecesFlag(5,L5)
                    Frame5 = newFrame4;
                    [isfit5, newFrame5] = isFit(Frame5, ExpandedPuzzlePieces{5,L5}, ListOfPossibleSize{6});
                    if isfit5
                    Ouptput5 = Ouptput4;
                    Ouptput5(5) = L5;
                    for L6=1:LN
                        if ExpandedPuzzlePiecesFlag(6,L6)
                        Frame6 = newFrame5;
                        [isfit6, newFrame6] = isFit(Frame6, ExpandedPuzzlePieces{6,L6}, []);
                        if isfit6
                        Ouptput6 = Ouptput5;
                        Ouptput6(6) = L6;
                        write(filename,Ouptput6);
                        end
                        end
                    end
                    end
                    end
                end
                end
                end
            end
            end
            end
        end
        end
        end
    end
    end
    end
    %if rem(L1,SizeFrame(1)*SizeFrame(2))==0
    %    fprintf('\n');
    %end
end

%% Plotting
ColorMaps = [1 1 1; 0.4 0 0.8; 1 0.6 0.2; 1 1 0; 1 0 0; 0.2 0.6 1; 0.57 0.8 0.31];
NRow = 5;
NColumn = 7;
NImage = NRow*NColumn;

Solution = readmatrix(filename);
ImageNumber = size(Solution);
ImageNumber = ImageNumber(1);

if ImageNumber>0
HeatMapMatrix = cell(ImageNumber,1);
for i=1:ImageNumber
    HeatMapMatrix{i} = zeros(SizeFrame(1), SizeFrame(2));
    for n=1:NoPuzzlePieces
        HeatMapMatrix{i} = HeatMapMatrix{i} + n.*ExpandedPuzzlePieces{n,Solution(i,n)};
    end
end

NPage = ceil(ImageNumber/NImage);
PrintFileName = cell(NPage,1);
for p=1:NPage
    H0 = tiledlayout(NRow,NColumn,'TileSpacing','compact','Padding','loose');
    for i=1:min(NImage,ImageNumber-(p-1)*NImage)
        %subplot(NRow,NColumn,i)
        n = (p-1)*NImage+i;
        nexttile
        %{
        imagesc(HeatMapMatrix{n}); 
        colormap(ColorMaps)
        axis equal
        axis off
        hold on
        %}
        H = heatmap(HeatMapMatrix{n},'Colormap',ColorMaps,'CellLabelColor','none');
        H.Position = [0.13,0.11,0.775,0.815];
        H.ColorbarVisible = 'off';
        H.XDisplayLabels = nan(size(H.XDisplayData));
        H.YDisplayLabels = nan(size(H.YDisplayData));
    end
    titlename = ['Solution of Day ', num2str(Day,'%02d'), ' (Page', num2str(p,'%02d'), ')'];
    title(H0, titlename);
    set(gcf,'Position',[120 100 1520 820]);
    %H0.Visible = 'off';
    orient(gcf,'landscape')
    PrintFileName{p,1} = ['output/Solution_Day_', num2str(Day,'%02d'), '_P', num2str(p,'%02d'), '.pdf'];
    print(gcf,PrintFileName{p,1},'-dpdf','-bestfit'); %PDF
    close all
end

if NPage>1
    append_pdfs_edit(PrintFileName');
    for i=2:NPage
        delete(PrintFileName{i,1});
    end
end
end

fprintf('Daily Puzzle on %02d solved, %d solution(s) found.\n', Day, ImageNumber);
fileID = fopen(logfilename,'at');
fprintf(fileID,'Daily Puzzle on %02d solved, %d solution(s) found.\n', Day, ImageNumber);
fclose(fileID);

end

%% Function
function append_pdfs_edit(varargin)
% Are we appending or creating a new file
varargin = varargin{1};
append = exist(varargin{1}, 'file') == 2;
if append
    output = [tempname '.pdf'];
else
    output = varargin{1};
    varargin = varargin(2:end);
end
% Create the command file
cmdfile = [tempname '.txt'];
fh = fopen(cmdfile, 'w');
fprintf(fh, '-q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress -sOutputFile="%s" -f', output);
fprintf(fh, ' "%s"', varargin{:});
fclose(fh);
% Call ghostscript
ghostscript(['@"' cmdfile '"']);
% Delete the command file
delete(cmdfile);
% Rename the file if needed
if append
    movefile(output, varargin{1});
end
end

function [frame_question] = DayOnlyCalenderPuzzle(Day)
    frame_question = false(5,7);
    remDay = rem(Day,7);
    if remDay==0
        remDay = 7;
    end
    frame_question(ceil(Day/7),remDay) = true;
end