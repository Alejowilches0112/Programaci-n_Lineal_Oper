
 
function sp = simplex(restriccion,f_obj,val,tipo)
comp=eye(size (restriccion,1));
%matriz identidad
if(tipo== 'maximizar')
    ec = [restriccion(:,:) comp(:,:) val(:); f_obj .* (-1) 0 0 0 0]%llena la tabla con todas las filas ycolumnas de las restriccione y todas las filas y columnas de la matriz identidad y los valores totales
else
    ec=[restriccion(:,:) comp(:,:) val(:); f_obj 0 0 0 0]
end;

ban='minimizar';
nColum=size(ec,2);
nFilas=size(ec,1);
p=1;
while ban=='minimizar'% valor menor de la funcion objetivo de la ultima fila de la matriz y la columna en la que se encuentra
    nc=1;
    menorRes= ec(nFilas,1);
    for i=2:(nColum-1)
        if ec(nFilas,i)< menorRes
            menorRes=ec(nFilas,i)nc=i
        end;
    end;%dividimos la columna de la solucion para la columna donde se encuentra el pivote
    ax=[0;0;0];
    for i=1:3
        if ec(i,nColum)>0
            ax(i,1)=[ec(i,nColum)./ec(i,nc)]
        else
            ax(i,1)=val(i,1);
        end;
    end;% numero menor del resultado de la division asi como su posicion
    nf=1;
    menorVal=ax(1,1);
    for i=2:(nFilas-1)
        if ax(i,1) < menorValmenor
            Val=ax(i,1)
            nf=i
        end;
    end;%Encontrado el numero de fila y numero de columna del pivote verificamos cual es el pivote
    piv=ec(nf,nc)%dividimos todos los numeros de la fila donde esta el pivote por el pivote
    ec(nf,:)=ec(nf,:)./piv
    for i=1:nFilas
        if i~= nf
            ec(i,:)= ec(i,:)-(ec(i,nc)*ec(nf,:))
        end;
    end;
    if min(ec(nFilas,:))<0 
        ban='minimizar'
    else
        ban= 'maximizar's=ec(nFilas,nColum)
    end;
end;