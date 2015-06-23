global minErr
global baseErr
global refErr
global simSegLth
global Tr
global numPoint
global refRank

sigma=0.01;
initPos{1}=[0 0 0; 1 0 0; 0 1 0; 0 0 1; 1 1 1];
initPos{2}=[1 2 3; 1 1 2; 1 2 1; 3 4 1; 3 2 2];
numSeg=zeros(2,1);
R=cell(2);
T=cell(2);
segLth=cell(2);

for i=1:2
    numSeg(i)=floor(rand*5)+10;
    numPoint(i)=size(initPos{i},1);
    R{i}=cell(numSeg(i));
    T{i}=cell(numSeg(i));
    segLth{i}=zeros(1,numSeg(i));
end

time=zeros(2,1);
partition=zeros(2, max(numSeg));
for i=1:2
    for seg=1:numSeg(i)
        R{i,seg}=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);
        T{i,seg}=10*rand(3,1)-5;  
        segLth{i}(seg)=floor(rand*2)+1;
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

minErr=zeros(totalT,totalT+1);
baseErr=zeros(totalT+1,totalT+1);
refErr=zeros(totalT,totalT+1);
simSegLth=zeros(totalT,totalT+1);
refRank=zeros(totalT+1,totalT+1);

Tr=zeros(3*(totalT+1),10);
noise=randn(3*(totalT+1),10)*sigma;
for h=1:2
    pts=zeros(3*(totalT+1),5);
    pt=initPos{h}.';
    for k=1:5
        for l=1:3
            pts(l,k)=pt(l,k);
        end
    end
    for seg=1:numSeg(h)
        if seg==1
            prePt=0;
        else
            prePt=prePt+segLth{h}(seg-1);
        end
        for j=1:segLth{h}(seg)
            pt=R{h,seg}*pt+[T{h,seg} T{h,seg} T{h,seg} T{h,seg} T{h,seg}];
            for k=1:5
                for l=1:3
                    pts(prePt*3+3*j+l,k)=pt(l,k);
                end
            end
        end
    end
    Tr(:,(5*h-4):5*h)=pts;
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
