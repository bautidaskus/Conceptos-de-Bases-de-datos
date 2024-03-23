program ejercicio2;
//2. Desarrollar un programa que permita la apertura de un archivo de números enteros no ordenados. 
//La información del archivo corresponde a la cantidad de votante de cada ciudad de la provincia de 
//buenos aires en una elección presidencial. Recorriendo el archivo una única vez, 
//informe por pantalla la cantidad mínima y máxima de votantes. Además durante el recorrido, 
//el programa deberá listar el contenido del archivo en pantalla. El nombre del archivo a procesar debe ser proporcionado por el 
//usuario. 

//declaro las variables necesarias
var
  archivo:text;
  nombre: string;
  votos, min, max: integer;

begin
//pido el nombre del archivo
  writeln('Ingrese el nombre del archivo');
  readln(nombre);
//abro el archivo
  assign(archivo, nombre);
  reset(archivo);
//inicializo las variables
  min:=9999;
  max:=0;
//recorro el archivo
  while not eof(archivo) do begin
    read(archivo, votos);
    writeln(votos);
    if votos < min then
      min:=votos;
    if votos > max then
      max:=votos;
  end;
//informo los resultados
  writeln('El minimo de votos es: ', min);
  writeln('El maximo de votos es: ', max);
//cierro el archivo
  close(archivo);
  readln;

end. 

