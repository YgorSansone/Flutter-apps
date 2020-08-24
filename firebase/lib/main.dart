import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
void main()  async {
//  WidgetsFlutterBinding.ensureInitialized();
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
//  FirebaseAuth auth = FirebaseAuth.instance;
//  String email = "ygorsansone@gmail.com";
//  String senha = "123456";

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

//  FirebaseUser usuarioAtual = await auth.currentUser();
//  if(usuarioAtual != null){
//    print("logado : " +usuarioAtual.email);
//  }else{
//    print("deslogado");
//  }
  
  
  //IMAGENS
  
  runApp(
      MaterialApp(home: Home(),)
  );
}
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File _imagem;
  String _statusUpload = "Upload nao iniciado";
  String _imagemrecuperada ="";
  Future _recuperarImagem(bool daCamera) async{
    File imagemSelecionada;
    if(daCamera){
      // ignore: deprecated_member_use
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);
    }else{
      // ignore: deprecated_member_use
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _imagem = imagemSelecionada;
    });
  }
  Future _uploadImagem() async{
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo = pastaRaiz
        .child("fotos")
        .child("foto1.jpg");
    //Progresso do upload
    StorageUploadTask task = arquivo.putFile(_imagem);
    //controlar progresso de upload
    task.events.listen((StorageTaskEvent storageEvent) {
      if(storageEvent.type == StorageTaskEventType.progress){
        setState(() {
          _statusUpload = "Em progresso";

        });
      }else if(storageEvent.type == StorageTaskEventType.success){
        _statusUpload = "sucesso";
        _imagem = null;
      }
    });
    task.onComplete.then((StorageTaskSnapshot snapshot){
      _recuperarURLImagem(snapshot);
    });
  }
  Future _recuperarURLImagem(StorageTaskSnapshot snapshot)async{
    String url = await snapshot.ref.getDownloadURL();
    print("resultado url : "+ url);
    setState(() {
      _imagemrecuperada = url;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecionar imagem"),
      ),body: SingleChildScrollView(
      child:     Column(
          children: [
            Text(_statusUpload),
      RaisedButton(
      child: Text("Camera"),
        onPressed: (){
          _recuperarImagem(true);
        }
    ),
      RaisedButton(
          child: Text("Galeria"),
          onPressed: (){
            _recuperarImagem(false);
          }
      ),
      _imagem ==null
          ?Container()
          :
      Image.file(_imagem),
            _imagem ==null
                ? Container()
                : RaisedButton(
                child: Text("Upload storage"),
                onPressed: (){
                  _uploadImagem();
                }
            ),
            _imagemrecuperada ==null
                ?Container()
                : Image.network(_imagemrecuperada),
      ],
    ),
    )
    );
  }
}

