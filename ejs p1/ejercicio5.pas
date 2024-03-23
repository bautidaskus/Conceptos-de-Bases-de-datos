program ejercicio5;
//5. Realizar un programa, con la declaración de tipos correspondientes que permita
//crear un archivo de registros no ordenados con información de especies de flores
//originarias de América. La información será suministrada mediante teclado. De
//cada especie se registra: número de especie, altura máxima, nombre científico,
//nombre vulgar, color y altura máxima que alcanza. La carga del archivo debe
//finalizar cuando se reciba como nombre científico: ’zzz’.
//Además se deberá contar con opciones del programa que posibiliten:
//a) Reportar en pantalla la cantidad total de especies y la especie de menor y de
//mayor altura a alcanzar.
//b) Listar todo el contenido del archivo de a una especie por línea.
//c) Modificar el nombre científico de la especie flores cargada como: Victoria
//amazonia a: Victoria amazónica.
//d) Añadir una o más especies al final del archivo con sus datos obtenidos por
//teclado. La carga finaliza al recibir especie “zzz”.
//e) Listar todo el contenido del archivo, en un archivo de texto llamado “flores.txt”.
//El archivo de texto se tiene que poder reutilizar.
//f) ¿Qué cambiaría en la escritura del archivo de texto si no fuera necesario utilizarlo?
//para que el archivo sea reutilizable, se debería abrir el archivo en modo append, para que no se sobreescriba.
//si no fuera necesario reutilizarlo, se podría abrir el archivo en modo rewrite, para que se sobreescriba.

type
    cadena = string[20];
    //defino el registro flor, con los campos solicitados
    flor = record
        num: integer;
        nombreCientifico: cadena;
        nombreVulgar: cadena;
        color: cadena;
        alturaMaxima: real;
    end;
    //defino el archivo de registros de flores
    archivo = file of flor;

//procedimiento para cargar los datos de una flor
procedure cargarFlor(var f: flor);
begin
    writeln('Ingrese el nombre cientifico');//leo el nombre cientifico y si es 'zzz' no leo mas datos
    readln(f.nombreCientifico);
    if (f.nombreCientifico <> 'zzz') then begin//si el nombre cientifico no es 'zzz' sigo leyendo los datos
        writeln('Ingrese el numero de la especie');
        readln(f.num);
        writeln('Ingrese el nombre vulgar');
        readln(f.nombreVulgar);
        writeln('Ingrese el color');
        readln(f.color);
        writeln('Ingrese la altura maxima que alcanza');
        readln(f.alturaMaxima);
        end;
end;

//procedimiento para mostrar los datos de una flor
procedure mostrarFlor(f: flor);
begin
    //imprimo los datos de la flor recibida por parametro en una sola linea
    write(' / Numero de especie: ', f.num);
    write(' / Nombre cientifico: ', f.nombreCientifico);
    write(' / Nombre vulgar: ', f.nombreVulgar);
    write(' / Color: ', f.color);
    write(' / Altura maxima que alcanza: ', f.alturaMaxima:2:2);
end;

//procedimiento para mostrar la cantidad total de especies y la especie de menor y mayor altura
procedure cantidadTotalEspecies(var a: archivo); //recibo el archivo por referencia, ya que si no es por referencia, no se podria modificar
var
    //declaro las variables necesarias, una flor, un contador de especies, variables para maximos y minimos y 2 flores para guardar las especies de menor y mayor altura
    f: flor;
    cantEspecies: integer;
    menorAltura, mayorAltura: real;
    especieMenorAltura, especieMayorAltura: flor;
begin
    reset(a);//abro el archivo en modo lectura
    cantEspecies:= 0;
    menorAltura:= 9999;
    mayorAltura:= 0;
    while (not eof(a)) do begin //mientras no llegue al final del archivo, leo una flor
        read(a, f);//leo una flor del archivo a y la guardo en f
        cantEspecies:= cantEspecies + 1;//sumo 1 al contador de especies
        if (f.alturaMaxima < menorAltura) then begin //hago las comparaciones para ver si la flor leida es la de menor o mayor altura y las guardo en las variables correspondientes
            menorAltura:= f.alturaMaxima;
            especieMenorAltura:= f;
        end;
        if (f.alturaMaxima > mayorAltura) then begin
            mayorAltura:= f.alturaMaxima;
            especieMayorAltura:= f;
        end;
    end;
    writeln('Cantidad total de especies: ', cantEspecies);//muestro los resultados
    writeln('Especie de menor altura: ');
    mostrarFlor(especieMenorAltura); //llamo al procedimiento mostrarFlor para mostrar los datos de la flor de menor altura
    writeln('Especie de mayor altura: ');
    mostrarFlor(especieMayorAltura); //llamo al procedimiento mostrarFlor para mostrar los datos de la flor de mayor altura
    close(a); //cierro el archivo, importante cerrar el archivo. Si no se cierra, se pueden perder datos. 
end;

//procedimiento para listar todo el contenido del archivo de a una especie por linea
procedure listarContenido(var a: archivo);
var
    f: flor;
begin
    reset(a);//abro el archivo en modo lectura
    while (not eof(a)) do begin//mientras no llegue al final del archivo, leo una flor
        read(a, f);//leo una flor del archivo a y la guardo en f
        mostrarFlor(f);//llamo al procedimiento mostrarFlor para mostrar los datos de la flor leida
    end;
    close(a);//cierro el archivo, importante cerrar el archivo. Si no se cierra, se pueden perder datos.
end;

//procedimiento para modificar el nombre cientifico de la especie Victoria amazonia a Victoria amazonica
procedure modificarNombreCientifico(var a: archivo);
var
    f: flor;
begin
    reset(a);//abro el archivo en modo lectura
    while (not eof(a)) do begin//mientras no llegue al final del archivo, leo una flor
        read(a, f);//leo una flor del archivo a y la guardo en f
        if (f.nombreCientifico = 'Victoria amazonia') then begin//si el nombre cientifico es 'Victoria amazonia', lo modifico a 'Victoria amazonica'
            f.nombreCientifico:= 'Victoria amazonica';
            seek(a, filepos(a) - 1);//me posiciono en el registro que acabo de leer
            write(a, f);//sobreescribo el registro con el nombre cientifico modificado
        end;
    end;
    close(a);//cierro el archivo.
end;

//procedimiento para añadir una o mas especies al final del archivo
procedure agregarEspecies(var a: archivo);
var
    f: flor;
begin
    reset(a);//abro el archivo en modo lectura
    seek(a, filesize(a));//me posiciono al final del archivo
    cargarFlor(f);//cargo los datos de una flor
    while (f.nombreCientifico <> 'zzz') do begin
        write(a, f);//escribo la flor en el archivo
        cargarFlor(f);//cargo los datos de una flor
    end;
    close(a);//cierro el archivo
end;    

//procedimiento para listar todo el contenido del archivo en un archivo de texto
procedure listarContenidoEnArchivoTexto(var a: archivo);
var
    f: flor;//declaro una flor
    texto: text;//declaro un archivo de texto para listar los datos
begin
    reset(a);//abro el archivo en modo lectura
    assign(texto, 'flores.txt');//asigno el archivo de texto y lo llamo 'flores.txt'
    rewrite(texto);//abro el archivo de texto en modo escritura (si el archivo ya existe, se sobreescribe)
    while (not eof(a)) do begin
        read(a, f);//leo una flor del archivo a y la guardo en f
        //escribo los datos de la flor en el archivo de texto, uno por linea
        writeln(texto, 'Numero de especie: ', f.num);
        writeln(texto, 'Nombre cientifico: ', f.nombreCientifico);
        writeln(texto, 'Nombre vulgar: ', f.nombreVulgar);
        writeln(texto, 'Color: ', f.color);
        writeln(texto, 'Altura maxima que alcanza: ', f.alturaMaxima:2:2);
    end;
    close(texto);//cierro el archivo de texto
    close(a);//cierro el archivo
end;

//hago el programa principal
var
    a: archivo;//declaro el archivo de registros de flores
    opcion: integer;//declaro la variable opcion para el menu
    f: flor;//declaro una flor
begin
    assign(a, 'flores');//asigno el archivo de registros de flores y lo llamo 'flores'
    rewrite(a);//abro el archivo en modo escritura (si el archivo ya existe, se sobreescribe)
    cargarFlor(f);//cargo los datos de una flor
    while (f.nombreCientifico <> 'zzz') do begin
        write(a, f);//escribo la flor en el archivo
        cargarFlor(f);//cargo los datos de una flor
    end;
    //muestro el menu
    writeln('Ingrese la opcion deseada');
    writeln('1: Reportar en pantalla la cantidad total de especies y la especie de menor y de mayor altura a alcanzar');
    writeln('2: Listar todo el contenido del archivo de a una especie por linea');
    writeln('3: Modificar el nombre cientifico de la especie flores cargada como: Victoria amazonia a: Victoria amazonica');
    writeln('4: Añadir una o mas especies al final del archivo con sus datos obtenidos por teclado');
    writeln('5: Listar todo el contenido del archivo, en un archivo de texto llamado “flores.txt”');
    writeln('6: Salir');
    readln(opcion);//leo la opcion
    while (opcion <> 6) do begin
        case opcion of //case para llamar a los procedimientos segun la opcion elegida
            1: cantidadTotalEspecies(a);
            2: listarContenido(a);
            3: modificarNombreCientifico(a);
            4: agregarEspecies(a);
            5: listarContenidoEnArchivoTexto(a);
            6: break;
        end;
        //vuelvo a mostrar el menu y leo la opcion
        writeln('Ingrese la opcion deseada');
        writeln('1: Reportar en pantalla la cantidad total de especies y la especie de menor y de mayor altura a alcanzar');
        writeln('2: Listar todo el contenido del archivo de a una especie por linea');
        writeln('3: Modificar el nombre cientifico de la especie flores cargada como: Victoria amazonia a: Victoria amazonica');
        writeln('4: Añadir una o mas especies al final del archivo con sus datos obtenidos por teclado');
        writeln('5: Listar todo el contenido del archivo, en un archivo de texto llamado “flores.txt”');
        writeln('6: Salir');
        readln(opcion);
    end;
    close(a);//cierro el archivo
end.