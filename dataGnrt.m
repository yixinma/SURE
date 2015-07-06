global Tr
global numPoint
global totalT

sigma=0.01;
initPos=cell(2);
initPos{1}=[0 0 0 1; 1 0 0 1; 0 1 0 1; 0 0 1 1];
initPos{2}=[1 2 3 1; 1 1 2 1; 1 2 1 1; 3 4 1 1];
numSeg=zeros(2,1);
%R=cell(2);
%T=cell(2);
M=cell(2);
segLth=cell(2);

for i=1:2
    numSeg(i)=floor(rand*2)+4;
    numPoint(i)=size(initPos{i},1);
    %R{i}=cell(numSeg(i));
    %T{i}=cell(numSeg(i));
    M{i}=cell(numSeg(i));
    segLth{i}=zeros(1,numSeg(i));
end

time=zeros(2,1);
partition=zeros(2, max(numSeg));
ind=zeros(2,max(numSeg));
for i=1:2
    for seg=1:numSeg(i)
        ind(i,seg)=floor(rand*7.99);
        M{i,seg}=RTGnrt(ind(i,seg));
        %R{i,seg}=M(1:3,1:3);
        %T{i,seg}=M(1:3,4);  
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

Tr=zeros(4*(totalT+1),8);
noise=randn(4*(totalT+1),8)*sigma;
pt=cell(2);
pt{1}=initPos{1}';
pt{2}=initPos{2}';
for i=1:2
    for j=1:4
        for k=1:4
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
    %pt{1}=R{1,count(1)}*pt{1}+[T{1,count(1)} T{1,count(1)} T{1,count(1)} T{1,count(1)}];
    pt{1}=M{1,count(1)}*pt{1};
    for i=1:4
        pt{2}(:,i)=TG2L(pt{1},pt{2}(:,i));
    end
    %pt{2}=R{2,count(2)}*pt{2}+[T{2,count(2)} T{2,count(2)} T{2,count(2)} T{2,count(2)}];
    pt{2}=M{2,count(2)}*pt{2};
    for i=1:4
        pt{2}(:,i)=TL2G(pt{1},pt{2}(:,i));
    end
    for i=1:2
        Tr(4*t+1:4*t+4,4*i-3:4*i)=pt{i};
    end
end
Tr=Tr+noise;