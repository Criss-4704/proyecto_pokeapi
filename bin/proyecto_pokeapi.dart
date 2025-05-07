import 'dart:io';
import 'database.dart';
import 'menus.dart';

main() async { //async= sirve para usar el await

  print('Vamos a crear la base de datos...');
  await Database.instalarBBDD();

  String opcion = Menus.principal(); //Menu inicio sesion o registro

  switch (opcion) {
    case '1':

      String? nombreUsuario = await Menus.inicioSesion();

      if (nombreUsuario != null) { //si el usuario ha iniciado sesion con exito
        stdout.writeln("Dirigiendote a la sección del juego.");

        print('Bienvenido a la selección de minijuego, aqui elegiras que quieres jugar.');

        print('------Menu Minijuegos------');
        print('1. Quizz');
        print('2. Modo Estudio');
        print('3. Salir');

        stdout.write("Elige un minijuego del menu: ");
        String minijuego = stdin.readLineSync() ?? 'error';

        switch (minijuego) {
          case '1':
            await Menus.juegoQuizz(nombreUsuario); //Accedemos al metodo de menus para jugar al quizz guardando el nombre de usuario para poder añadir su calificacion a la base de datos
            break;
          case '2':
            await Menus.modoEstudio();
            break;
          case '3':
            exit(0);
          default:
            stdout.writeln("Debes elegir un numero del 1 al 3. Prueba de nuevo.");
        }
      } else {
        stdout.writeln("Login incorrecto");
      }
      break;

    case '2':
      Menus.registro();
      break;

    case '3':
      exit(0);

    default:
      stdout.writeln("Debes elegir un numero del 1 al 3. Prueba de nuevo.");
  }
}
