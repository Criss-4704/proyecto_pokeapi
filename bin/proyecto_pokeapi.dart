import 'dart:io';
import 'database.dart';
import 'menus.dart';

main() async { //async= sirve para usar el await

  print('Vamos a crear la base de datos...');
  await Database.instalarBBDD();

  String opcion = Menus.principal();

  switch (opcion) {
    case '1':

      String? nombreUsuario = await Menus.inicioSesion();

      if (nombreUsuario != null) {
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
            await Menus.juegoQuizz(nombreUsuario);
            break;
          case '2':
            print('Este minijuego está en desarrollo. Pronto estará disponible.');
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
