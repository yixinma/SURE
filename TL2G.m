function [result]=TL2G(ref,vec)
    iG=[1; 0; 0];
    jG=[0; 1; 0];
    kG=[0; 0; 1];
    iL=ref(:,2)-ref(:,1);
    jL=ref(:,3)-ref(:,1);
    kL=ref(:,4)-ref(:,1);
    result=[dot(iG,iL) dot(iG,jL) dot(iG,kL); dot(jG,iL) dot(jG,jL) dot(jG,kL); dot(kG,iL) dot(kG,jL) dot(kG,kL)]*vec+ref(:,1);
end