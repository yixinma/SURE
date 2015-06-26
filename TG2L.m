function [result]=TG2L(ref,vec)
    iG=[1; 0; 0];
    jG=[0; 1; 0];
    kG=[0; 0; 1];
    iL=ref(1:3,2)-ref(1:3,1);
    jL=ref(1:3,3)-ref(1:3,1);
    kL=ref(1:3,4)-ref(1:3,1);
    result=[dot(iG,iL) dot(jG,iL) dot(kG,iL) 0; dot(iG,jL) dot(jG,jL) dot(kG,jL) 0; dot(iG,kL) dot(jG,kL) dot(kG,kL) 0; 0 0 0 1]*(vec+ref(:,1));
end