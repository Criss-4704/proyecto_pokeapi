import 'dart:io';
import 'usuario.dart';
import 'database.dart';

class Menus {
  static String principal(){
    String? opcion;

    do {
      print('Bienvenido a pokeke, el videojuego de pokemon. Lo primero de todo va a ser iniciar sesión o en caso de que no tengas cuenta vamos a crearte una.');

      stdout.writeln("""Selecciona una opcion:
      ------Menu Sesion------
      1. Iniciar sesion
      2. Registrarse
      3. Salir""");
      opcion = stdin.readLineSync() ?? 'error';
    } while (opcion != "1" && opcion != "2" && opcion != "3");

    return opcion;
  }

  static Future<String?> inicioSesion() async {
    String? nombreUsuario;
    var existeUsuario = false;
    do{
      stdout.write("Dime tu nombre de usuario: ");
      String nombre = stdin.readLineSync() ?? 'error';

      stdout.write("Dime tu contraseña: ");
      String contrasenia = stdin.readLineSync() ?? 'error';

      existeUsuario = await Usuario.verificarUsuario(nombre,contrasenia);

      if (existeUsuario) {
      nombreUsuario = nombre;
    }
    }while (existeUsuario == false);
    return nombreUsuario;
  }

  static registro() async {
    bool creado = false;
    do {
      creado = false;
      stdout.writeln("Introduce el nombre con el que quieres registrarte");
      String nombre = stdin.readLineSync() ?? 'error';
      stdout.writeln("Ahora introduce la que será tu contraseña");
      String password = stdin.readLineSync() ?? 'error';
      bool nombreExiste = await Usuario.comprobarSiExiste(nombre);

      if (nombreExiste) {
        stdout.writeln("El nombre ya existe, prueba con otro");
      } else {
        Usuario usuario = Usuario();
        usuario.user = nombre;
        usuario.password = password;
        creado = await usuario.registrarUsuario();
      }
    } while (creado == false);
  }

  static juegoQuizz(String nombreUsuario) async{
    int correcta = 0;
    stdout.writeln('Bienvenido al modo Quizz, aqui disfrutaras de 5 preguntas sobre pokemon. Por cada pregunta acertada ganaras 500 pokeles, que son la moneda que usaras durante todo el videojuego modo historia. ¡Mucha suerte!');

    stdout.writeln('1. Cual de estos ataques es de tipo planta');
    stdout.writeln('------------------------------------------');
    stdout.writeln('A.Ataque rapido');
    stdout.writeln('B.Cascada');
    stdout.writeln('C.Resplandor');
    stdout.writeln('D.Látigo Cepa');
    print("");
    stdout.write("Elige la respuesta correcta: ");
    String respuesta1 = stdin.readLineSync() ?? 'error';

    if(respuesta1 == 'd' || respuesta1 == 'D'){
      correcta++;
      print('¡Respuesta correcta!');
    }else{
      print('¡Respuesta incorrecta!. La respuesta correcta era D.Látigo Cepa');
    }
    print("");
    stdout.writeln('2. ¿Cual de estos pokemon es de tipo fuego?');
    stdout.writeln('----------------------------------------');
    stdout.writeln('A.Weedle');
    stdout.writeln('B.Rapidash');
    stdout.writeln('C.Arbok');
    stdout.writeln('D.Wartortle');
    print("");
    stdout.write("Elige la respuesta correcta: ");
    String respuesta2 = stdin.readLineSync() ?? 'error';

    if(respuesta2 == 'b' || respuesta2 == 'B'){
      correcta++;
      print('¡Respuesta correcta!');
    }else{
      print('¡Respuesta incorrecta!. La respuesta correcta era B.Rapidash');
    }
    print("");
    stdout.writeln('3. Cual de estos ataques es de tipo veneno');
    stdout.writeln('----------------------------------------');
    stdout.writeln('A.Bomba Lodo');
    stdout.writeln('B.Ferropuño Doble');
    stdout.writeln('C.Juego Sucio');
    stdout.writeln('D.Acoso');
    print("");
    stdout.write("Elige la respuesta correcta: ");
    String respuesta3 = stdin.readLineSync() ?? 'error';

    if(respuesta3 == 'a' || respuesta3 == 'A'){
      correcta++;
      print('¡Respuesta correcta!');
    }else{
      print('¡Respuesta incorrecta!. La respuesta correcta era A.Bomba Lodo');
    }
    print("");
    stdout.writeln('4. Cual de estas pokeballs funciona mejor con pokemons de tipo agua o bicho');
    stdout.writeln('----------------------------------------');
    stdout.writeln('A.Nido Ball');
    stdout.writeln('B.Malla Ball');
    stdout.writeln('C.Ocaso Ball');
    stdout.writeln('D.Super Ball');
    print("");
    stdout.write("Elige la respuesta correcta: ");
    String respuesta4 = stdin.readLineSync() ?? 'error';

    if(respuesta4 == 'b' || respuesta4 == 'B'){
      correcta++;
      print('¡Respuesta correcta!');
    }else{
      print('¡Respuesta incorrecta!. La respuesta correcta era B.Malla Ball');
    }
    print("");
    stdout.writeln('5. Cual de estos pokemon tiene dos tipos');
    stdout.writeln('----------------------------------------');
    stdout.writeln('A.Blastoise');
    stdout.writeln('B.Raticate');
    stdout.writeln('C.Butterfree');
    stdout.writeln('D.Nidoran');
    print("");
    stdout.write("Elige la respuesta correcta: ");
    String respuesta5 = stdin.readLineSync() ?? 'error';

    if(respuesta5 == 'C' || respuesta5 == 'c'){
      correcta++;
      print('¡Respuesta correcta!');
    }else{
      print('¡Respuesta incorrecta!. La respuesta correcta era C.Butterfree');
    }
    print("");

    int dinero = correcta * 500;
    stdout.writeln('¡Enhorabuena!. Has terminado el quizz, has tenido $correcta preguntas bien asique en total has conseguido $dinero pokeles');

    try{
      var conn = await Database.obtenerConexion();

      await conn.query(
      'UPDATE usuarios SET pokeles = pokeles + ? WHERE nombre = ?',
      [dinero, nombreUsuario]);

     stdout.writeln("Pokeles actualizados correctamente.");
  
    }catch(e){
      print(e);
    }

    exit(0);
  }
}