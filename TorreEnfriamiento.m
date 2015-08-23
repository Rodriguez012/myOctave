%source("/home/luis/Mis_programas/Octave/EntalpiaSatAire-agua.m")

H=[9479,29360,57570,100030,166790,275580,461500]%J/Kg
T=[0,10,20,30,40,50,60]%°C
%Datos leidos de tabla 7.1 Treyball  2ed en español 
output_precision(2);

plot(T,H)
grid on 
%elaborar una regresion a fin de predecir comportamiento de Entalpia

f = polyfit(T,H, 2);
polyout(f, "T")

%obtenemos
% 152.58*T^2 - 2163.1*T^1 + 23722


plot(T, H, "*", T, polyval(f, T), "-");
grid on;

%a fin de extrapolar creamos u n vector desde la T abajo de la torre 
T=1:1:100;
H=152.58.*T.^2 - 2163.1.*T + 23722;

%Hmezcla=68500 J/kg aire seco
Ho=68500;
%como la Temperatura en nuestro vector crece linearmente a razon de 1, 
%el max valor de la pendiente m viene dado por la recta que corta Ho y H equilibrio
%es decir en H(95)

%T1=34°C y T2=95°C
m=(H(95)-Ho)/(95-34);


pase=input ("Elaboramos una regresion en base a los datos de equilibrio del agua. Pres ENTER para seguir");


%ahora: Hop=m.*(T-34)+68500;
Tem=34:1:100;
Hop=m.*(Tem-34)+68500;
pase=input ("Creamos una linea que corta los valores conocidos de T con la curva de equilibrio a fin de iterar. Pres ENTER para seguir");

%observamos
plot(T,H,Tem,Hop)
grid on
%Descubrimos que tenemos una recta de operacion que corta dos veces la curva de equilibrio
%para determinar m maxima (ideal)




disp("realizamos un proceso iterativo para determinar la Recta de operacion optima");
k=m;
ok=1;
while ok~=0

    k=m-m*0.01;
    m=k;
    Hop=m.*(Tem-34)+68500;
    plot(T,H,Tem,Hop)
    grid on
    xlabel("Temperatura °C")
    ylabel("Entalpia J/kg aire seco")
    ok=input("otra iteracion 1:SI 0:NO");
  
end
pase=input ("la pendiente de operacion es 1.5 veces el minimo. por tanto dividimos por ese valor (Pres ENTER para seguir)");
ma=m/1.5;
Hop=(ma).*(Tem-34)+68500;
plot(T,H,Tem,Hop);
grid on;
hold on
xlabel("Temperatura °C")
ylabel("Entalpia J/kg aire seco")

pase=input ("Creamos puntos igualmente espaciados sobre la recta de operacion. Pres ENTER para seguir");
%m Operacion=L'*CaL/G's


%para unir los puntos a la curva de equilibrio


%puntos sobre la Recta de operacion
temp=linspace(34,95,5);
x=temp;
Htemp=ma.*(temp-34)+68500;
y=Htemp;
plot(temp,Htemp,'r *')



%la pendiente  que une la Leq y Lop viene dada por hLa/kya
hk=-644.31;
%sea la recta que corta: y=hk*(x-xx)+yy

N=ones(1,length(x));
O=ones(1,length(x));

i=1;
while i<=length(temp)
  yy=Htemp(i);
  xx=temp(i);
  %al simultanear se tiene
  %152.58x^2-x-1518.79+(hk*xx+23722-yy)
  a=152.58;
  b=-1518.79;
  c=(hk*xx+23722-yy);
  eq=[a,b,c];
  N(i)=max(roots(eq));
  %sea la recta que corta: y=hk*(x-xx)+yy
  O(i)=hk*(N(i)-xx)+yy;
  i=i+1;
endwhile

i=1;
while i<=length(temp)
a=[temp(i),N(i)];
b=[Htemp(i),O(i)];
plot(a,b, 'r')
hold on
i=i+1;
end

%calculamos 1/(H*'-H')
i=1;
while i<=length(temp)
frac(i)=1/(O(i)-Htemp(i));
i=i+1;
end

Integral=trapz(temp,frac);


%obtenemos los datos necesarios

kya=0.85;
Cal=4206.8775;
L=1540.99; %kg/s
%dao que m=L'*CAL/G's
G=(L*Cal/m)*1.5;

%I=Kya*Z/G's
Z=Integral*G/kya;

hold off
