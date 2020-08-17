import 'package:anotacoes/model/Anotacao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnotacaoHelper{
  static final String nomeTabela = "anotacao";
  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();
  Database _db;
  factory AnotacaoHelper(){
    return _anotacaoHelper;
  }
  AnotacaoHelper._internal(){
  }  get db async{
    if(_db != null){
      return _db;
    }else{
      _db = await inicializarDB();
      return _db;
    }
  }

  _onCreate(Database db, int version) async{
    String sql = "CREATE TABLE $nomeTabela (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo, VARCHAR, descricao TEXT, data DATETIME)";
    await db.execute(sql);
  }
  inicializarDB() async{
    final caminhoBanoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBanoDados, "banco_minhas_anotacoes");
    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }
  Future<int>salavarAnotacao (Anotacao anotacao)async {
    var bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabela, anotacao.toMap());
    return resultado;
  }
  Future<int>atualizarAnotacao(Anotacao anotacao) async{
    var bancoDados = await db;
    await bancoDados.update(
      nomeTabela,
      anotacao.toMap(),
      where: "id = ?",
      whereArgs: [anotacao.id]
    );
  }
  recuperarAnotacao() async{
    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTabela ORDER BY data DESC";
    List anotacoes = await bancoDados.rawQuery(sql);
    return anotacoes;

  }
}
