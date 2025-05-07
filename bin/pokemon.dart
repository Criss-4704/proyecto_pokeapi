import "dart:convert";
import "package:http/http.dart" as http;
import "dart:io";

class Pokemon {
  String? nombre;
  List<String> tipos = []; //creamos una lista para los tipos ya que pueden tener dos
  String? habitat;
  String? generacion;

  // Constructor vacío
  Pokemon();
  // Constructor que se usa para inicializar el Pokémon con los datos de la PokeAPI
  Pokemon.fromAPI(datos) {
    nombre = datos['name'];
    
    // Tipos del Pokémon
    for (var tipo in datos['types']) {
      tipos.add(tipo['type']['name']);
    }

    // Obtener el hábitat desde la especie (requiere otra solicitud)
    obtenerEspecie(datos['species']['url']);
  }

  // Método para obtener los datos de la especie: hábitat y generación, necesitamos crear otro metodo porq la especie y el nombre estan en partes distintas en la api
  obtenerEspecie(String urlEspecie) async {
    Uri url = Uri.parse(urlEspecie);
    var respuesta = await http.get(url);

    try {
      if (respuesta.statusCode == 200) { //si la respuesta fue exitosa
        var body = json.decode(respuesta.body);

        // Si tiene habitat que me diga el nombre, sino que ponga desconocido.
        habitat = body['habitat'] != null ? body['habitat']['name'] : 'Desconocido';

        // Generación como String (ej: "Generación III")
        generacion = body['generation']['name']; // ej: generation-iii
        
      } else {
        throw ("No se pudo obtener la información de la especie");
      }
    } catch (e) {
      stdout.writeln(e);
    }
  }

  // Método para obtener un Pokémon desde la PokeAPI usando su nombre
  Future<Pokemon> obtenerPokemon(String nombre) async {
    Uri url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$nombre");
    var respuesta = await http.get(url);

    try {
      if (respuesta.statusCode == 200) {
        var body = json.decode(respuesta.body);
        Pokemon pokemon = Pokemon.fromAPI(body);
        return pokemon;
      } else {
        throw ("¡El Pokémon que buscas no existe!");
      }
    } catch (e) {
      stdout.writeln(e);
      return Pokemon(); // Retorna un Pokémon vacío en caso de error
    }
  }

  // Método para imprimir la información del Pokémon
  static void imprimirInfo(Pokemon pokemon) {
    stdout.writeln("Nombre: ${pokemon.nombre}");
    stdout.writeln("Tipos: ${pokemon.tipos.join(', ')}");
    stdout.writeln("Hábitat: ${pokemon.habitat}");
    stdout.writeln("Generación: ${pokemon.generacion}");
  }

  static Future<Pokemon?> obtenerPokemonEstudio(String nombre) async {
    Uri url = Uri.parse("https://pokeapi.co/api/v2/pokemon/$nombre");
    var respuesta = await http.get(url);

    if (respuesta.statusCode == 200) {
      var datos = json.decode(respuesta.body);
      Pokemon p = Pokemon.fromAPI(datos);
      // Esperamos brevemente para que el async de especie se complete
      await Future.delayed(Duration(seconds: 1));
      return p;
    } else {
      return null;
    }
  }

}
