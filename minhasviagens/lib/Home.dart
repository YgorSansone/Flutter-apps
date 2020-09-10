import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minhasviagens/Mapa.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore _db = Firestore.instance;
  _adicionarListenerViagens()async{
    final stream = _db.collection("viagens").snapshots();
    stream.listen((dados) {
      _controller.add(dados);
    });
  }
  _abrirMapa(String idviagem){
    Navigator.push(context, MaterialPageRoute(builder: (_) => Mapa(idViagem: idviagem)));
  }
  _excluirViagem(String idviagem){
    _db.collection("viagens").document(idviagem).delete();
  }
  _addLocal(){
    Navigator.push(context, MaterialPageRoute(builder: (_) => Mapa()));
  }
  @override
  void initState() {
    super.initState();
    _adicionarListenerViagens();
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
      body: StreamBuilder<QuerySnapshot>(
          stream: _controller.stream,
          // ignore: missing_return
          builder: (context, snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
              case ConnectionState.done:
                QuerySnapshot querySnapshot = snapshot.data;
                List<DocumentSnapshot> viagens = querySnapshot.documents.toList();
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: viagens.length,
                        itemBuilder: (context, index){
                          DocumentSnapshot item = viagens[index];
                          String titulo = item["titulo"];
                          String subtitulo = item["locality"] == null ? "" : item["locality"] ;
                          String idViagem = item.documentID;
                          return GestureDetector(
                            onTap: (){
                              _abrirMapa(idViagem);
                            },
                            child: Card(
                              child: ListTile(
                                title: Text(titulo),
                                subtitle: Text(subtitulo),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        _excluirViagem(idViagem);
                                      },
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
                );
                break;
            }
          },
      )
    );
  }
}
