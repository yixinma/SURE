function [result]=TG2L(ref,vec)
    iG=[1; 0; 0];
    jG=[0; 1; 0];
    kG=[0; 0; 1];
    iL=ref(:,2)-ref(:,1);
    jL=ref(:,3)-ref(:,1);
    kL=ref(:,4)-ref(:,1);
    result=[dot(iG,iL) dot(jG,iL) dot(kG,iL); dot(iG,jL) dot(jG,jL) dot(kG,jL); dot(iG,kL) dot(jG,kL) dot(kG,kL)]*(vec+ref(:,1));
end