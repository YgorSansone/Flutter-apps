import 'package:flutter/material.dart';
import 'package:minhasviagens/Mapa.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listaviagens = [
    "Cristo ", "Taj Mahal", "Machu Picchu", "Coliseu"
  ];
  _abrirMapa(){
  }
  _excluirViagem(){}
  _addLocal(){
    Navigator.push(context, MaterialPageRoute(builder: (_) => Mapa()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Minhas viagens"),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xff0066cc),
        onPressed: (){
          _addLocal();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: _listaviagens.length,
                itemBuilder: (context, index){
                  String titulo = _listaviagens[index];
                  return GestureDetector(
                    onTap: (){
                      _abrirMapa();
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(titulo),
                        subtitle: Text(titulo),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: _excluirViagem(),
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                child:Icon(Icons.remove_circle, color: Colors.red,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
            ),
          )
        ],
      ),
    );
  }
}
