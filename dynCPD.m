global minErr
global baseErr
global ref
global track
global numPoint

sigma=0.5;
numSeg=floor(rand*10);
initPos=[1 2 3; 1 1 2; 1 2 1];
numPoint=size(initPos,1);
track=cell(numPoint);
R=cell(numSeg);
T=cell(numSeg);
t=zeros(numSeg);
totalT=0;

for seg=0:numSeg
    R{seg}=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);
    T{seg}=10*rand(3,1)-5;  
    t(seg)=floor(rand*10);
    totalT=totalT+t(seg);
end

for i=1:numPoint
    pts=zeros(totalT,3);
    pt=(initPos(i,:))';
    for seg=1:numSeg
        for j=1:t{seg}
            pts(j,:)=pt';
            pt=R{seg}*pt+T{seg};
        end
    end
    noise=randn(totalT,3)*sigma;
    track{i}=pts+noise;
end

minerr=funcErr(totalT-1,totalT);