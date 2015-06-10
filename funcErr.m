% Calculate minimum error recursively
function [error,part]=funcErr(n,T)
    global minErr
    global baseErr
    global zeroBaseErr
    global refErr
    global simSegLth
    global refPart
    if n==1
        if zeroBaseErr(T)==0
            zeroBaseErr(T)=funcBase(0,T);
        end
        minErr(n,T)=zeroBaseErr(T);
    else
        for t=(T-1):-1:(n-1)
            if refErr(n-1,t)==0
                [refErr(n-1,t),refPart(n-1,t)]=funcErr(n-1,t);
            end
            if baseErr(t,T)==0
                baseErr(t,T)=funcBase(t,T);
            end
            error=refErr(n-1,t)+baseErr(t,T);
            if minErr(n,T)==0
                minErr(n,T)=error;
                simSegLth(n,T)=t;
            elseif error<minErr(n,T)
                minErr(n,T)=error;
                simSegLth(n,T)=t;                
            end
        end
    end
    error=minErr(n,T);
    part=simSegLth(n,T);
end