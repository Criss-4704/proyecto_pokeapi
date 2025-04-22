class Usuario {
  int? _idpokemon;
  String? _nombre;
  String? _genero;
  int? _nivel;
  int? _idtipo;


  //get
  int? get idpokemon => _idpokemon;

  //set vamos a darles valor
  set idpokemon(int? idpokemon){
    _idpokemon = idpokemon;
  }

}