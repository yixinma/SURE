% Calculate error of a single segment
function [berror]=newfuncBase(a,b)
    global track
    global numPoint
    A=zeros(numPoint*3*(b-a),12);
    B=zeros(numPoint*3*(b-a),1);
    for h=1:numPoint % h indicates which point we are using
        pts=track{h}; % pts is the track of that point
        for i=a:b-1 % From the first to the last but one element of the segment
            for j=1:3
                dim1=(h-1)*3*(b-a)+3*(i-a)+j;
                for k=1:3
                    dim2=3*(j-1)+k;
                    A(dim1,dim2)=pts(i,k);
                end
                dim3=9+j;
                A(dim1,dim3)=1;
            end
        end
    end
    for h=1:numPoint
        pts=track{h};
        for i=a+1:b
            for j=1:3
                dim4=(h-1)*3*(b-a)+3*(i-a-1)+j;
                B(dim4,1)=pts(i,j);
            end
        end
    end
    X=lscov(A,B);
    berror=(norm(A*X-B))^2;
end