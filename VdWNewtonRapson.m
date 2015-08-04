output_precision(10);
%var globales
R=8.314; %J/molK
Na=6.022*10^23; %mol^-1 
%para n-Butano
Tc=425.1;     %K
Vc=2.55*10^-4; %m^3/mol
Pc=3976000; %Pascal

a=27*(R*Tc)^2/(64*Pc);
b=R*Tc/(8*Pc);


%ingresamos datos conocidos
T=350;
P=945730;


V=R*T/P; %calcular vaor inicial Vj
ok=1;
k=P; %un dato que jamas sera =Vol
diferencia=abs(V-k);

while (diferencia/V>0.05)
  V
   f1=P*V-b*P+a/V-a*b/(V^2)-R*T;  %Ecn VdW
  f0=P-a/(V^2)+2*a*b/(V^3);       %Ecn VdW derivada
  k=V-(f1/f0);
  diferencia=abs(V-k);
  V=k;
endwhile  
