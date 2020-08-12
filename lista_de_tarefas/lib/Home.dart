import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  TextEditingController _controllerTarefa = TextEditingController();
  _salvarTarefa(){
    String textoDigitado = _controllerTarefa.text;
    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = textoDigitado;
    tarefa["realizada"] = false;
    setState(() {
      _listaTarefas.add(tarefa);
    });
    _controllerTarefa.text = "";
    _salvarArquivo();
  }

  Future<File> _getFile() async{
    final diretorio = await getApplicationDocumentsDirectory();
    return File(diretorio.path+"/dados.json");
  }
  _salvarArquivo()async{
    var arquivo = await _getFile();
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
  Widget criarItemLista(context, index){
    final item = _listaTarefas[index]["titulo"];
    return Dismissible(
        key: Key(item),
        direction: DismissDirection.endToStart,
        onDismissed: (direction){
            _listaTarefas.removeAt(index);
          _salvarArquivo();
        },
        background: Container(
          color: Colors.red,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.delete,
                color: Colors.white,
              )
            ],
          ),
        ),
        child: CheckboxListTile(
          title: Text(_listaTarefas[index]['titulo']),
          value: _listaTarefas[index]['realizada'],
          onChanged: (valorAlterado){
            setState(() {
              _listaTarefas[index]['realizada'] = valorAlterado;
            });
            _salvarArquivo();
          },
        ),
    );
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
              itemBuilder: criarItemLista,
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
                      controller: _controllerTarefa,
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
                          _salvarTarefa();
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
