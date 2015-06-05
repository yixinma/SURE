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
        minErr(n)=baseErr(1,T);
        simSegLth(n,1)=T;
    else
        for t=2:(T-3)
            if refErr(n-1,t)==0
                refErr(n-1,t)=funcErr(n-1,T);
            end
            if baseErr(t,T)==0
                baseErr(t,T)=funcBase(t,T);
            end
            error=refErr(n-1,t)+baseErr(t,T);
            simSegLth(n,:)=simSegLth(n-1,:);
            if minErr(n)==0
                minErr(n)=error;
                simSegLth(n,n)=t;
            elseif error<minErr(n)
                minErr(n)=error;
                simSegLth(n,n)=t;                
            end
        end
    end
    error=minErr(n);
end