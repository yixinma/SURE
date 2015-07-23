function [result]=TG2L(ref,vec)
    iG=[1; 0; 0];
    jG=[0; 1; 0];
    kG=[0; 0; 1];
    iL=ref(1:3,2)-ref(1:3,1);
    jL=ref(1:3,3)-ref(1:3,1);
    kL=ref(1:3,4)-ref(1:3,1);
    %offset=[0; 0; 0; 1];
    result(1:3)=[dot(iG,iL) dot(jG,iL) dot(kG,iL); dot(iG,jL) dot(jG,jL) dot(kG,jL); dot(iG,kL) dot(jG,kL) dot(kG,kL)]*(vec(1:3)-ref(1:3,1));
    result(4)=1;
end