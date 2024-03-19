program ejercicio2;
//2. Desarrollar un programa que permita la apertura de un archivo de números enteros no ordenados. 
//La información del archivo corresponde a la cantidad de votante de cada ciudad de la provincia de 
//buenos aires en una elección presidencial. Recorriendo el archivo una única vez, 
//informe por pantalla la cantidad mínima y máxima de votantes. Además durante el recorrido, 
//el programa deberá listar el contenido del archivo en pantalla. El nombre del archivo a procesar debe ser proporcionado por el 
//usuario. 

//declaro las variables necesarias
var
  archivo: file of integer;
  nombre: string;
  votos, min, max: integer;

begin
  //hago el programa
  //corrijo los errores de compilacion

    writeln('Ingrese el nombre del archivo a procesar');
    readln(nombre);
    assign(archivo, nombre);
    reset(archivo);
    read(archivo, votos);
    min:= votos;
    max:= votos;
    while (not eof(archivo)) do
    begin;
      writeln(votos);
      if votos < min then
        min:= votos;
      if votos > max then
        max:= votos;
      read(archivo, votos);
    end;
    writeln('El minimo de votos es: ', min);
    writeln('El maximo de votos es: ', max);
    close(archivo);
    readln;
end. 

