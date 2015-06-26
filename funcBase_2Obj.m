% Calculate error of a single segment
function [berror]=funcBase_2Obj(a,b)
    global Tr
    global refRank
    diagV=svd(Tr(4*a-3:4*b,:));
    r=rank(Tr(4*a-3:4*b,:));
    %
    if r<=3
        disp('rank');
        disp(r);
        disp('a,b');
        disp(a);
        disp(b);
        disp('diagV');
        disp(diagV);
        disp(Tr(4*a-3:4*b,:));
    end
    %}
    for i=r+1:8
        diagV(i)=0;
    end
    diagV=sort(nonzeros(diagV));
    lamda=1;
    berror=lamda*8*(b-a);
    simRank=8;
    for rk=7:-1:4
        err=0;
        for i=1:(8-rk)
            err=err+diagV(i)^2;
        end
        err
        err=err+lamda*rk*(b-a);
        err
        if err<berror
            berror=err;
            simRank=rk;
        end
    end 
    refRank(a,b)=simRank;
end