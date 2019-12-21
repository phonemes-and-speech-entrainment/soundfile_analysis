%Oana Cucu 2018
%computes Gini index of any continuous signal
%see the formula on wikipedia
%%
function gini = gini_indx(x)
n=length(x);
X=zeros(n,n);
X(1,:)=x;
for i=1:n-1
X(i+1,:)=circshift(X(i,:),n-1);
end;

Z2=zeros(size(X,1),size(X,2)-1);
for i=2:size(X,2)
Z2(:,i)=abs(X(:,1)-X(:,i));
end;

gini=sum(sum(Z2))/(2*length(x)*sum(x));

