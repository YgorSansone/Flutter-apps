import 'package:flutter/material.dart';
import 'tarefa.dart';
void main() {
  runApp(new TodoListApp());
}

class TodoListApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'TodoList App',
        home: new ListaScreen()
    );
  }
}

class ListaScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ListaScreenState();
  }
}

class ListaScreenState extends State<ListaScreen> {

  List<Tarefa> tarefas = new List<Tarefa>();
  TextEditingController controller = new TextEditingController();

  void adicionaTarefa(String nome) {
    setState(() {
      tarefas.add(Tarefa(nome));
    });
    controller.clear();
  }

  Widget getItem(Tarefa tarefa) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
            icon: Icon(tarefa.concluida ? Icons.check_box : Icons.check_box_outline_blank, size: 42.0, color: Colors.green,),
            padding: EdgeInsets.only(left: 10.0, right: 30.0),
            onPressed: () {
              setState((){
                tarefa.concluida = true;
              });
            }
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(tarefa.nome, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
            Text(tarefa.data) // Intl
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: Text("ToDoList")
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                  controller: controller,
                  onSubmitted: adicionaTarefa
              )
          ),
          Expanded(
              child:ListView.builder(
                itemCount: tarefas.length,
                itemBuilder: (_, indice) {
                  return getItem(tarefas[indice]);
                },
              )
          )
        ],
      ),
    );
  }
}