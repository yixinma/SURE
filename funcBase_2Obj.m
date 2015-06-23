% Calculate error of a single segment
function [berror]=funcBase_2Obj(a,b)
    global Tr
    global refRank
    diagV=svd(Tr(3*a-2:3*b,:));
    for i=rank(Tr(3*a-2:3*b,:)):10
        diagV(i)=0;
    end
    diagV=sort(nonzeros(diagV));
    lamda=0.1;
    berror=lamda*8*(b-a);
    simRank=8;
    for rk=7:-1:4
        err=lamda*rk*(b-a);
        for i=1:(8-rk)
            err=err+diagV(i);
        end
        if err<berror
            berror=err;
            simRank=rk;
        end
    end 
    refRank(a,b)=simRank;
end