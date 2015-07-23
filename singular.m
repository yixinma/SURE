init=cell(2);
%init{1}=[0 0 0; 1 0 0; 0 1 0; 0 0 1];
init{1}=[0 0 0 1; 1 0 0 1; 0 1 0 1; 0 0 1 1; 0 1 1 1; 1 1 0 1];
init{2}=[1 1 1 1; 2 1 1 1; 1 2 1 1; 1 1 2 1; 3 2 1 1; 1 4 3 1];
M=cell(2,2);
%init{2}=[0 0 0; 1 0 0; 0 1 0; 0 0 1];
%init{2}=[1 1 1; 1 1 0; 1 2 1; 2 1 1];

% R("Obj index","interval","row","column")
% T("Obj index","interval","row","column")

%Case 0: One rigid body
%Rank 4; 4 significantly non-zero singular values
%{
R{1,1}=[1 0 0; 0 1 0; 0 0 1];
R{1,2}=R{1,1};
R{2,1}=[1 0 0; 0 1 0; 0 0 1];
R{2,2}=R{2,1};
T{1,1}=[1 1 1]';
T{1,2}=T{1,1};
T{2,1}=[1 1 1]';
T{2,2}=T{2,1};
%}
%{
M{1,1}=[1 0 0 1; 0 1 0 0; 0 0 1 0; 0 0 0 1];
%M{1,1}=RT
M{1,2}=M{1,1};
M{2,1}=RTGnrt(0);
M{2,2}=M{2,1};
%}

%Case 1: Revolute Pair
%Rank 6; 6 significantly non-zero singular values
%{
R{1,1}=[1 0 0; 0 1 0; 0 0 1];
R{1,2}=R{1,1};
R{2,1}=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);
R{2,2}=R{2,1};
T{1,1}=[0 0 0]';
T{1,2}=T{1,1};
T{2,1}=T{1,1};7

T{2,2}=T{2,1};
%}
%{
M{1,1}=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
M{1,2}=M{1,1};
M{2,1}=RTGnrt(1);
M{2,2}=M{2,1}
%}

%Case 2: Prismatic Pair
%Rank 5; 5 significantly non-zero singular values even if the speed of relative transition changes
%{
%R{1,1}=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);
R{1,1}=[1 0 0; 0 1 0; 0 0 1];
R{1,2}=R{1,1};
R{2,1}=R{1,1};
R{2,2}=R{1,1};
T{1,1}=[0 0 0]';
T{1,2}=T{1,1};
T{2,1}=[2 1 1]';
T{2,2}=[6 3 3]';
%}
%{
M{1,1}=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
M{1,2}=M{1,1};
M{2,1}=RTGnrt(2);
M{2,2}=M{2,1}
%}

%Case 3: Screw Pair
%Case 4: Cylindrical Pair
%Rank 7; 7 significantly non-zero singular values
%{
R{1,1}=[1 0 0; 0 1 0; 0 0 1];
R{1,2}=R{1,1};
R{2,1}=rotx(rand*4*pi-2*pi);
R{2,2}=R{2,1};
T{1,1}=[0 0 0]';
T{1,2}=T{1,1};
T{2,1}=[1 0 0]';
T{2,2}=T{2,1};
%}
%{
M{1,1}=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
M{1,2}=M{1,1};
M{2,1}=RTGnrt(3);
M{2,2}=M{2,1}
%}

%Case 5: Spherical Pair
%Rank 7; 7 significantly non-zero sigular values
%{
R{1,1}=[1 0 0; 0 1 0; 0 0 1];
R{1,2}=R{1,1};
R{2,1}=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);
R{2,2}=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);;
T{1,1}=[0 0 0]';
T{1,2}=T{1,1};
T{2,1}=[0 0 0]';
T{2,2}=T{2,1};
%}
%{
%M{1,1}=[1 0 0 1; 0 1 0 0; 0 0 1 0; 0 0 0 1];
M{1,1}=RTGnrt(7);
%M{1,2}=M{1,1};
M{1,2}=RTGnrt(7);
M{2,1}=RTGnrt(5);
M{2,2}=RTGnrt(5);
%}

%Case 6: Planar Pair
%Rank 6; 6 significantly non-zero singular values
%{
R{1,1}=[1 0 0; 0 1 0; 0 0 1];
R{1,2}=R{1,1};
R{2,1}=[1 0 0; 0 1 0; 0 0 1];
R{2,2}=R{2,1};
T{1,1}=[0 0 0]';
T{1,2}=T{1,1};
T{2,1}=[1 1 0]';
T{2,2}=[2 3 0]';
%}
%{
M{1,1}=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
M{1,2}=M{1,1};
M{2,1}=RTGnrt(6);
M{2,2}=M{2,1}
%}

%Case 7: Random
%Rank 8; 8 significantly non-zero sigular values
%{
R{1,1}=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);
R{1,2}=R{1,1};
R{2,1}=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);
R{2,2}=R{2,1};
T{1,1}=rand(3,1);
T{1,2}=T{1,1};
T{2,1}=rand(3,1);
T{2,2}=T{2,1};
%}
%
%M{1,1}=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
M{1,1}=RTGnrt(7);
M{1,2}=M{1,1};
M{2,1}=RTGnrt(7);
M{2,2}=M{2,1}
%}

%Case 8: Relationship Change (from one rigid body to cylinrical pair)
%Rank 6; 6 significantly non-zero sigular values
%{
R{1,1}=[1 0 0; 0 1 0; 0 0 1];
R{1,2}=R{1,1};
R{2,1}=R{1,1};
R{2,2}=rotx(rand*4*pi-2*pi);
T{1,1}=[0 0 0]';
T{1,2}=T{1,1};
T{2,1}=T{1,1};
T{2,2}=[1 0 0]';
%}

%Case 9: Relationship Change (from revolute pair to cylinrical pair)
%Rank 7; 7 significantly non-zero sigular values
%{
R{1,1}=[1 0 0; 0 1 0; 0 0 1];
R{1,2}=R{1,1};
R{2,1}=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);
R{2,2}=rotx(rand*4*pi-2*pi);
T{1,1}=[0 0 0]';
T{1,2}=T{1,1};
T{2,1}=T{1,1};
T{2,2}=[1 0 0]';
%}

interval=4;
kR=zeros(4*(1+2*interval),12);
%{
for i=1:2
    pts=zeros(4*(1+2*interval),6);
    pt=init{i}.';
    for k=1:6
        for l=1:4
            pts(l,k)=pt(l,k);
        end
    end
    for h=1:2
        for t=1:interval
            %pt=R{i,h}*pt+[T{i,h} T{i,h} T{i,h} T{i,h}];
            size(pt)
            size(M{i,h})
            pt=M{i,h}*pt;
            for k=1:6
                for l=1:4
                    pts(interval*(h-1)*4+4*t+l,k)=pt(l,k);
                end
            end
        end
    end
    kR(:,6*i-5:6*i)=pts;
end
%}

% To test if it's caused by the frame transformation
%
pt=cell(2,1);
pt{1}=init{1}.';
pt{2}=init{2}.';
kR(1:4,1:6)=pt{1};
kR(1:4,7:12)=pt{2};
for t=1:2
    for j=1:interval
        %pt{1}=R{1,count(1)}*pt{1}+[T{1,count(1)} T{1,count(1)} T{1,count(1)} T{1,count(1)}];
        %prept1=pt{1};
        for i=1:6
            pt{2}(:,i)=TG2L(pt{1},pt{2}(:,i));
        end
        pt{1}=M{1,t}*pt{1};
        %pt{2}=R{2,count(2)}*pt{2}+[T{2,count(2)} T{2,count(2)} T{2,count(2)} T{2,count(2)}];
        pt{2}=M{2,t}*pt{2};
        for i=1:6
            pt{2}(:,i)=TL2G(pt{1},pt{2}(:,i));
        end
        kR(4*j+1+interval*4*(t-1):4*j+4+interval*4*(t-1),1:6)=pt{1};
        kR(4*j+1+interval*4*(t-1):4*j+4+interval*4*(t-1),7:12)=pt{2};
    end
end
%}

kR
rank(kR)
svd(kR)