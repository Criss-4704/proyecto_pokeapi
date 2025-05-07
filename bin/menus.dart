import 'dart:io';
import 'usuario.dart';
import 'database.dart';
import 'pokemon.dart';

class Menus {
  static String principal() { //menu para elegir inicio sesion o registro
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

  static Future<String?> inicioSesion() async { //menu para iniciar sesion
    String? nombreUsuario;
    var existeUsuario = false;
    do {
      stdout.write("Dime tu nombre de usuario: ");
      String nombre = stdin.readLineSync() ?? 'error';

      stdout.write("Dime tu contraseña: ");
      String contrasenia = stdin.readLineSync() ?? 'error';

      existeUsuario = await Usuario.verificarUsuario(nombre, contrasenia);

      if (existeUsuario) {
        nombreUsuario = nombre;
      }
    } while (existeUsuario == false);
    return nombreUsuario;
  }

  static Future<void> registro() async { //menu para registrarme
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

  static Future<void> juegoQuiz(String nombreUsuario) async { //metodo para jugar al quiz
    int correcta = 0;
    stdout.writeln('Bienvenido al modo Quizz, aqui disfrutaras de 5 preguntas sobre pokemon. Por cada pregunta acertada ganaras 500 pokeles, que son la moneda que usaras durante todo el videojuego. ¡Mucha suerte!');
    stdout.writeln(' ');
    //Empezamos quiz
    stdout.writeln('1. Cual de estos pokemons es de V generacion');
    stdout.writeln('------------------------------------------');
    stdout.writeln('A.Cutiefly');
    stdout.writeln('B.Whismur');
    stdout.writeln('C.Buizel');
    stdout.writeln('D.Lilligant');
    print("");
    stdout.write("Elige la respuesta correcta: ");
    String respuesta1 = stdin.readLineSync() ?? 'error';

    if(respuesta1 == 'd' || respuesta1 == 'D'){
      correcta++;
      print('¡Respuesta correcta!');
    }else{
      print('¡Respuesta incorrecta!. La respuesta correcta era D.Lilligant');
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
    stdout.writeln('3. Cual de estos pokemons es de tipo veneno y bicho');
    stdout.writeln('----------------------------------------');
    stdout.writeln('A.Skorupi');
    stdout.writeln('B.Parasect');
    stdout.writeln('C.Ivysaur');
    stdout.writeln('D.Toxapex');
    print("");
    stdout.write("Elige la respuesta correcta: ");
    String respuesta3 = stdin.readLineSync() ?? 'error';

    if(respuesta3 == 'a' || respuesta3 == 'A'){
      correcta++;
      print('¡Respuesta correcta!');
    }else{
      print('¡Respuesta incorrecta!. La respuesta correcta era A.Skorupi');
    }
    print("");
    stdout.writeln('4. Cual de estos pokemons vive en forest (bosque)');
    stdout.writeln('----------------------------------------');
    stdout.writeln('A.Golbat');
    stdout.writeln('B.Pikachu');
    stdout.writeln('C.Chansey');
    stdout.writeln('D.Luvdisc');
    print("");
    stdout.write("Elige la respuesta correcta: ");
    String respuesta4 = stdin.readLineSync() ?? 'error';

    if(respuesta4 == 'b' || respuesta4 == 'B'){
      correcta++;
      print('¡Respuesta correcta!');
    }else{
      print('¡Respuesta incorrecta!. La respuesta correcta era B.Pikachu');
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

    //Final del quiz
    int dinero = correcta * 500;
    stdout.writeln('¡Enhorabuena!. Has terminado el quizz, has tenido $correcta preguntas bien asique en total has conseguido $dinero pokeles');

    try { //añadimos los pokeles de las preguntas acertadas a la base de datos
      var conn = await Database.obtenerConexion();
      await conn.query(
        'UPDATE usuarios SET pokeles = pokeles + ? WHERE nombre = ?',
        [dinero, nombreUsuario],
      );
      stdout.writeln("Pokeles actualizados correctamente.");
    } catch (e) {
      print(e);
    }

    exit(0);
  }

  static Future<void> modoEstudio() async {
    stdout.writeln("Bienvenido al modo estudio. Aquí puedes aprender sobre cualquier Pokémon.");

    bool salir = false;

    // Creamos un bucle que se repite hasta que salir sea true
    while (salir == false) {
      // Pedimos el nombre del Pokémon al usuario
      stdout.write("Escribe el nombre de un Pokémon (o escribe 'salir' para terminar): ");
      String nombre = stdin.readLineSync()?.toLowerCase().trim() ?? '';

      // Si el usuario escribe 'salir', terminamos el bucle
      if (nombre == 'salir') {
        stdout.writeln("Saliendo del modo estudio...");
        salir = true;
        break;
      }

      // Validación de nombre vacío
      if (nombre.isEmpty) {
        stdout.writeln("No has introducido un nombre válido.");
      } else {
        // Intentamos obtener los datos del Pokémon
        try {
          var pokemon = await Pokemon.obtenerPokemonEstudio(nombre);

          // Si se encuentra el Pokémon, mostramos la información
          if (pokemon != null && pokemon.nombre != null) {
            stdout.writeln("\nInformación del Pokémon:");
            stdout.writeln("--------------------------");
            stdout.writeln("Nombre: ${pokemon.nombre!.toUpperCase()}");
            stdout.writeln("Tipos: ${pokemon.tipos.join(", ")}");
            stdout.writeln("Hábitat: ${pokemon.habitat ?? 'Desconocido'}");
            stdout.writeln("Generación: ${pokemon.generacion ?? 'Desconocida'}");
            stdout.writeln("--------------------------");
          } else {
            stdout.writeln("No se encontró el Pokémon '$nombre' en la PokeAPI.");
          }
        } catch (e) {
          stdout.writeln("Ocurrió un error al obtener los datos del Pokémon.");
        }
      }

      // Menú para repetir o salir
      stdout.writeln("\n¿Qué quieres hacer ahora?");
      stdout.writeln("-------------------------");
      stdout.writeln("1. Buscar otro Pokémon");
      stdout.writeln("2. Salir");
      stdout.write("Selecciona una opción: ");

      String opcion;

      // Validación para que solo acepte "1" o "2"
      do {
        opcion = stdin.readLineSync()?.trim() ?? '';
        if (opcion != '1' && opcion != '2') {
          stdout.writeln("Opción no válida. Por favor, selecciona '1' o '2'.");
          stdout.write("Selecciona una opción: ");
        }
      } while (opcion != '1' && opcion != '2');

      // Si elige '2', salir es true y se rompe el bucle
      if (opcion == '2') {
        stdout.writeln("Saliendo del modo estudio...");
        salir = true;
      }

    }
  }
}
