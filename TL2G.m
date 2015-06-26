function [result]=TL2G(ref,vec)
    iG=[1; 0; 0];
    jG=[0; 1; 0];
    kG=[0; 0; 1];
    iL=ref(1:3,2)-ref(1:3,1);
    jL=ref(1:3,3)-ref(1:3,1);
    kL=ref(1:3,4)-ref(1:3,1);
    result=[dot(iG,iL) dot(iG,jL) dot(iG,kL) ref(1,1); dot(jG,iL) dot(jG,jL) dot(jG,kL) ref(2,1); dot(kG,iL) dot(kG,jL) dot(kG,kL) ref(3,1); 0 0 0 1]*vec;
end