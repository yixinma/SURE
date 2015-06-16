% Calculate minimum error recursively
function [error]=newfuncErr(n,T)
    global minErr
    global baseErr
    global refErr
    global simSegLth
    if n==1
        if minErr(1,T)==0
            minErr(1,T)=newfuncBase(1,T);
        end
    else
        for t=(T-2):-1:(2*n-1)
            if refErr(n-1,t)==0
                [refErr(n-1,t)]=newfuncErr(n-1,t);
            end
            if baseErr(t,T)==0
                baseErr(t,T)=newfuncBase(t,T);
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