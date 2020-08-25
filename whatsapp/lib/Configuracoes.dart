import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  TextEditingController _controllerNome = TextEditingController();
  File _imagem;
  File imagemSelecionada;
  Future _recuperarImagem(bool daCamera)async{
    if(daCamera){
      // ignore: deprecated_member_use
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
    }else{
      // ignore: deprecated_member_use
      imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.camera);

    }
    setState(() {
      _imagem = imagemSelecionada;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //carregando
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                  NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/whatsapp-465f3.appspot.com/o/perfil%2Fperfil5.jpg?alt=media&token=81ed04c2-e1b4-4e1d-8094-d53ba0238789"
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        onPressed: (){
                          _recuperarImagem(false);
                        },
                        child: Text("Camera")
                    ),
                    FlatButton(
                        onPressed: (){
                          _recuperarImagem(true);
                        },
                        child: Text("Galeria")
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextField(
                    autofocus: true,
                    controller: _controllerNome,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Nome",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                      "Salvar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.green,
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    onPressed: () {
//                      _validarCampos();
                    },
                  ),
                ),
                Center(
                  child: Text(
                    "",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
