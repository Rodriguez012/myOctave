%definamos un vector de T y otro de P
T=[350,355,360,365,370]; %K
P=[9.4573,9.521,9.5414,9.573,9.621];

format long %para mayor precision. tambien puede usar: output_precision(n)

data=[0,0,1/8,27/64,3/8;0,1,0.08664,0.42748,1/3;1,0,0.08664,0.42748,1/3;1+2^(1/2),1/2^(1/2),.0778,0.45724,0.3074];
ctes=data(2,:); 
R=83.14;
Tc=425.1; %K
Pc=37.96; %bar


sigma=ctes(1); epsilon=ctes(2); omega=ctes(3); psi=ctes(4);

%Presion y Tem criticas
Tr=T./Tc;
Pr=P./Pc;

%procedemos a solucionar las ctes de la ecn cubica
alfa=Tr.^(1/2);
b=omega.*Pr./Tr;
%z=ones(1,length(T));
q=psi.*Tr.^(-3/2)./omega;
aux=0;

for  i=1:length(T)
 z=1;
while abs(z-aux)>0.000001
  aux=z;
  z=1+b(i)-q(i)*b(i)*(z-b(i))/(z*(z+b(i)));
  
endwhile
zeta(i)=z;
endfor

%NOTA:para liq saturado z=b+z*(z+b)*(1+b+z)/(q*b)

%ahora determinamos volumen PV=zRT
V=zeta.*R.*T./P;  %en cm^3/mol
