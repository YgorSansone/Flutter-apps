import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
void main(){
  runApp(MaterialApp(
    home: Home(),
  )
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  _recuperarBancoDeDados() async{
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.db");
    var bd = await openDatabase(
        localBancoDados,
        version: 1,
        onCreate:(db, dbVersaoRecente){
          String sql = "CREATE TABLE usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, idade INTEGER)";
          db.execute(sql);
        }
    );
    return bd;
//    print("aberto" + retorno.isOpen.toString());
  }
  _salvar() async{
    Database bd = await _recuperarBancoDeDados();
    Map<String, dynamic> dadosUsuarios ={
      "nome" : "Ygor",
      "idade" : "21"
    };
    int id = await bd.insert("usuarios", dadosUsuarios);
    print("ID: " + id.toString());
  }

  @override
  Widget build(BuildContext context) {
    _salvar();
    return Container();
  }
}
