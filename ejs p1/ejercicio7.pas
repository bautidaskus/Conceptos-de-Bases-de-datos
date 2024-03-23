//7. Realizar un programa con opciones para:
//a. Crear un archivo de registros no ordenados con la información
//correspondiente a los alumnos de la facultad de ingeniería y cargarlo con
//datos obtenidos a partir de un archivo de texto denominado “alumnos.txt”.
//Los registros deben contener DNI, legajo, nombre y apellido, dirección, año
//que cursa y fecha de nacimiento (longInt).
//b. Listar en pantalla toda la información de los alumnos cuyos nombres
//comiencen con un carácter proporcionado por el usuario.
//c. Listar en un archivo de texto denominado “alumnosAEgresar.txt” todos los
//registros del archivo de alumnos que cursen 5º año.
//d. Añadir uno o más alumnos al final del archivo con sus datos obtenidos por
//teclado.
//e. Modificar el año que cursa un alumno dado. Las búsquedas son por legajo
//del alumno.

program ejercicio7;
type
    alumno = record
        dni:longInt;
        legajo:integer;
        nombre:string;
        apellido:string;
        direccion:string;
        anio:integer;
        fechaNacimiento:longint;
    end;
    arch_alumnos = file of alumno;
    arch_texto = text;

procedure crearArchivoDeAlumnos(var archivo:arch_alumnos);
var
    a:alumno;
    texto:arch_texto;
begin
    assign(archivo, 'archivoDeAlumnos');
    rewrite(archivo);
    assign(texto, 'alumnos.txt');
    reset(texto);
    while not eof(texto) do begin
        readln(texto, a.dni);
        readln(texto, a.legajo);
        readln(texto, a.nombre);
        readln(texto, a.apellido);
        readln(texto, a.direccion);
        readln(texto, a.anio);
        readln(texto, a.fechaNacimiento);
        write(archivo, a);
    end;
    close(archivo);
    close(texto);
end;

procedure listarAlumnosPorNombre(var archivo:arch_alumnos);
var
    a:alumno;
    letra:char;
begin
    writeln('Ingrese la letra por la que comienza el nombre de los alumnos que desea listar');
    readln(letra);
    reset(archivo);
    while not eof(archivo) do begin
        read(archivo, a);
        if a.nombre[1] = letra then begin
            writeln('DNI: ', a.dni);
            writeln('Legajo: ', a.legajo);
            writeln('Nombre: ', a.nombre);
            writeln('Apellido: ', a.apellido);
            writeln('Direccion: ', a.direccion);
            writeln('Anio: ', a.anio);
            writeln('Fecha de nacimiento: ', a.fechaNacimiento);
        end;
    end;
    close(archivo);
end;

procedure listarAlumnosDeQuintoAnio(var archivo:arch_alumnos);
var
    a:alumno;
    texto:arch_texto;
begin
    assign(texto, 'alumnosAEgresar.txt');
    rewrite(texto);
    reset(archivo);
    while not eof(archivo) do begin
        read(archivo, a);
        if a.anio = 5 then begin
            writeln(texto, 'DNI: ', a.dni);
            writeln(texto, 'Legajo: ', a.legajo);
            writeln(texto, 'Nombre: ', a.nombre);
            writeln(texto, 'Apellido: ', a.apellido);
            writeln(texto, 'Direccion: ', a.direccion);
            writeln(texto, 'Anio: ', a.anio);
            writeln(texto, 'Fecha de nacimiento: ', a.fechaNacimiento);
        end;
    end;
    close(archivo);
    close(texto);
end;

procedure agregarAlumno(var archivo:arch_alumnos);
var
    a:alumno;
begin
    reset(archivo);
    seek(archivo, filesize(archivo));
    writeln('Ingrese el DNI del alumno');
    readln(a.dni);
    writeln('Ingrese el legajo del alumno');
    readln(a.legajo);
    writeln('Ingrese el nombre del alumno');
    readln(a.nombre);
    writeln('Ingrese el apellido del alumno');
    readln(a.apellido);
    writeln('Ingrese la direccion del alumno');
    readln(a.direccion);
    writeln('Ingrese el anio del alumno');
    readln(a.anio);
    writeln('Ingrese la fecha de nacimiento del alumno');
    readln(a.fechaNacimiento);
    write(archivo, a);
    close(archivo);
end;

procedure modificarAnio(var archivo:arch_alumnos);
var
    a:alumno;
    legajo:integer;
    anio:integer;
begin
    reset(archivo);
    writeln('Ingrese el legajo del alumno al que desea modificar el anio');
    readln(legajo);
    while not eof(archivo) do begin
        read(archivo, a);
        if a.legajo = legajo then begin
            writeln('Ingrese el nuevo anio del alumno');
            readln(anio);
            a.anio:=anio;
            seek(archivo, filepos(archivo)-1);
            write(archivo, a);
        end;
    end;
    close(archivo);
end;

var
    archivo:arch_alumnos;
    opcion:char;
begin
    repeat
        writeln('Ingrese la opcion que desea realizar');
        writeln('a. Crear un archivo de registros no ordenados con la informacion correspondiente a los alumnos de la facultad de ingenieria y cargarlo con datos obtenidos a partir de un archivo de texto denominado "alumnos.txt"');
        writeln('b. Listar en pantalla toda la informacion de los alumnos cuyos nombres comiencen con un caracter proporcionado por el usuario');
        writeln('c. Listar en un archivo de texto denominado "alumnosAEgresar.txt" todos los registros del archivo de alumnos que cursen 5to anio');
        writeln('d. Anadir uno o mas alumnos al final del archivo con sus datos obtenidos por teclado');
        writeln('e. Modificar el anio que cursa un alumno dado. Las busquedas son por legajo del alumno');
        writeln('f. Salir');
        readln(opcion);
        case opcion of
            'a': crearArchivoDeAlumnos(archivo);
            'b': listarAlumnosPorNombre(archivo);
            'c': listarAlumnosDeQuintoAnio(archivo);
            'd': agregarAlumno(archivo);
            'e': modificarAnio(archivo);
        end;
    until opcion = 'f';
end.
