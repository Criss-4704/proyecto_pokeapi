class Usuario {
  int? _idpokemon;
  String? _nombre;
  String? _genero;
  int? _nivel;
  int? _idtipo;


  //get
  int? get idpokemon => _idpokemon;
  String? get nombre => _nombre;

  //set vamos a darles valor
  set idpokemon(int? idpokemon){
    _idpokemon = idpokemon;
  }

  set nombre(String? nombre){
    _nombre = nombre;
  }

}