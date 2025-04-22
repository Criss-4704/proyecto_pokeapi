import 'package:mysql1/mysql1.dart';

class Database {
  static const String _host = 'localhost';
  static const int _port = 3306;
  static const String _user = 'root';
  static const String _nombreBBDD = 'pokeapi_app';


 static instalarBBDD() async {
    var settings = ConnectionSettings(
      host: _host, 
      port: _port,
      user: _user,
    );
    var conn = await MySqlConnection.connect(settings);
    try{
      await _crearBBDD(conn);
      await _crearTablaUsuarios(conn);
      await _crearTablaEquipo(conn);
    } catch(e){
      print(e);
    } finally {
      await conn.close();
    }
  }

  static Future<MySqlConnection> obtenerConexion() async {
    var settings = ConnectionSettings(
      host: _host,
      port: _port,
      user: _user,
      db: _nombreBBDD,
    );
    return await MySqlConnection.connect(settings);
  }

  static _crearBBDD(MySqlConnection conn) async {
    await conn.query('CREATE DATABASE IF NOT EXISTS $_nombreBBDD');
    await conn.query('USE $_nombreBBDD');
    print('Conectado a $_nombreBBDD');
  }

  static _crearTablaUsuarios(MySqlConnection conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(10) NOT NULL,
    pokeles INT DEFAULT 0,
    nivel INT
    )''');
  }

  static _crearTablaEquipo(MySqlConnection conn) async {
  await conn.query('''CREATE TABLE IF NOT EXISTS equipo (
    id_equipo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_pokemon1 INT,
    id_pokemon2 INT,
    id_pokemon3 INT,
    id_pokemon4 INT,
    id_pokemon5 INT,
    id_pokemon6 INT,
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
  )''');
}
}