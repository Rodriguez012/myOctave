function simpson()
%simpson(x,y) lee dos vectores: x,y donde: 
%x: vector de dos elementos con limite inferior y superior: x=[inf,sup]
%y: vector de 4 elementos correspondientes a las imagenes de x: y=[f(x0),f(x1),f(x2),f(x3)]
%la funcion asume que ud ya ordeno los datos y los tiene igualmente espaciados


disp("ingrese entre corchetes el vector  f(x)=[f(x0),f(x1),f(x2),f(x3)]")
y=input('');
disp("ingrese entre corchetes el vector limites=[inf, sup]" )
x=input('');
%loop, en caso de haber ingresado mal los vectores
while ( columns (x)~=2 &&  columns (y)~=4)
disp("ingrese entre corchetes el vector  f(x)=[f(x0),f(x1),f(x2),f(x3)]")
y=input('');
disp("ingrese entre corchetes el vector limites=[inf, sup]" )
x=input('');
endwhile

area=(( x(2)-x(1) )*( y(1)+3*y(2)+3*y(3)+y(4) ))/8;
disp("el area bajo la curva es:"), disp(area)
endfunction
