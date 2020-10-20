import 'package:flutter/material.dart';
import 'package:olx/models/Usuario.dart';

import 'InputCustomizado.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _showPassword = false;
  bool _cadastrar = false;
  TextEditingController _controllerEmail =
      TextEditingController(text: "ygorteste@gmail.com");
  TextEditingController _controllerSenha =
      TextEditingController(text: "123456789");
  String _mensagemErro = "";
  String _textoBotao = "Entrar";

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {

    });
  }

  _logarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {

    });
  }

  _validarCampos() {
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 6) {
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;
        _cadastrar ? _cadastrarUsuario(usuario) : _logarUsuario(usuario);
      } else {
        setState(() {
          _mensagemErro = "Preencha a senha !";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha a email valido!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
        ),
        body: Container(
            padding: EdgeInsets.all(16),
            child: Center(
                child: SingleChildScrollView(
                    child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset("assets/img/logo.png",
                      width: 200, height: 150)),
              InputCustomizado(
                  controller: _controllerEmail,
                  hint: "Email",
                  autofocus: true,
                  type: TextInputType.emailAddress),
              Padding(
                padding: EdgeInsets.only(top: 6),
                child: TextField(
                    controller: _controllerSenha,
                    obscureText: !this._showPassword,
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Senha",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: this._showPassword
                              ? Color(0xff9c27b0)
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setState(
                              () => this._showPassword = !this._showPassword);
                        },
                      ),
                    )),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Logar"),
                Switch(
                    value: _cadastrar,
                    onChanged: (bool valor) {
                      setState(() {
                        _cadastrar = valor;
                        _textoBotao = "Entrar";
                        if(_cadastrar){
                          _textoBotao = "Cadastrar";
                        }
                      });
                    }),
                Text("Cadastrar"),
              ]),
              RaisedButton(
                  child: Text(
                    _textoBotao,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Color(0xff9c27b0),
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  onPressed: () {_validarCampos();}),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  _mensagemErro,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
            ])))));
  }
}
