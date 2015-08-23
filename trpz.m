function trpz(x,y)
%recibe un vector de puntos (x) de cualquier tamano, y y su imagen en (y) 

n=columns(x);
integral=0;
rectan=0;

for i=1:(n)
	if (i~=n)
	rectan=(x(i+1)-x(i))*(y(i+1)+y(i))/2;
	integral=rectan+integral;
	endif
endfor

disp("el area es:"), disp(integral)
hold off
plot(y,x,'ro','markersize',8,'markerfacecolor','r')
hold on
area(y,x)
grid on
hold off



