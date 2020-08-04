import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _itens = [];
  void _carregarItens(){
    _itens = [];
    for(int i =0; i <=  10; i++){
      Map<String, dynamic> item = Map();
      item["titulo"] = "Titulo ${i} a";
      item["descricao"]= "descricao ${i} b";
      _itens.add(item);
    }
  }
  @override
  Widget build(BuildContext context) {
    _carregarItens();
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: _itens.length,
            itemBuilder: (context, indice){
              return ListTile(
                onTap: (){
                  print("");
                  showDialog(
                      context: context,
                    builder: (context){
                     return AlertDialog(
                       title: Text("${_itens[indice]["titulo"]}"),
                       titlePadding: EdgeInsets.all(20),
                       titleTextStyle: TextStyle(
                         fontSize: 20,
                         color: Colors.deepOrange,
                       ),
                       content: Text("conteudo"),
                       actions: <Widget>[
                         FlatButton(
                             onPressed: (){
                               print("sim");
                               setState(() {
                                 _itens.removeAt(indice);
                               });

                               Navigator.pop(context);
                             },
                             child: Text("SIM")
                         ),
                         FlatButton(
                             onPressed: (){
                               print("nao");
                               Navigator.pop(context);
                             },
                             child: Text("NAO")
                         ),
                       ],
                     );
                    }
                  );
                },
                title: Text(_itens[indice]["titulo"]),
                subtitle: Text(_itens[indice]["descricao"]),
              );
            }
        ),
      ),
    );
  }
}
