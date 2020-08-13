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
  }
  _salvar() async{
    Database bd = await _recuperarBancoDeDados();
    Map<String, dynamic> dadosUsuarios ={
      "nome" : "Ygor",
      "idade" : "30"
    };
    int id = await bd.insert("usuarios", dadosUsuarios);
    print("ID: " + id.toString());
  }
  _listarUsuarios()async {
    Database bd = await _recuperarBancoDeDados();
    String sql = "SELECT * FROM usuarios WHERE idade = 30";
    List usuarios = await bd.rawQuery(sql);
    for(var usuario in usuarios){
      print(
        "id : "+ usuario['id'].toString()+
          " nome : " + usuario['nome']+
          " idade : " + usuario['idade'].toString()
      );
    }
    print("Usuarios : "+ usuarios.toString());
  }

  @override
  Widget build(BuildContext context) {
    _salvar();
    _listarUsuarios();
    return Container();
  }
}
