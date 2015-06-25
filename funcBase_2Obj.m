% Calculate error of a single segment
function [berror]=funcBase_2Obj(a,b)
    global Tr
    global refRank
    diagV=svd(Tr(3*a-2:3*b,:));
    if rank(Tr(3*a-2:3*b,:))==0
        disp('rank');
        disp(rank(Tr(3*a-2:3*b,:)));
        disp('a,b');
        disp(a);
        disp(b);
        disp('diagV');
        disp(diagV);
    end
    for i=rank(Tr(3*a-2:3*b,:)):8
        diagV(i)=0;
    end
    diagV=sort(nonzeros(diagV));
    lamda=0.1;
    berror=lamda*8*(b-a);
    simRank=8;
    for rk=7:-1:3
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