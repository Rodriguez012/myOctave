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

f=@(t,x) -exp(-t)*x^2;

t0=0; x0=2; n=50; tfi=5;

%En este caso, la funcion es directamente evaluada
[t,x]=rk_1(f,t0,tfi,x0,n);

%PROCEDEMOS A USAR LSODE 
%cambiamos de f(t,x) a f(x,t) 
%porque LSODE asi lo requiere
f=@ (x,t) -exp(-t)*x^2;

xx=lsode(f,x0,(tt=linspace(t0,tfi,n)'));
plot(t,x,'* -r',tt,xx,'b')
hold on
grid on
legend('Algoritmo  Runge-Kutta','LSODE')
