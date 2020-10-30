import 'dart:io';

import 'package:flutter/material.dart';
import 'package:olx/views/widgets/BotaoCustomizado.dart';

class NovoAnuncio extends StatefulWidget {
  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {

  final _formKey = GlobalKey<FormState>();
  List<File> _listaImagens = List();
  _selecionarImagemGaleria(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo anúncio"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
              FormField<List>(
                initialValue: _listaImagens,
                validator: (imagens){
                  if(imagens.length == 0){
                    return "Necesario selecionar uma imagem!";
                  }
                  return null;
                },
                builder: (state){
                  return Column(children: [
                    Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _listaImagens.length +1,
                        itemBuilder: (context, indice){
                          if(indice == _listaImagens.length){
                            return Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 8),
                              child: GestureDetector(
                                onTap: (){
                                  _selecionarImagemGaleria();
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey[400],
                                  radius: 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add_a_photo,
                                        size: 40,
                                        color: Colors.grey[100],
                                      ),
                                      Text("Adicionar", style: TextStyle(
                                        color: Colors.grey[100]
                                      ),)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          if(_listaImagens.length > 0 ){

                          }
                          return Container();
                        },
                      ),
                    ),
                    if(state.hasError)
                      Container(
                        child: Text(
                          "[${state.errorText}]",
                          style: TextStyle(
                            color: Colors.red, fontSize: 14
                          ),
                        ),
                      )
                  ],);
                },

              ),
              Row(
                children: [
                  Text("Estado"),
                  Text("categoria")
                ],
              ),
              Text("Caixas de textos"),
              BotaoCustomizado(texto: "Cadastrar anuncio", corTexto: Colors.white, onPressed: (){
                if(_formKey.currentState.validate()){

                }
              },),
              //área de imagens
              //Menus Dropdown
              //Caixas de textos e botoes
            ],),
          ),
        ),
      ),
    );
  }
}
