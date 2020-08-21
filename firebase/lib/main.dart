import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
void main()  async {
  WidgetsFlutterBinding.ensureInitialized();


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

//  db.collection("noticias")
//  .document("B0eWllFN76cM4cas2NVO")
//  .setData(
//    {
//      "titulo" : "Novo planeta alterado",
//    "descricao" : "texto exemplo ... "
//    }
//  );

//  print("Item salvo : " + ref.documentID);
  Firestore db = Firestore.instance;
//  db.collection("usuarios").document("003").delete();

//  DocumentSnapshot snapshot = await db.collection("usuarios").document("002").get();
//  var dados = snapshot.data;
//  print("Dados : " + dados["Nome"]);

//  QuerySnapshot querySnapshot = await db.collection("usuarios").getDocuments();
//  print("dados usuarios: " + querySnapshot.documents.toString());
//  for(DocumentSnapshot item in querySnapshot.documents){
//    print("dados usuarios: " + item.data.toString());
//  }
  db.collection("usuarios").snapshots().listen(
      (snapshot){
          for(DocumentSnapshot item in snapshot.documents){
          print("dados usuarios: " + item.data.toString());
        }
        
      }
  );

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

