global minErr
global baseErr
global zeroBaseErr
global refErr
global simSegLth
global refPart
global track
global numPoint
global initPos

sigma=0.01;
numSeg=floor(rand*3)+1;
initPos=[1 2 3; 1 1 2; 1 2 1];
numPoint=size(initPos,1);
track=cell(numPoint);

R=cell(numSeg);
T=cell(numSeg);
segLth=zeros(1,numSeg);
rSegLth=zeros(1,numSeg);
totalT=0;

for seg=1:numSeg
    R{seg}=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);
    T{seg}=10*rand(3,1)-5;  
    segLth(seg)=floor(rand*5)+1;
    rSegLth(seg)=3*segLth(seg);
    totalT=totalT+segLth(seg);
end

minErr=zeros(totalT,totalT);
baseErr=zeros(totalT,totalT);
zeroBaseErr=zeros(totalT,1);
refErr=zeros(totalT,totalT);
simSegLth=zeros(totalT,totalT);
refPart=zeros(totalT,totalT);

noise=randn(3*totalT,3)*sigma;
for i=1:numPoint
    pts=zeros(3*totalT,3);
    pt=(initPos(i,:))';
    for seg=1:numSeg
        if seg==1
            prePt=0;
        else
            prePt=prePt+rSegLth(seg-1);
        end
        for j=1:rSegLth(seg)
            pt=R{seg}*pt+T{seg};
            pts(prePt+j,:)=pt';
        end
    end
    track{i}=pts+noise;
end

for seg=1:totalT
    funcErr(seg,totalT);
end

errTable=zeros(totalT,2);
for i=1:totalT
    errTable(i,1)=i;
end
errTable(:,2)=minErr(:,totalT)