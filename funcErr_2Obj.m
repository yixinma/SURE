% Calculate minimum error recursively
function [error]=funcErr_2Obj(n,T)
    global minErr
    global baseErr
    global refErr
    global simSegLth
    if n==1
        if minErr(1,T)==0
            minErr(1,T)=funcBase_2Obj(1,T);
        end
    else
        for t=T-1:-1:n
            if refErr(n-1,t)==0
                refErr(n-1,t)=funcErr_2Obj(n-1,t);
            end
            if baseErr(t,T)==0
                baseErr(t,T)=funcBase_2Obj(t,T);
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