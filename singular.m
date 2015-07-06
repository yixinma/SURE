init=cell(2);
%init{1}=[0 0 0; 1 0 0; 0 1 0; 0 0 1];
init{1}=[1 1 1 1; 2 1 1 1; 1 2 1 1; 1 1 2 1];
init{2}=init{1};
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
M{1,1}=[1 0 0 1; 0 1 0 1; 0 0 1 1; 0 0 0 1];
M{1,2}=M{1,1};
M{2,1}=M{1,1};
%M{2,1}=RTGnrt(0);
M{2,2}=M{2,1}
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
%
M{1,1}=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
M{1,2}=M{1,1};
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

interval=1;
kR=zeros(4*(1+2*interval),8);
for i=1:2
    pts=zeros(4*(1+2*interval),4);
    pt=init{i}.';
    for k=1:4
        for l=1:4
            pts(l,k)=pt(l,k);
        end
    end
    for h=1:2
        for t=1:interval
            %pt=R{i,h}*pt+[T{i,h} T{i,h} T{i,h} T{i,h}];
            pt=M{i,h}*pt;
            for k=1:4
                for l=1:4
                    pts(interval*(h-1)*4+4*t+l,k)=pt(l,k);
                end
            end
        end
    end
    kR(:,4*i-3:4*i)=pts;
end

kR
rank(kR)
svd(kR)