global minErr
global baseErr
global refErr
global simSegLth
global refRank
global totalT

minErr=zeros(floor(totalT/2),totalT+1);
baseErr=zeros(totalT+1,totalT+1);
refErr=zeros(totalT,totalT+1);
simSegLth=zeros(totalT,totalT+1);
refRank=zeros(totalT+1,totalT+1);

funcErr_2Obj(8,17);

%{
for seg=1:floor(totalT/2)
    funcErr_2Obj(seg,totalT+1);
end

errTable=zeros(floor(totalT/2),2);
errTable(:,2)=minErr(:,totalT+1);
for i=1:floor(totalT/2)
    errTable(i,1)=i;
end
errTable
%}