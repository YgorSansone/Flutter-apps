import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:olx/views/widgets/BotaoCustomizado.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:olx/views/widgets/InputCustomizado.dart';
import 'package:validadores/Validador.dart';
class NovoAnuncio extends StatefulWidget {
  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {
  final _formKey = GlobalKey<FormState>();
  List<File> _listaImagens = List();
  List<DropdownMenuItem<String>> _listaIntensDropEstados = List();
  List<DropdownMenuItem<String>> _listaIntensDropCategorias = List();

  String _itemSelecionadoEstado;
  String _itemSelecionadoCategoria;
  _selecionarImagemGaleria() async {
    File imagemSelecionada =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imagemSelecionada != null) {
      setState(() {
        _listaImagens.add(imagemSelecionada);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();
  }

  _carregarItensDropdown() {
    //categorias
    _listaIntensDropCategorias.add(
        DropdownMenuItem(child: Text("Automovel"), value: "auto",)
    );
    _listaIntensDropCategorias.add(
        DropdownMenuItem(child: Text("Imovel"), value: "imovel",)
    );
    _listaIntensDropCategorias.add(
        DropdownMenuItem(child: Text("Eletronicos"), value: "eletro",)
    );
    _listaIntensDropCategorias.add(
        DropdownMenuItem(child: Text("Moda"), value: "moda",)
    );
    _listaIntensDropCategorias.add(
        DropdownMenuItem(child: Text("Esportes"), value: "esportes",)
    );
    //estados
   for(var estado in Estados.listaEstadosAbrv){
     _listaIntensDropEstados.add(
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
                  validator: (imagens) {
                    if (imagens.length == 0) {
                      return "Necesario selecionar uma imagem!";
                    }
                    return null;
                  },
                  builder: (state) {
                    return Column(
                      children: [
                        Container(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _listaImagens.length + 1,
                            itemBuilder: (context, indice) {
                              if (indice == _listaImagens.length) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      _selecionarImagemGaleria();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[400],
                                      radius: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_a_photo,
                                            size: 40,
                                            color: Colors.grey[100],
                                          ),
                                          Text(
                                            "Adicionar",
                                            style: TextStyle(
                                                color: Colors.grey[100]),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              if (_listaImagens.length > 0) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      // _selecionarImagemGaleria();
                                      showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.file(
                                                        _listaImagens[indice]),
                                                    FlatButton(
                                                      child: Text("Excluir"),
                                                      textColor: Colors.red,
                                                      onPressed: () {
                                                        setState(() {
                                                          _listaImagens
                                                              .removeAt(indice);
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ));
                                    },
                                    child: CircleAvatar(
                                        backgroundImage:
                                            FileImage(_listaImagens[indice]),
                                        radius: 50,
                                        child: Container(
                                          color: Color.fromRGBO(
                                              255, 255, 255, 0.4),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.delete,
                                            size: 30,
                                            color: Colors.red[300],
                                          ),
                                        )),
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                        if (state.hasError)
                          Container(
                            child: Text(
                              "[${state.errorText}]",
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          )
                      ],
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                          value: _itemSelecionadoEstado,
                          hint: Text("Estados"),
                          items: _listaIntensDropEstados,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                          ),
                          validator: (valor){
                            return Validador()
                                .add(Validar.OBRIGATORIO, msg: "Campo obrigatorio")
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
                          hint: Text("Categoria"),
                          items: _listaIntensDropCategorias,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20
                          ),
                          validator: (valor){
                            return Validador()
                                .add(Validar.OBRIGATORIO, msg: "Campo obrigatorio")
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
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15,top: 15),
                  child:InputCustomizado(
                    controller: null,
                    hint: "Titulo",
                    validator: (valor){
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo obrigatorio")
                          .valido(valor);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child:InputCustomizado(
                    controller: null,
                    hint: "Preco",
                    type: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true)
                    ],
                    validator: (valor){
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo obrigatorio")
                          .valido(valor);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child:InputCustomizado(
                    controller: null,
                    hint: "Telefone",
                    type: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                    validator: (valor){
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo obrigatorio")
                          .valido(valor);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child:InputCustomizado(
                    controller: null,
                    hint: "Descricao (200 caracteres)",
                    maxLines: null,
                    validator: (valor){
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo obrigatorio")
                      .maxLength(200, msg: "Maximo de 200 caracteres")
                          .valido(valor);
                    },
                  ),
                ),


                BotaoCustomizado(
                  texto: "Cadastrar anuncio",
                  corTexto: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {

                    }
                  },
                ),
                //área de imagens
                //Menus Dropdown
                //Caixas de textos e botoes
              ],
            ),
          ),
        ),
      ),
    );
  }
}
