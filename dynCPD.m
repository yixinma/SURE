global minErr
global baseErr
global refErr
global simSegLth
global track
global numPoint

sigma=0.001;
numSeg=floor(rand*3)+1;
initPos=[1 2 3; 1 1 2; 1 2 1];
numPoint=size(initPos,1);
track=cell(numPoint);

R=cell(numSeg);
T=cell(numSeg);
segLth=zeros(1,numSeg);
totalT=0;

for seg=1:numSeg
    R{seg}=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);
    T{seg}=10*rand(3,1)-5;  
    segLth(seg)=floor(rand*5)+3;
    totalT=totalT+segLth(seg);
end

minErr=zeros(totalT-1,1);
baseErr=zeros(totalT,totalT);
refErr=zeros(totalT-1,totalT);
simSegLth=zeros(totalT-1,totalT-1);

for i=1:numPoint
    pts=zeros(totalT,3);
    pt=(initPos(i,:))';
    for seg=1:numSeg
        for j=1:segLth(seg)
            pts(j,:)=pt';
            pt=R{seg}*pt+T{seg};
        end
    end
    noise=randn(totalT,3)*sigma;
    track{i}=pts+noise;
end

funcErr(totalT-1,totalT);

errTable=zeros(totalT-1,2);
for i=1:totalT-1
    errTable(i,1)=i;
end
errTable(:,2)=minErr;