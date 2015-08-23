function [t,x] =rk_1(f,t0,tfi,x0,n)   
%con n como el numero de pasos o bloques a segmentar entre las cond de frontera, f la funcion a tratar
%t0 el valor inicial de la variable independiente, tfi valor de frontera de la variable independiente
%x0 es el valoe inicial de la variab le dependiente
    h=(tfi-t0)/n;   %salto de pasos
    t=t0:h:tfi;
    x=zeros(n+1,1); %reserva memoria para n elementos del vector x
    x(1)=x0;
    for i=1:n
        k1=h*f(t(i),x(i));
        k2=h*f(t(i)+h/2,x(i)+k1/2);
        k3=h*f(t(i)+h/2,x(i)+k2/2);
        k4=h*f(t(i)+h,x(i)+k3);
        x(i+1)=x(i)+(k1+2*k2+2*k3+k4)/6;
     end
end


%PRUEBA
%datos
v0=500; %gal
c1=2; %lb NaCl/gal
q1=5;  %gal/min
q2=5;  %gal/min

%condiciones de frontera
t0=0; %min
x0=0; %agua fresca
tfi=90; %min

n=20;

f=@(t,x) q1*c1-(q2*x/(v0+(q1-q2)*t));

[t,x]=rk_1(f,t0,tfi,x0,n);

plot(t,x)
hold on
grid on
ylabel('lb de sal en tanque')
xlabel('tiempo en minutos')

x(21) %corresponde a t=90 minutos



 
