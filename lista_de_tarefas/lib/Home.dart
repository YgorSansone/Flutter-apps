import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listaTarefas = [];
  Future<File> _getFile() async{
    final diretorio = await getApplicationDocumentsDirectory();
    return File(diretorio.path+"/dados.json");
  }
  _salvarArquivo()async{
    var arquivo = await _getFile();
    Map<String, dynamic> tarefa = Map();

    tarefa["titulo"] = "Ir ao mercado";
    tarefa["realizada"] = false;
    _listaTarefas.add(tarefa);

    String dados = json.encode(_listaTarefas);
    arquivo.writeAsString(dados);
  }
  _lerArquivo() async{
    try{
      final arquivo =await _getFile();
      return arquivo.readAsString();
    }catch(e){
      return null;
    }
  }
  _removerArquivo()async{}
  @override
  void initState() {
    super.initState();
    _lerArquivo().then((dados){
      setState(() {
        _listaTarefas = jsonDecode(dados);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("items: "+ _listaTarefas.toString());
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
                  title: Text(_listaTarefas[index]['titulo']),
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
                          _salvarArquivo();
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
