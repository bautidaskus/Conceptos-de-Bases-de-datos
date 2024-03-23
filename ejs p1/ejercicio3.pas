program CreateDinosaurFile;

uses
    SysUtils;//agrego la libreria SysUtils para poder usar las funciones de manejo de archivos

var
    DinosaurFile: TextFile;//declaro la variable DinosaurFile de tipo TextFile, que es el tipo de archivo de texto en pascal
    DinosaurName: string; //declaro la variable DinosaurName de tipo string

begin
//comento que hacen cada linea
    Assign(DinosaurFile, 'dinosaur.txt');//en pascal es Assign y no AssignFile
    Rewrite(DinosaurFile); //abre el archivo para escritura, si ya existe lo sobreescribe

    repeat
        Write('Enter a dinosaur name (or "zzz" to finish): ');
        Readln(DinosaurName);//leo el nombre del dinosaurio

        if DinosaurName <> 'zzz' then //si el nombre del dinosaurio es distinto de 'zzz' lo escribo en el archivo
            Writeln(DinosaurFile, DinosaurName);//escribo el nombre del dinosaurio en el archivo
    until DinosaurName = 'zzz';

    Close(DinosaurFile);// es Close y no CloseFile
end.