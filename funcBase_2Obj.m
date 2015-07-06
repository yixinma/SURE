% Calculate error of a single segment
function [berror]=funcBase_2Obj(a,b)
    global Tr
    global refRank
    disp(a);
    disp(b);
    diagV=svd(Tr(4*a-3:4*b,:));
    %r=rank(Tr(4*a-3:4*b,:));
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
    diagV=sort(diagV);
    lamda=0.001;
    berror=lamda*exp(8)*(b-a);
    simRank=8;
    err=zeros(7,1);
    lerr=zeros(7,1);
    for rk=7:-1:4
        for i=1:(8-rk)
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
        lerr(rk)=err(rk)+lamda*exp(rk)*(b-a);
        %{
        disp(rk);
        disp(err(rk));
        disp(lerr(rk));
        %}
        if lerr(rk)<berror
            berror=lerr(rk);
            simRank=rk;
        end
    end        
    berror=berror+2;
    refRank(a,b)=simRank;
end