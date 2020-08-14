import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _tituloControler = TextEditingController();
  TextEditingController _descricaoControler = TextEditingController();
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
