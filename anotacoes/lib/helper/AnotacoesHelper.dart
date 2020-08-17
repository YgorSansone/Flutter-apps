import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AnotacaoHelper{
  static final AnotacaoHelper _anotacaoHelper = AnotacaoHelper._internal();
  Database _db;
  factory AnotacaoHelper(){
    return _anotacaoHelper;
  }
  AnotacaoHelper._internal(){
  }
  get db async{
    if(_db != null){
      return db;
    }else{
      _db = await inicializarDB();
      return _db;
    }

  }
  _onCreate(Database db, int version) async{
    String sql = "CREATE TABLE anotacao (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo, VARCHAR, descricao TEXT, data DATETIME)";
    await db.execute(sql);
  }
  inicializarDB() async{
    final caminhoBanoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBanoDados, "banco_minhas_anotacoes");
    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;
  }
}
