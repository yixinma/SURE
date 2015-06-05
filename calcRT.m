%prompt='Enter the trajectory of the point: ';
%track=input(prompt);
track=[1 2 3; 2 3 4; 3 4 5; 4 5 6; 5 6 7; 6 7 8; 7 8 9];
t=size(track,1);

A=zeros((3*(t-1)),12);
for i=1:(t-1)
    for j=1:3
        dim1=3*(i-1)+j;
        for k=1:3
            dim2=3*(j-1)+k;
            A(dim1,dim2)=track(i,k);
        end
        dim3=9+j;
        A(dim1,dim3)=1;
    end
end

b=zeros((3*(t-1)),1);
for i=2:t
    for j=1:3
        dim4=3*(i-2)+j;
        b(dim4,1)=track(i,j);
    end
end

X=lscov(A,b);

R=zeros(3,3);
for i=1:3
    for j=1:3
        R(i,j)=X(3*(i-1)+j,1);
    end
end

T=zeros(3,1);
for i=1:3
    T(i)=X(9+i,1);
end

R
T