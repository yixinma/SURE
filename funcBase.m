% Calculate error of a single segment
function [berror]=funcBase(a,b)
    global track
    global numPoint
    global initPos
    A=zeros(numPoint*3*3*(b-a),12);
    for h=1:numPoint % h indicates which point we are using
        pts=track{h}; % pts is the track of that point
        sPt=initPos(h,:);
        for i=3*a:(3*b-1) % From the first to the last but one element of the segment
            for j=1:3
                dim1=(h-1)*3*3*(b-a)+3*(i-3*a)+j;
                for k=1:3
                    dim2=3*(j-1)+k;
                    if i==0
                        A(dim1,dim2)=sPt(1,k);
                    else
                        A(dim1,dim2)=pts(i,k);
                    end
                end
                dim3=9+j;
                A(dim1,dim3)=1;
            end
        end
    end
    B=zeros(numPoint*3*3*(b-a),1);
    for h=1:numPoint
        pts=track{h};
        for i=(3*a+1):(3*b)
            for j=1:3
                dim4=(h-1)*3*3*(b-a)+3*(i-3*a-1)+j;
                B(dim4,1)=pts(i,j);
            end
        end
    end
    X=zeros(12,1);
    X=lscov(A,B);
    berror=(norm(A*X-B))^2;
end