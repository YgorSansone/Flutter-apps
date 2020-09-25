import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uber/util/StatusRequisicao.dart';
import 'package:uber/util/UsuarioFirebase.dart';

import '../Rotas.dart';

class PainelMotorista extends StatefulWidget {
  @override
  _PainelMotoristaState createState() => _PainelMotoristaState();
}

class _PainelMotoristaState extends State<PainelMotorista> {
  List<String> itensMenu = ["Deslogar"];
  final _controller = StreamController<QuerySnapshot>.broadcast();
  Firestore db = Firestore.instance;
  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, Rotas.ROTA, (_) => false);
  }

  _escolharMenuItem(String escolha) {
    switch (escolha) {
      case "Deslogar":
        _deslogarUsuario();
        break;
    }
  }

  Stream<QuerySnapshot> _adicionarListenerRequisicao() {
    final stram = db
        .collection("requisicoes")
        .where("status", isEqualTo: StatusRequisicao.AGUARDANDO)
        .snapshots();
    stram.listen((dados) {
      _controller.add(dados);
    });
  }
  _recuperaRequisicaoAtiva()async{
    FirebaseUser firebaseUser = await UsuarioFirebase.getUsuarioAtual();
    DocumentSnapshot documentSnapshot = await
    db.collection("requisicao_ativa_motorista")
    .document(firebaseUser.uid).get();
    var dadosRequisicao = documentSnapshot.data;
    if(dadosRequisicao == null){
      _adicionarListenerRequisicao();
    }else{
      String idRequisicao = dadosRequisicao["id_requisicao"];
      Navigator.pushReplacementNamed(context, Rotas.ROTA_CORRIDA, arguments: idRequisicao);
    }

  }
  @override
  void initState() {
    super.initState();
    _recuperaRequisicaoAtiva();

  }

  @override
  Widget build(BuildContext context) {
    var mensagemCarregando = Center(
      child: Column(
        children: [
          Text("Carregando requisicoes"),
          CircularProgressIndicator(),
        ],
      ),
    );
    var mensagemNaoTemDados = Center(
      child: Column(
        children: [
          Text(
            "Voce nao tem nenhuma requisicao :(",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Painel Motorista"),
        actions: [
          PopupMenuButton<String>(
            onSelected: _escolharMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(value: item, child: Text(item));
              }).toList();
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _controller.stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return mensagemCarregando;
                break;
              case ConnectionState.active:
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text("Erro ao carregar os dados!");
                } else {
                  QuerySnapshot querySnapshot = snapshot.data;
                  if (querySnapshot.documents.length == 0) {
                    return mensagemNaoTemDados;
                  } else {
                    return ListView.separated(
                      itemCount: querySnapshot.documents.length,
                      separatorBuilder: (context, indice) => Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                      itemBuilder: (context,indice){
                        List<DocumentSnapshot> requisicoes = querySnapshot.documents.toList();
                        DocumentSnapshot item = requisicoes[indice];
                        String idRequisicao = item["id"];
                        String nomePassageiro = item["passageiro"]["nome"];
                        String rua = item["destino"]["rua"];
                        String numero = item["destino"]["numero"];

                        return ListTile(
                          title: Text(nomePassageiro),
                          subtitle: Text("Destino: $rua, $numero"),
                          onTap: (){
                            Navigator.pushNamed(context, Rotas.ROTA_CORRIDA, arguments: idRequisicao);
                          },
                        );
                      },
                    );
                  }
                }
            }
          }),
    );
  }
}
