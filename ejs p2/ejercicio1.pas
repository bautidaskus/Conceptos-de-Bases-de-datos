*/1. El área de recursos humanos de un ministerio administra el personal del mismo
distribuido en 10 direcciones generales.
Entre otras funciones, recibe periódicamente un archivo detalle de cada una de las
direcciones conteniendo información de las licencias solicitadas por el personal.
Cada archivo detalle contiene información que indica: código de empleado, la fecha y
la cantidad de días de licencia solicitadas. El archivo maestro tiene información de
cada empleado: código de empleado, nombre y apellido, fecha de nacimiento,
dirección, cantidad de hijos, teléfono, cantidad de días que le corresponden de
vacaciones en ese periodo. Tanto el maestro como los detalles están ordenados por
código de empleado. Escriba el programa principal con la declaración de tipos
necesaria y realice un proceso que reciba los detalles y actualice el archivo maestro
con la información proveniente de los archivos detalles. Se debe actualizar la cantidad
de días que le restan de vacaciones. Si el empleado tiene menos días de los que
solicita deberá informarse en un archivo de texto indicando: código de empleado,
nombre y apellido, cantidad de días que tiene y cantidad de días que solicita.*/

program ejercicio1;
type
    // Definir los tipos de registros necesarios
    empleado = record
        codigo: integer;
        nombre: string[20];
        apellido: string[30];
        fechaNacimiento: string[12];
        direccion: string[50];
        cantidadHijos: integer;
        telefono: string[15];
        cantidadDiasVacaciones: integer;
    end;
    detalle = record
        codigo: integer;
        fecha: string;
        cantidadDias: integer;
    end;
    // Definir los tipos de archivos necesarios
    archivoMaestro = file of empleado;
    archivoDetalle = file of detalle;
    adet = array [1..10] of archivoDetalle

    procedure leer(var maestro: archivoMaestro; var detalles: adet);
    var
        i: integer;
        regMaestro: empleado;
        regDetalle: detalle;
    begin
    end;

    procedure minimo(var det: adet; var rdet:ardet;var min:producto);
        Var
            posMin :int
        Begin
            posMin:=1;
            min := rdet[1];
            for i:=2 to 3 do
                begin
        if(rdet[i].codigo < min.codigo)then
        begin 
        min:= rdet[i];
        posMin:=i;
        end;
        end;
        leer(det[posMin],rdet[posMin]); 
        end;


    var
        maestro: archivoMaestro;
        detalles: adet;
        regMaestro: empleado;
        regDetalle: detalle;
        texto: Text;
    
    begin
    
    
    end.
