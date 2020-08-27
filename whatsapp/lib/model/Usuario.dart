class Usuario{
  String _idUsuario;
  String _nome;
  String _email;
  String _url;
  String _senha;

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  Usuario();

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "nome" : this.nome,
      "email" : this.email
    };
    return map;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }
}