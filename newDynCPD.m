global minErr
global baseErr
global refErr
global simSegLth
global track
global numPoint
              
sigma=0.01;
numSeg=floor(rand*5)+2;
initPos=[1 2 3; 1 1 2; 1 2 1; 3 4 1];
numPoint=size(initPos,1);
track=cell(numPoint);

R=cell(numSeg);
T=cell(numSeg);
segLth=zeros(1,numSeg);
totalT=0;

for seg=1:numSeg
    R{seg}=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);
    T{seg}=10*rand(3,1)-5;  
    segLth(seg)=floor(rand*5)+2;
    totalT=totalT+segLth(seg);
end

maxSeg=floor(totalT/2);
minErr=zeros(maxSeg,totalT+1);
baseErr=zeros(totalT+1,totalT+1);
refErr=zeros(maxSeg,totalT+1);
simSegLth=zeros(maxSeg,totalT+1);

noise=randn(totalT+1,3)*sigma;
for i=1:numPoint
    pts=zeros(totalT+1,3);
    pt=(initPos(i,:))';
    pts(1,:)=pt';
    for seg=1:numSeg
        if seg==1
            prePt=0;
        else
            prePt=prePt+segLth(seg-1);
        end
        for j=1:segLth(seg)
            pt=R{seg}*pt+T{seg};
            pts(prePt+j+1,:)=pt';
        end
    end
    track{i}=pts+noise;
end

for seg=1:maxSeg
    newfuncErr(seg,totalT+1);
end

errTable=zeros(maxSeg,2);
errTable(:,2)=minErr(:,totalT+1);
spCost=zeros(maxSeg,1);
minSpCost=0;
for i=1:maxSeg
    errTable(i,1)=i;
    spCost(i)=errTable(i,2)+10*sigma*i;
end
[minSpcost,simNumSeg]=min(spCost);
if simNumSeg==numSeg
    disp('Correct!');
else
    disp('Wrong!');
end

chPt=zeros(1,simNumSeg);
chPt(simNumSeg)=totalT+1;
for i=simNumSeg:-1:2
    chPt(i-1)=simSegLth(i,chPt(i));
end
chPt