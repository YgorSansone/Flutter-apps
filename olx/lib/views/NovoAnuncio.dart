import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx/models/Anuncio.dart';
import 'package:olx/views/widgets/BotaoCustomizado.dart';
import 'package:olx/views/widgets/InputCustomizado.dart';
import 'package:validadores/Validador.dart';

class NovoAnuncio extends StatefulWidget {
  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {

  List<File> _listaImagens = List();
  List<DropdownMenuItem<String>> _listaItensDropEstados = List();
  List<DropdownMenuItem<String>> _listaItensDropCategorias = List();
  final _formKey = GlobalKey<FormState>();
  Anuncio _anuncio;

  String _itemSelecionadoEstado;
  String _itemSelecionadoCategoria;

  BuildContext _dialogContext;

  _selecionarImagemGaleria() async {

    File imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);

    if( imagemSelecionada != null ){
      setState(() {
        _listaImagens.add( imagemSelecionada );
      });
    }

  }

  _salvarAnuncio() async {

    //Upload imagens no
    _abrirDialog(_dialogContext);
    await _uploadImagens();

    print("lista imagens: ${_anuncio.fotos.toString()}");
    
    //Salvar anuncio no Firestore
    Firestore db = Firestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    String idUsuarioLogado = usuarioLogado.uid;
    db.collection("meus_anuncios")
    .document(idUsuarioLogado)
    .collection("anuncios")
    .document(_anuncio.id)
    .setData(_anuncio.toMap()).then((_){
      Navigator.pop(_dialogContext);
      Navigator.pushReplacementNamed(context, "/meus-anuncios");
    });
  }

  _abrirDialog(BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20,),
              Text("Salvando anuncio...")
            ],
          ),
        );
      }
    );
  }

  Future _uploadImagens() async {

    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();

    for( var imagem in _listaImagens ){

      String nomeImagem = DateTime.now().millisecondsSinceEpoch.toString() + _anuncio.id + DateTime.now().second.toString();
      StorageReference arquivo = pastaRaiz
          .child("meus_anuncios")
          .child( _anuncio.id )
          .child( nomeImagem );

      StorageUploadTask uploadTask = arquivo.putFile(imagem);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      String url = await taskSnapshot.ref.getDownloadURL();
      _anuncio.fotos.add(url);

    }

  }

  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();

    _anuncio = Anuncio();

  }

  _carregarItensDropdown(){

    //Categorias
    _listaItensDropCategorias.add(
        DropdownMenuItem(child: Text("Automóvel"), value: "auto",)
    );

    _listaItensDropCategorias.add(
        DropdownMenuItem(child: Text("Imóvel"), value: "imovel",)
    );

    _listaItensDropCategorias.add(
        DropdownMenuItem(child: Text("Eletrônicos"), value: "eletro",)
    );

    _listaItensDropCategorias.add(
        DropdownMenuItem(child: Text("Moda"), value: "moda",)
    );

    _listaItensDropCategorias.add(
        DropdownMenuItem(child: Text("Esportes"), value: "esportes",)
    );

    //Estados
    for( var estado in Estados.listaEstadosAbrv ){
      _listaItensDropEstados.add(
        DropdownMenuItem(child: Text(estado), value: estado,)
      );
    }

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
                validator: ( imagens ){
                  if( imagens.length == 0 ){
                    return "Necessário selecionar uma imagem!";
                  }
                  return null;
                },
                builder: (state){
                  return Column(children: <Widget>[
                    Container(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _listaImagens.length + 1, //3
                          itemBuilder: (context, indice){
                            if( indice == _listaImagens.length ){
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: GestureDetector(
                                  onTap: (){
                                    _selecionarImagemGaleria();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[400],
                                    radius: 50,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                      Icon(
                                        Icons.add_a_photo,
                                        size: 40,
                                        color: Colors.grey[100],
                                      ),
                                      Text(
                                        "Adicionar",
                                        style: TextStyle(
                                          color: Colors.grey[100]
                                        ),
                                      )
                                    ],),
                                  ),
                                ),
                              );
                            }

                            if( _listaImagens.length > 0 ){
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: GestureDetector(
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                            Image.file( _listaImagens[indice] ),
                                            FlatButton(
                                              child: Text("Excluir"),
                                              textColor: Colors.red,
                                              onPressed: (){
                                                setState(() {
                                                  _listaImagens.removeAt(indice);
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                            )
                                          ],),
                                        )
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: FileImage( _listaImagens[indice] ),
                                    child: Container(
                                      color: Color.fromRGBO(255, 255, 255, 0.4),
                                      alignment: Alignment.center,
                                      child: Icon(Icons.delete, color: Colors.red,),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container();

                          }
                      ),
                    ),
                    if( state.hasError )
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

              Row(children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: DropdownButtonFormField(
                      value: _itemSelecionadoEstado,
                      hint: Text("Estados"),
                      onSaved: (estado){
                        _anuncio.estado = estado;
                      },
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20
                      ),
                      items: _listaItensDropEstados,
                      validator: (valor){
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .valido(valor);
                      },
                      onChanged: (valor){
                        setState(() {
                          _itemSelecionadoEstado = valor;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: DropdownButtonFormField(
                      value: _itemSelecionadoCategoria,
                      hint: Text("Categorias"),
                      onSaved: (categoria){
                        _anuncio.categoria = categoria;
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                      ),
                      items: _listaItensDropCategorias,
                      validator: (valor){
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                            .valido(valor);
                      },
                      onChanged: (valor){
                        setState(() {
                          _itemSelecionadoCategoria = valor;
                        });
                      },
                    ),
                  ),
                ),
              ],),

              Padding(
                padding: EdgeInsets.only(bottom: 15, top: 15),
                child: InputCustomizado(
                  hint: "Título",
                  onSaved: (titulo){
                    _anuncio.titulo = titulo;
                  },
                  validator: (valor){
                    return Validador()
                        .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                        .valido(valor);
                  },
                ),
              ),

                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: InputCustomizado(
                    hint: "Preço",
                    onSaved: (preco){
                      _anuncio.preco = preco;
                    },
                    type: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true)
                    ],
                    validator: (valor){
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                          .valido(valor);
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: InputCustomizado(
                    hint: "Telefone",
                    onSaved: (telefone){
                      _anuncio.telefone = telefone;
                    },
                    type: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                    validator: (valor){
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                          .valido(valor);
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: InputCustomizado(
                    hint: "Descrição (200 caracteres)",
                    onSaved: (descricao){
                      _anuncio.descricao = descricao;
                    },
                    maxLines: null,
                    validator: (valor){
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                          .maxLength(200, msg: "Máximo de 200 caracteres")
                          .valido(valor);
                    },
                  ),
                ),

              BotaoCustomizado(
                texto: "Cadastrar anúncio",
                onPressed: (){
                  if( _formKey.currentState.validate() ){

                    //salva campos
                    _formKey.currentState.save();

                    //salvar anuncio
                    _dialogContext = context;
                    _salvarAnuncio();

                  }
                },
              ),
            ],),
          ),
        ),
      ),
    );
  }
}
