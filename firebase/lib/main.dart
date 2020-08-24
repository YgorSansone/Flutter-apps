import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

//  db.collection("usuarios").document("003").delete();

//  DocumentSnapshot snapshot = await db.collection("usuarios").document("002").get();
//  var dados = snapshot.data;
//  print("Dados : " + dados["Nome"]);

//  QuerySnapshot querySnapshot = await db.collection("usuarios").getDocuments();
//  print("dados usuarios: " + querySnapshot.documents.toString());
//  for(DocumentSnapshot item in querySnapshot.documents){
//    print("dados usuarios: " + item.data.toString());
//  }

  //PRINTAR PELO LISTEN
//  db.collection("usuarios").snapshots().listen(
//      (snapshot){
//          for(DocumentSnapshot item in snapshot.documents){
//          print("dados usuarios: " + item.data.toString());
//        }
//
//      }
//  );


//  var pesquisa = "Mar";
//  Firestore db = Firestore.instance;
//  QuerySnapshot querySnapshot = await db.collection("usuarios")
//      .where("Nome", isEqualTo: "ygor")
//  .where("idade", isGreaterThan: 15)
//  .where("idade", isLessThan: 50)
//  .orderBy("idade", descending: true)
//  .orderBy("Nome", descending: false)
  //  .limit(2)
//  .where("Nome", isGreaterThanOrEqualTo: pesquisa)
//  .where("Nome", isLessThanOrEqualTo: pesquisa + "\uf8ff")
//      .getDocuments();
//
//  for(DocumentSnapshot item in querySnapshot.documents){
//    var dados = item.data;
//    print("filtro : "+ dados["Nome"] +" _ "+ dados["idade"].toString());
//  }

  ////////////////////////////////////////////////////////////////////
  FirebaseAuth auth = FirebaseAuth.instance;
  String email = "ygorsansone@gmail.com";
  String senha = "123456";

  //CADASTRO
//  auth.createUserWithEmailAndPassword(
//      email: email,
//      password: senha
//  ).then((firebaseUser){
//    print("Sucesso: email: " +firebaseUser.email);
//  }).catchError((erro){
//    print("ERRO : " +erro.toString());
//    });
  //DESLOGANDO
//  auth.signOut();
  //LOGANDO
//  auth.signInWithEmailAndPassword(
//      email: email,
//      password: senha)
//      .then((firebaseUser){
//    print("Logar: email: " +firebaseUser.email);
//  }).catchError((erro){
//    print("ERRO : " +erro.toString());
//    });

  FirebaseUser usuarioAtual = await auth.currentUser();
  if(usuarioAtual != null){
    print("logado : " +usuarioAtual.email);
  }else{
    print("deslogado");
  }
  
  runApp(
      App()
  );
}
class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

