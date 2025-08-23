%% https://www.mathworks.com/matlabcentral/cody/problems/56588-exact-cover/solutions
%% Problem 56588. Exact Cover, Solution 10165687
%% Submitted on 17 Dec 2022 by Tim
%% Knuth's Algorithm X (utilizing the Dancing Links technique)

u = 1:size(ExactCoverMatrix,2);
s = cell(1,size(ExactCoverMatrix,1));
for i=1:size(ExactCoverMatrix,1)
    s{i} = find(ExactCoverMatrix(i,:));
end
x=AlgorithmX(u,s);

function x=AlgorithmX(u,s)
Q=cellfun(@(t)ismember(u',t),s,'uni',0);
x=excov(cell2mat(Q),1:numel(s));
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