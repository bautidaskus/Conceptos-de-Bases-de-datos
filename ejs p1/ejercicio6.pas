//6. Realizar un programa que permita:
//a. Crear un archivo binario a partir de la información almacenada en un
//archivo de texto. El nombre del archivo de texto es: “libros.txt”
//b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder
//agregar un libro y modificar uno existente. Las búsquedas se realizan por
//ISBN.
//NOTA: La información en el archivo de texto consiste en: ISBN (nro de 13 dígitos),
//título del libro, género, editorial y año de edición. Cada libro se almacena en tres líneas
//en el archivo de texto. La primera línea contendrá la información de ISBN y título del
//libro, la segunda línea almacenará el año de edición y la editorial y en la tercera línea el
//género del libro. (Analice otras posibles formas de representar la información en el txt)

program ejercicio6;
type
    //Defino el registro Libro
    Libro=record
        ISBN:LongInt;
        titulo:string;
        genero:string;
        editorial:string;
        anio_edicion:integer;
    end;
arch_texto=Text;//Defino el tipo arch_texto como Text
arch_libros=File of Libro;//Defino el tipo arch_libros como File of Libro

//procedimiento para agregar un libro al archivo binario
procedure agregar_libro(var archivo_binario:arch_libros);
var
    l:Libro;
begin
    reset(archivo_binario);//Abro el archivo binario en modo lectura
    seek(archivo_binario,filesize(archivo_binario));//Me posiciono al final del archivo binario
    writeln('Ingrese el ISBN del libro: ');
    readln(l.ISBN);
    writeln('Ingrese el titulo del libro: ');
    readln(l.titulo);
    writeln('Ingrese el genero del libro: ');
    readln(l.genero);
    writeln('Ingrese la editorial del libro: ');
    readln(l.editorial);
    writeln('Ingrese el anio de edicion del libro: ');
    readln(l.anio_edicion);
    write(archivo_binario,l);//Escribo el libro en el archivo binario
    close(archivo_binario);//Cierro el archivo binario
end;

//procedimiento para modificar un libro en el archivo binario
procedure modificar_libro(var archivo_binario:arch_libros);
var
    l:Libro;
    ISBN:integer;//Variable para buscar el libro por ISBN
    encontrado:boolean;//Variable para saber si se encontro el libro
begin
    reset(archivo_binario);//Abro el archivo binario en modo lectura
    encontrado:=false;//Inicializo la variable encontrado en false
    writeln('Ingrese el ISBN del libro que desea modificar: ');
    readln(ISBN);//Leo el ISBN del libro que se desea modificar
    while not eof(archivo_binario) and (not encontrado) do//Mientras no sea el final del archivo binario y no se haya encontrado el libro
    begin
        read(archivo_binario,l);//Leo el libro del archivo binario
        if (l.ISBN=ISBN) then//Si el ISBN del libro es igual al ISBN ingresado
        begin
            encontrado:=true;//Cambio la variable encontrado a true para salir del bucle
            writeln('Ingrese el nuevo ISBN del libro: ');
            readln(l.ISBN);
            writeln('Ingrese el nuevo titulo del libro: ');
            readln(l.titulo);
            writeln('Ingrese el nuevo genero del libro: ');
            readln(l.genero);
            writeln('Ingrese la nueva editorial del libro: ');
            readln(l.editorial);
            writeln('Ingrese el nuevo año de edicion del libro: ');
            readln(l.anio_edicion);
            seek(archivo_binario,filepos(archivo_binario)-1);//Me posiciono en el libro que quiero modificar
            write(archivo_binario,l);//Escribo el libro modificado en el archivo binario
        end;
    end;
    if not encontrado then//Si no se encontro el libro
    begin
        writeln('El libro no se encuentra en el archivo');
    end;
    close(archivo_binario);//Cierro el archivo binario
end;

//proceso para imprimir el archivo binario
procedure imprimir_archivo_binario(var archivo_binario:arch_libros);
var
    l:Libro;
begin
    reset(archivo_binario);//Abro el archivo binario en modo lectura
    while not eof(archivo_binario) do//Mientras no sea el final del archivo binario
    begin
        read(archivo_binario,l);//Leo el libro del archivo binario
        writeln('ISBN: ',l.ISBN);
        writeln('Titulo: ',l.titulo);
        writeln('Genero: ',l.genero);
        writeln('Editorial: ',l.editorial);
        writeln('Anio de edicion: ',l.anio_edicion);
    end;
    close(archivo_binario);//Cierro el archivo binario
end;

//procedimiento para imprimir el archivo de texto
procedure imprimir_archivo_texto(var archivo_texto:arch_texto);
var
    ISBN:LongInt;
    titulo:string;
    genero:string;
    editorial:string;
    anio_edicion:integer;
begin
    reset(archivo_texto);//Abro el archivo de texto en modo lectura
    while not eof(archivo_texto) do//Mientras no sea el final del archivo de texto
    begin
        //la informacion en el archivo de texto se almacena en tres lineas en el siguiente orden:
        //1. ISBN y titulo, 2. año de edicion y editorial, 3. genero
        ReadLn(archivo_texto,ISBN,titulo);//Leo la primera linea del archivo de texto
        ReadLn(archivo_texto,anio_edicion,editorial);//Leo la segunda linea del archivo de texto
        ReadLn(archivo_texto,genero);//Leo la tercera linea del archivo de texto
        //Imprimo la informacion del archivo de texto
        writeln('ISBN: ',ISBN);
        writeln('Titulo: ',titulo);
        writeln('Genero: ',genero);
        writeln('Editorial: ',editorial);
        writeln('Anio de edicion: ',anio_edicion);
    end;
    close(archivo_texto);//Cierro el archivo de texto
end;

//procedimiento para pasar la informacion del archivo de texto al archivo binario
procedure pasar_archivo_texto_a_binario(var archivo_texto:arch_texto;var archivo_binario:arch_libros);
var
    l:Libro;
begin
    assign(archivo_texto,'libros.txt');//Asigno el archivo de texto a la variable archivo_texto
    reset(archivo_texto);//Abro el archivo de texto en modo lectura
    imprimir_archivo_texto(archivo_texto);//Imprimo el archivo de texto
    assign(archivo_binario,'libros');//Asigno el archivo binario a la variable archivo_binario
    rewrite(archivo_binario);//Abro el archivo binario en modo escritura, si no existe lo crea y si existe lo sobreescribe
    while (not eof(archivo_texto)) do//Mientras no sea el final del archivo de texto
    begin
        //la informacion en el archivo de texto se almacena en tres lineas en el siguiente orden:
        //1. ISBN y titulo, 2. año de edicion y editorial, 3. genero
        ReadLn(archivo_texto,l.ISBN,l.titulo);//Leo la primera linea del archivo de texto
        ReadLn(archivo_texto,l.anio_edicion,l.editorial);//Leo la segunda linea del archivo de texto
        ReadLn(archivo_texto,l.genero);//Leo la tercera linea del archivo de texto
        //Escribo la informacion en el archivo binario
        Write(archivo_binario,l);   
    end;
    close(archivo_texto);//Cierro el archivo de texto
    close(archivo_binario);//Cierro el archivo binario
end;


var
    archivo_texto:arch_texto;//Archivo de texto
    archivo_binario:arch_libros;//Archivo binario de libros
    opcion:char;

begin
    pasar_archivo_texto_a_binario(archivo_texto,archivo_binario);//Paso la informacion del archivo de texto al archivo binario
    //hago un menu para elegir la opcion
    repeat
        writeln('a. Agregar un libro al archivo binario');
        writeln('b. Modificar un libro del archivo binario');
        writeln('c. Imprimir el archivo binario');
        writeln('d. Salir');
        readln(opcion);
        case opcion of
            'a':begin
                agregar_libro(archivo_binario);
            end;
            'b':begin
                modificar_libro(archivo_binario);
            end;
            'c':begin
                imprimir_archivo_binario(archivo_binario);
            end;
            'd':begin
                writeln('Fin del programa');
            end;
            else
                writeln('Opcion incorrecta');
        end;
    until opcion='d';
end.

//cuando lo ejecuto, me sale un error al querer ingresar al archivo de texto, no se porque
