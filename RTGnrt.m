function [M]=RTGnrt(ind)
scale=5;
M=zeros(4);
% 0 One rigid body rank 4
if ind==0
    M=[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
end
% 1 Revolute pair rank 5
% 2 Prismatic pair rank 4
% 3 Screw pair rank 6
% 4 Cylindrical pair rank 6
% 5 Spherical pair rank 6
% 7 Arbitrary rank 8
if ind==1 || ind==2 || ind==3 || ind==4 || ind==5 || ind==7
    A1=(rand(1,3)*2-1)*scale;
    A2=(rand(1,3)*2-1)*scale;
    a=A1(1);
    b=A1(2);
    c=A1(3);
    d=A2(1);
    e=A2(2);
    f=A2(3);
    u=d-a;
    v=e-b;
    w=f-c;
    L=sqrt(u^2+v^2+w^2);
    theta=rand*2*pi;   
    k=(rand*2-1)*scale;
    if ind==2
        M=[1 0 0 k*u; 0 1 0 k*v; 0 0 1 k*w; 0 0 0 1]; 
    elseif ind==5
        M(1:3,1:3)=rotx(rand*4*pi-2*pi)*roty(rand*4*pi-2*pi)*rotz(rand*4*pi-2*pi);
        M(1:3,4)=[0; 0; 0];
        M(4,1:4)=[0 0 0 1];
    else 
        M(1,1)=(u^2+(v^2+w^2)*cos(theta))/L^2;
        M(1,2)=(u*v*(1-cos(theta))-w*L*sin(theta))/L^2;
        M(1,3)=(u*w*(1-cos(theta))+v*L*sin(theta))/L^2;
        M(1,4)=((a*(v^2+w^2)-u*(b*v+c*w))*(1-cos(theta))+(b*w-c*v)*L*sin(theta))/L^2;
        M(2,1)=(u*v*(1-cos(theta))+w*L*sin(theta))/L^2;
        M(2,2)=(v^2+(u^2+w^2)*cos(theta))/L^2;
        M(2,3)=(v*w*(1-cos(theta))-u*L*sin(theta))/L^2;
        M(2,4)=((b*(u^2+w^2)-v*(a*u+c*w))*(1-cos(theta))+(c*u-a*w)*L*sin(theta))/L^2;
        M(3,1)=(u*w*(1-cos(theta))-v*L*sin(theta))/L^2;
        M(3,2)=(v*w*(1-cos(theta))+u*L*sin(theta))/L^2;
        M(3,3)=(w^2+(u^2+v^2)*cos(theta))/L^2;
        M(3,4)=((c*(u^2+v^2)-w*(a*u+b*v))*(1-cos(theta))+(a*v-b*u)*L*sin(theta))/L^2;
        M(4,:)=[0 0 0 1];
    end
    if ind==3 || ind==4
        M(1,4)=M(1,4)+k*u;
        M(2,4)=M(2,4)+k*v;
        M(3,4)=M(3,4)+k*w;
    end
    if ind==7
        M(1,4)=M(1,4)+rand;
        M(2,4)=M(2,4)+rand;
        M(3,4)=M(3,4)+rand;
    end
end
% 6 Planar pair rank 4
if ind==6
    A1=(rand(1,3)*2-1)*scale;
    A2=(rand(1,3)*2-1)*scale;
    A3=(rand(1,3)*2-1)*scale;
    a=A1(1);
    b=A1(2);
    c=A1(3);
    A4=cross(A2,A3);
    u=A4(1);
    v=A4(2);
    w=A4(3);
    L=sqrt(u^2+v^2+w^2);
    theta=rand*2*pi;   
    k=(rand*2-1)*scale;
    l=(rand*2-1)*scale;
    M(1,1)=(u^2+(v^2+w^2)*cos(theta))/L^2;
    M(1,2)=(u*v*(1-cos(theta))-w*L*sin(theta))/L^2;
    M(1,3)=(u*w*(1-cos(theta))+v*L*sin(theta))/L^2;
    M(1,4)=((a*(v^2+w^2)-u*(b*v+c*w))*(1-cos(theta))+(b*w-c*v)*L*sin(theta))/L^2+k*A2(1)+l*A3(1);
    M(2,1)=(u*v*(1-cos(theta))+w*L*sin(theta))/L^2;
    M(2,2)=(v^2+(u^2+w^2)*cos(theta))/L^2;
    M(2,3)=(v*w*(1-cos(theta))-u*L*sin(theta))/L^2;
    M(2,4)=((b*(u^2+w^2)-v*(a*u+c*w))*(1-cos(theta))+(c*u-a*w)*L*sin(theta))/L^2+k*A2(2)+l*A3(2);
    M(3,1)=(u*w*(1-cos(theta))-v*L*sin(theta))/L^2;
    M(3,2)=(v*w*(1-cos(theta))+u*L*sin(theta))/L^2;
    M(3,3)=(w^2+(u^2+v^2)*cos(theta))/L^2;
    M(3,4)=((c*(u^2+v^2)-w*(a*u+b*v))*(1-cos(theta))+(a*v-b*u)*L*sin(theta))/L^2+k*A2(3)+l*A3(3);
    M(4,:)=[0 0 0 1];
end
end