init=cell(2);
init{1}=[0 0 0; 1 0 0; 0 1 0; 0 0 1];
init{2}=[1 1 1; 1 1 0; 1 2 1; 2 1 1];

% R("Obj index","interval","row","column")
% T("Obj index","interval","row","column")

%Case 0: One rigid body
%Rank 2; 2 significantly non-zero singular values
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

%Case 1: Revolute Pair
%Rank 4; 4 significantly non-zero singular values
%{
R{1,1}=[1 0 0; 0 1 0; 0 0 1];
R{1,2}=R{1,1};
R{2,1}=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);
R{2,2}=R{2,1};
T{1,1}=[1 1 1]';
T{1,2}=T{1,1};
T{2,1}=[1 1 1]';
T{2,2}=T{2,1};
%}

%Case 2: Prismatic Pair
%Rank 4; 4 significantly non-zero singular values
%If the speed of transition changes, Rank 6; 6 significantly non-zero singular values
%{
R{1,1}=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);
R{1,2}=R{1,1};
R{2,1}=R{1,1};
R{2,2}=R{1,1};
T{1,1}=[0 0 0]';
T{1,2}=T{1,1};
T{2,1}=[2 1 1]';
T{2,2}=[6 3 3]';
%}

%Case 3: Screw Pair
%Case 4: Cylindrical Pair
%Rank 4; 4 significantly non-zero singular values
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

%Case 5: Spherical Pair
%{
%}

%Case 6: Planar Pair
%{
%}

%Case 7: Random
%Rank 6; 6 significantly non-zero sigular values
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

%Case 8: Relationship Change (from one rigid body to cylinrical pair)
%Rank 4; 4 significantly non-zero sigular values
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
T{1,1}=[1 1 1]';
T{1,2}=T{1,1};
T{2,1}=T{1,1};
T{2,2}=[1 0 0]';
%}

interval=5;
track=cell(2);
kR=zeros(1+2*interval,24);
for i=1:2
    pts=zeros(2*interval,12);
    pt=init{i}.';
    for k=1:4
        pts(1,(3*k-2):3*k)=pt(:,k)';
    end
    for h=1:2
        for t=1:interval
            pt=R{i,h}*pt+[T{i,h} T{i,h} T{i,h} T{i,h}];
            for k=1:4
                pts(interval*(h-1)+t+1,(3*k-2):3*k)=pt(:,k)';
            end
        end
    end
    track{i}=pts;
end
kR(:,1:12)=track{1};
kR(:,13:24)=track{2};

kR
rank(kR)
svd(kR)