import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
void main()  async {
  WidgetsFlutterBinding.ensureInitialized();

  Firestore db = Firestore.instance;
//    db.collection("usuarios")
//  .document("001")
//  .setData(
//    {
//      "nome" : "Caio",
//      "idade" : "60"
//    }
//  );


//  DocumentReference ref = await db.collection("noticias")
//  .add({
//    "titulo" : "Novo planeta",
//    "descricao" : "texto exemplo ... "
//  });
  db.collection("noticias")
  .document("B0eWllFN76cM4cas2NVO")
  .setData(
    {
      "titulo" : "Novo planeta alterado",
    "descricao" : "texto exemplo ... "
    }
  );


//  print("Item salvo : " + ref.documentID);
  runApp(
      App()
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

