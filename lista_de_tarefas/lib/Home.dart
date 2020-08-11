import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listaTarefas = ["Ir ao mercado","Estudar"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas",style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _listaTarefas.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(_listaTarefas[index]),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
          onPressed: (){
            showDialog(
                context: context,
            builder: (context){
                  return AlertDialog(
                    title: Text("Adicionar Tarefa"),
                    content: TextField(
                      decoration: InputDecoration(
                        labelText: "Digite sua tarefa",
                      ),
                      onChanged: (text){

                      },
                    ),
                    actions: [
                      FlatButton(
                        child: Text("Cancelar"),
                        onPressed: (){Navigator.pop((context));},
                      ),
                      FlatButton(
                        child: Text("Salvar"),
                        onPressed: (){

                          Navigator.pop((context));
                        },
                      ),
                    ],
                  );
            });
          }
      ),
    );
  }
}
