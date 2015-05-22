figure
for sigma=0.1:0.1:5
e=zeros(1,100);
for g=1:100
    %prompt='Please enter the rotation matrix T = ';	
    %R0=input(prompt);
    %R0=[1 0 0; 0 1 0; 0 0 1];
    R0=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);
    %prompt='Please enter the rotation matrix T = ';
    %T0=input(prompt);
    %T0=[1; 1; 1];
    T0=10*rand(3,1)-5;
    %prompt='Please enter the initial positions of tracking points in order: ';
    %initPos=input(prompt);
    initPos=[1 2 3; 1 1 2; 1 2 1];

    numPoint=size(initPos,1);
    track=cell(numPoint);
    t=10;
    pts=zeros(t,3);

    for i=1:numPoint
        pt=(initPos(i,:))';
        for j=1:t
            pts(j,:)=pt';
            pt=R0*pt+T0;
        end
        noise=1/(sqrt(2*pi)*sigma)*exp(-pts.^2./(2*sigma^2));
        track{i}=pts+noise;
    end

    A=zeros(numPoint*3*(t-1),12);
    for h=1:numPoint
        pts=track{h};
        for i=1:(t-1)
            for j=1:3
                dim1=(h-1)*3*(t-1)+3*(i-1)+j;
                for k=1:3
                    dim2=3*(j-1)+k;
                    A(dim1,dim2)=pts(i,k);
                end
                dim3=9+j;
                A(dim1,dim3)=1;
            end
        end
    end

    b=zeros(numPoint*3*(t-1),1);
    for h=1:numPoint
        pts=track{h};
        for i=2:t
            for j=1:3
                dim4=(h-1)*3*(t-1)+3*(i-2)+j;
                b(dim4,1)=pts(i,j);
            end
        end
    end

    X=lscov(A,b);

    R=zeros(3,3);
    for i=1:3
        for j=1:3
            R(i,j)=X(3*(i-1)+j,1);
        end
    end

    T=zeros(3,numPoint);
    for h=1:numPoint
        for i=1:3
            T(i,h)=X(9+i,1);
        end
    end
    
    diffR=R0-R;
    diffT=T0-T(:,1);
    
    e(g)=sumabs(diffR)/9;   
end
Y=mean(e);
L=mean(e)-std(e);
U=mean(e)+std(e);
hold on
errorbar(sigma, Y, L, U, 'rx')
end

%{
color='rbgkymcw';
Obj=initPos';
for h=1:t
    view(3);
    hold on 
    Obj=R*Obj+T;
    for j=1:numPoint
        plot3(Obj(1,j),Obj(2,j),Obj(3,j),'.','MarkerEdgeColor',color(1),'MarkerSize',12)
    end
    axis ([0 20 0 20 0 20])
    axis square
    grid on
    pause(0.25)
    clf
end
%}