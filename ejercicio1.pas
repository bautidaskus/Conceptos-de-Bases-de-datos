Program ejercicio1;
Var //escribo comentarios en cada linea para que se entienda que hace cada cosa
    arch:Text; //declaro una variable de tipo archivo de texto
    material,nombre:String; //declaro dos variables de tipo string
Begin
    Write('Nombre del archivo:'); //pido el nombre del archivo
    ReadLn(nombre); //leo el nombre del archivo
    Assign(arch,nombre); //asigno el nombre del archivo a la variable arch
    Rewrite(arch); //abro el archivo para escribir
    repeat //repite el proceso hasta que el material sea igual a cemento
      Write('Nombre del material:'); //pido el nombre del material
      ReadLn(material); //leo el nombre del material
      WriteLn(arch,material); //escribo el nombre del material en el archivo
    until material='cemento';//repite el proceso hasta que el material sea igual a cemento
    Close(arch);//cierro el archivo
end.