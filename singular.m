init=cell(2);
init{1}=[0 0 0; 1 0 0; 0 1 0; 0 0 1];
init{2}=[1 1 1; 1 1 0; 1 2 1; 2 1 1];
R{1,1,:,:}=[1 0 0; 0 1 0; 0 0 1];% R("Obj index","interval","row","column")
R{1,2,:,:}=[1 0 0; 0 1 0; 0 0 1];
R{2,1,:,:}=[1 0 0; 0 1 0; 0 0 1];
R{2,2,:,:}=rotx(pi/3);
T{1,1,:,:}=[1 1 1]';% T("Obj index","interval","row","column")
T{1,2,:,:}=[0 0 0]';
T{2,1,:,:}=[1 1 1]';
T{2,2,:,:}=[1 0 0]';
track=cell(2);
for i=1:2
    pts=zeros(20,12);
    pt=init{i}.';
    for k=1:4
        pts(1,(3*k-2):3*k)=pt(:,k)';
    end
    for h=1:2
        for t=1:10
            pt=R{i,h,:,:}*pt+[T{i,h,:,:} T{i,h,:,:} T{i,h,:,:} T{i,h,:,:}];
            for k=1:4
                pts(10*(h-1)+t+1,(3*k-2):3*k)=pt(:,k)';
            end
        end
    end
    track{i}=pts;
end
kR=zeros(21,24);
kR(:,1:12)=track{1};
kR(:,13:24)=track{2};
kR
rank(kR)
svd(kR)