global minErr
global baseErr
global refErr
global simSegLth
global Tr
global numPoint
global refRank

sigma=0.01;
initPos{1}=[0 0 0; 1 0 0; 0 1 0; 0 0 1];
initPos{2}=[1 2 3; 1 1 2; 1 2 1; 3 4 1];
numSeg=zeros(2,1);
R=cell(2);
T=cell(2);
segLth=cell(2);

for i=1:2
    numSeg(i)=floor(rand*2)+4;
    numPoint(i)=size(initPos{i},1);
    R{i}=cell(numSeg(i));
    T{i}=cell(numSeg(i));
    segLth{i}=zeros(1,numSeg(i));
end

time=zeros(2,1);
partition=zeros(2, max(numSeg));
ind=zeros(2,max(numSeg));
for i=1:2
    for seg=1:numSeg(i)
        ind(i,seg)=floor(rand*7.99);
        M=RTGnrt(ind(i,seg));
        R{i,seg}=M(1:3,1:3);
        T{i,seg}=M(1:3,4);  
        segLth{i}(seg)=floor(rand*3)+2;
        if seg==1
            partition(i,seg)=segLth{i}(seg);
        else
            partition(i,seg)=partition(i,seg-1)+segLth{i}(seg);
        end
        time(i)=time(i)+segLth{i}(seg);
    end
end
totalT=max(time);

for i=1:2
    if time(i)<totalT
        segLth{i}(numSeg(i))=segLth{i}(numSeg(i))+totalT-time(i);
        partition(i,numSeg(i))=totalT;
    end
end

minErr=zeros(totalT,totalT+1);
baseErr=zeros(totalT+1,totalT+1);
refErr=zeros(totalT,totalT+1);
simSegLth=zeros(totalT,totalT+1);
refRank=zeros(totalT+1,totalT+1);

Tr=zeros(3*(totalT+1),8);
noise=randn(3*(totalT+1),8)*sigma;
pt{1}=initPos{1}';
pt{2}=initPos{2}';
for i=1:2
    for j=1:4
        for k=1:3
            Tr(k,j+4*(i-1))=pt{i}(k,j);
        end
    end
end

count=[1,1];
for t=1:totalT
    for i=1:2
        if t>partition(i,count(i))
           count(i)=count(i)+1; 
        end
    end
    pt{1}=R{1,count(1)}*pt{1}+[T{1,count(1)} T{1,count(1)} T{1,count(1)} T{1,count(1)}];
    for i=1:4
        pt{2}(:,i)=TG2L(pt{1},pt{2}(:,i));
    end
    pt{2}=R{2,count(2)}*pt{2}+[T{2,count(2)} T{2,count(2)} T{2,count(2)} T{2,count(2)}];
    for i=1:4
        pt{2}(:,i)=TL2G(pt{1},pt{2}(:,i));
    end
    for i=1:2
        Tr(3*t+1:3*t+3,4*i-3:4*i)=pt{i};
    end
end

for seg=1:totalT
    funcErr_2Obj(seg,totalT+1);
end

errTable=zeros(totalT,2);
errTable(:,2)=minErr(:,totalT+1);
for i=1:totalT
    errTable(i,1)=i;
end
errTable
