import "dart:io";
import "database.dart";

class Usuario {
  String _user = "usuario1";
  String _password = "1234";


  //get
  String get user => _user;
  String get password => _password; 

  //set vamos a darles valor
  set user(String user){
    _user = user;
  }
  set password(String password){
    _password = password;
  }

  static Future<bool> comprobarSiExiste(String nombre) async {
    bool existe = true;
    var conn;
    try {
      conn = await Database.obtenerConexion();
      var registros =
          await conn.query("SELECT * FROM usuarios WHERE nombre = ?", [nombre]);
      if (registros.length == 0) {
        existe = false;
      }
    } catch (e) {
      print(e);
    } finally {
      conn.close();
    }
    return existe;
  }

  Future<bool> registrarUsuario() async {
    bool registrado = false;
    var conn;
    try {
      conn = await Database.obtenerConexion();
      await conn.query("INSERT INTO usuarios (nombre,password) VALUES(?,?)",
          [user, password]);
      stdout.writeln("Usuario insertado con éxito");
      registrado = true;
    } catch (e) {
      print(e);
    } finally {
      conn.close();
    }
    return registrado;
  }

  static Future<bool> verificarUsuario(String nombre, String password) async {
  bool verificado = false;
  var conn;
  try {
    conn = await Database.obtenerConexion();
    var registros = await conn.query("SELECT * FROM usuarios WHERE nombre = ? AND password = ?", [nombre, password]);

    if (registros.isNotEmpty) {
      stdout.writeln("Inicio de sesión exitoso.");
      verificado = true;
    } else {
      stdout.writeln("Usuario o contraseña incorrectos.");
    }
  } catch (e) {
    print(e);
  } finally {
    conn.close();
  }
  return verificado;
  } 
}