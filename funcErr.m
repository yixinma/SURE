% Calculate minimum error recursively
function error=funcErr(n,T)
    global minErr
    global baseErr
    global ref
    if n==1
        if baseErr(1,T)==0
            minErr(n,T)=base(1,T);
        else
            minErr(n,T)=baseErr(1,T);
        end
    else
        for t=1:T
            if ref(n-1,t)==0
                ref(n-1,t)=funcErr(n-1,T);
            end
            if baseErr(t+1,T)==0
                baseErr(t+1,T)=base(t+1,T);
            end
            error=ref(n-1,t)+baseErr(t+1,T);
            if minErr(n,T)==0
                minErr(n,T)=error;
            elseif error<minErr(n,T)
                minErr(n,T)=error;
            end
        end
    end
    error=minErr(n,T);
end