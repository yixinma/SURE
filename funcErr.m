% Calculate minimum error recursively
function [error]=funcErr(n,T)
    global minErr
    global baseErr
    global refErr
    global simSegLth
    if n==1
        if baseErr(1,T)==0
            baseErr(1,T)=funcBase(1,T);
        end
        minErr(1,T)=baseErr(1,T);
        simSegLth(1,T)=T;
    else
        for t=1:T
            if refErr(n-1,t)==0
                refErr(n-1,t)=funcErr(n-1,t);
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
end