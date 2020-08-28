class Mensagem{
  String _idUsuario;
  String _mensagem;
  String _url;
  String _data;

  String get data => _data;

  set data(String value) {
    _data = value;
  } //texto ou imagem
  String _tipo;

  Mensagem();
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {
      "idUsuario" : this.idUsuario,
      "mensagem" : this.mensagem,
      "url" : this.url,
      "tipo" : this.tipo,
      "data" : this.data,
    };
    return map;
  }

  String get tipo => _tipo;

  set tipo(String value) {
    _tipo = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get mensagem => _mensagem;

  set mensagem(String value) {
    _mensagem = value;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }
}