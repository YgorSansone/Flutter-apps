import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uber/Rotas.dart';
import 'package:uber/model/Usuario.dart';
import 'package:uber/telas/Cadastro.dart';
import 'package:uber/Rotas.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  bool _showPassword = false;
  String _mensagemErro = "";
  bool _carregando = false;
  _validarCampos() {
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length > 6) {
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;
        _logarUsuario(usuario);
      } else {
        setState(() {
          _mensagemErro = "Preencha a senha (6 caracteres minimo) !";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha o Email !";
      });
    }
  }

  _logarUsuario(Usuario usuario) {
    setState(() {
      _carregando = true;
    });
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {
      _PrimeiraPagina(firebaseUser.user.uid);
    }).catchError((error) {
      _mensagemErro = "Login e senhas incorretos !";
    });
  }

  _PrimeiraPagina(String idUsuario) async {
    Firestore db = Firestore.instance;
    DocumentSnapshot snapshot =
        await db.collection("usuarios").document(idUsuario).get();
    Map<String, dynamic> dados = snapshot.data;
    String tipoUsuario = dados["tipoUsuario"];
    setState(() {
      _carregando = false;
    });
    switch(tipoUsuario){
      case "motorista":
        Navigator.pushNamedAndRemoveUntil(
            context,
            Rotas.ROTA_P_MOTORISTA,
                (_) => false
        );
        break;
      case "passageiro":
        Navigator.pushNamedAndRemoveUntil(
            context,
            Rotas.ROTA_P_PASSAGEIRO,
                (_) => false
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("imagens/fundo.png"), fit: BoxFit.cover)),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "imagens/logo.png",
                    width: 200,
                    height: 150,
                  ),
                ),
                TextField(
                  controller: _controllerEmail,
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "e-mail",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6))),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: TextField(
                    controller: _controllerSenha,
                    obscureText: !this._showPassword,
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "senha",
                        filled: true,
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color:
                                this._showPassword ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () {
                            setState(
                                () => this._showPassword = !this._showPassword);
                          },
                        ),
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: Text(
                      "Entrar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Color(0xff1ebbd8),
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    onPressed: () {
                      _validarCampos();
                    },
                  ),
                ),
                Center(
                  child: GestureDetector(
                    child: Text(
                      "Não tem conta? cadastre-se!",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Rotas.ROTA_CADASTRO);
                    },
                  ),
                ),
                _carregando ?
                    Center(child: CircularProgressIndicator(backgroundColor: Colors.white,),)
                :
                    Container(),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Center(
                    child: Text(
                      _mensagemErro,
                      style: TextStyle(color: Colors.red, fontSize: 20),
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
