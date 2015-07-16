% Calculate error of a single segment
function [berror]=funcBase_2Obj(a,b)
    global Tr
    global refRank
    %noise=randn(4*(17+1),12)*0.0001; %%%%%%%
    %Trr=Tr+noise;
    disp(a);
    disp(b);
    diagV=svd(Tr(4*a-3:4*b,:));
    r=rank(Tr(4*a-3:4*b,:));
    disp(r);
    %{
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
    %{
    for i=r+1:8
        diagV(i)=0;
    end
    %}
    %diagV=sort(nonzeros(diagV));
    diagV=sort(diagV,'descend');
    lamda=0.1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    err=zeros(8,1);
    lerr=zeros(8,1);
    for rk=8:-1:4
        for i=rk+1:size(diagV)
            err(rk)=err(rk)+diagV(i)^2;
        end
        %{
        if rk<7
            if err(rk)>100*err(rk+1)
                berror=err(rk+1);
                simRank=rk+1;
            end
        end
        %}
        lerr(rk)=err(rk)+lamda*rk^2; % *(b-a) is not for inside judgement
    end
        %{
        disp(rk);
        disp(err(rk));
        disp(lerr(rk));
        %}
    disp(diagV);
    disp(err);
    %disp(err(8));
    %disp(err(7));
    disp(lerr);
    berror=lerr(8);
    simRank=8;
    for rk=7:-1:4
        if lerr(rk)<berror
            berror=lerr(rk);
            simRank=rk;
        end
    end        
    berror=berror+0;
    refRank(a,b)=simRank;
end