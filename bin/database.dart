import 'package:mysql1/mysql1.dart';

class Database {
  static const String _host = 'localhost';
  static const int _port = 3306;
  static const String _user = 'root';
  static const String _nombreBBDD = 'pokeapi_app';

  static instalarBBDD() async { 
    var settings = ConnectionSettings( //ajustes para conectar a la base de datos con las variables que hemos creado
      host: _host, 
      port: _port,
      user: _user,
    );
    var conn = await MySqlConnection.connect(settings);
    try { //creamos la base de datos y las tablas con los metodos
      await _crearBBDD(conn);
      await _crearTablaUsuarios(conn);
      await _crearTablaTipo(conn);
      await _crearTablaPokemon(conn);
      await _crearTablaObjeto(conn);
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }

  static Future<MySqlConnection> obtenerConexion() async { //Obtenemos conexion a la base de datos
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
      password VARCHAR(100) NOT NULL,
      pokeles INT DEFAULT 0,
      nivel INT DEFAULT 1
    )''');
  }

  static _crearTablaTipo(MySqlConnection conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS tipo (
      id_tipo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      nombre VARCHAR(50) NOT NULL
    )''');
  }

  static _crearTablaPokemon(MySqlConnection conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS pokemon (
      id_pokemon INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      nombre VARCHAR(50) NOT NULL,
      genero VARCHAR(50) NOT NULL,
      nivel INT,
      id_tipo1 INT,
      id_tipo2 INT,
      id_duenio INT,
      FOREIGN KEY (id_duenio) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
      FOREIGN KEY (id_tipo1) REFERENCES tipo(id_tipo) ON DELETE CASCADE,
      FOREIGN KEY (id_tipo2) REFERENCES tipo(id_tipo) ON DELETE CASCADE
    )''');
  }

  static _crearTablaObjeto(MySqlConnection conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS objetos (
      id_objeto INT AUTO_INCREMENT PRIMARY KEY,
      nombre VARCHAR(50) NOT NULL,
      descripcion TEXT,
      precio INT NOT NULL
    )''');
  }
}
