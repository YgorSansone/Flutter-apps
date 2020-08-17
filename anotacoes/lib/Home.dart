import 'package:anotacoes/helper/AnotacoesHelper.dart';
import 'package:anotacoes/model/Anotacao.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _tituloControler = TextEditingController();
  TextEditingController _descricaoControler = TextEditingController();
  var _db = AnotacaoHelper();
  _exibirTelaCadastro(){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Adicionar anotacoes"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _tituloControler,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: "Titulo",
                    hintText: "Digite titulo ..."
                  ),
                ),
                TextField(
                  controller: _descricaoControler,
                  decoration: InputDecoration(
                      labelText: "Descricao",
                      hintText: "Digite Descricao ..."
                  ),
                )
              ],
            ),
          actions: [
            FlatButton(
                onPressed: ()=> Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(Icons.close,
                    color: Colors.red,),
                    Text("Cancelar")
                  ],
                )
            ),

            FlatButton(
                onPressed: (){
                  _salavarAnotacao();
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                  Icon(Icons.done,
                  color: Colors.purple,),
                    Text("Salvar"),
                  ],
                  )
            ),
          ],
         );
    });
  }
  _salavarAnotacao () async{
    String titulo = _tituloControler.text;
    String descricao = _descricaoControler.text;
    Anotacao anotacao = Anotacao(titulo,descricao,DateTime.now().toString());
    int resultado = await _db.salavarAnotacao(anotacao);
    print("salvar :" +resultado.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas anotacoes"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: (){
          _exibirTelaCadastro();
        },
      ),
    );
  }
}
