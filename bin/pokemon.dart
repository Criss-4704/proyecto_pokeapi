class Usuario {
  int? _idpokemon;
  String? _nombre;
  String? _genero;
  int? _nivel;
  int? _idtipo1;
  int? _idtipo2;
  int? _idataque1;
  int? _idataque2;
  int? _idataque3;
  int? _idataque4;


  //get
  int? get idpokemon => _idpokemon;
  String? get nombre => _nombre;
  String? get genero => _genero;
  int? get nivel => _nivel;
  int? get idtipo1 => _idtipo1;
  int? get idtipo2 => _idtipo2;
  int? get idataque1 => _idataque1;
  int? get idataque2 => _idataque2;
  int? get idataque3 => _idataque3;
  int? get idataque4 => _idataque4;

  //set vamos a darles valor
  set idpokemon(int? idpokemon){
    _idpokemon = idpokemon;
  }

  set nombre(String? nombre){
    _nombre = nombre;
  }

  set genero(String? genero){
    _genero = nombre;
  }

  set nivel(int? nivel){
    _nivel = nivel;
  }

  set idtipo1(int? idtipo1){
    _idtipo1 = idtipo1;
  }

  set idtipo2(int? idtipo2){
    _idtipo2 = idtipo2;
  }

  set idataque1(int? idataque1){
    _idataque1 = idataque1;
  }

  set idataque2(int? idataque2){
    _idataque2 = idataque2;
  }

  set idataque3(int? idataque3){
    _idataque3 = idataque3;
  }

  set idataque4(int? idataque4){
    _idataque4 = idataque4;
  }

}