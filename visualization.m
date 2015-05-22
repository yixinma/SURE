%prompt='Please enter the number of points on each object: '
%numPoint=input(prompt);
numPoint=[2 1 3 2]; 
numObj=size(numPoint);
obj=cell(numObj(2));
R=cell(numObj(2));
T=cell(numObj(2));
color='rbgkymcw';

%prompt='Please enter the initial positions of those points in order: '
%initPos=input(prompt);
initPos=[1 1 1; 0 0 0; 3 2 2; 4 3 5; 1 2 4; 2 5 3; 2 2 0; 1 4 3];
count=0;
for i=1:numObj(2)
    obj{i}=initPos((count+1):(count+numPoint(i)),:)';
    count=count+numPoint(i);
end

%for i=1:numObj(2)
%    prompt='What's the next R matrix? ';
%    R{i}=input(prompt);
%    prompt='What's the next T matrix? ';
%    T{i}=input(prompt);
%end
R{1}=[1 0 0; 0 1 0; 0 0 1];
T{1}=[1 1; 0 0; 0 0];
R{2}=[1 0 0; 0 1 0; 0 0 1];
T{2}=[0; 0; 0.5];
R{3}=[1 0 0; 0 1 0; 0 0 1];
T{3}=[1 1 1; -1 -1 -1; 0 0 0];
R{4}=[1 0 0; 0 0.8 0.6; 0 0.6 -0.8];
T{4}=[0.2 0.2; 0.7 0.7; 0.3 0.3];

for t=1:20
    view(3);
    hold on
    for i=1:numObj(2)
        obj{i}=R{i}*obj{i}+T{i};
        O=obj{i};
        for j=1:numPoint(i)
            plot3(O(1,j),O(2,j),O(3,j),'.','MarkerEdgeColor',color(i),'MarkerSize',12)
        end
    end
    axis ([-30 30 -30 30 -30 30])
    axis square
    grid on
    pause(0.25)
    clf
end