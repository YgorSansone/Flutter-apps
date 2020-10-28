import 'package:brasil_fields/brasil_fields.dart';
// import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validadores/validadores.dart';

class Formulario extends StatefulWidget {
  @override
  _FormularioState createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {

  TextEditingController _nomeController = TextEditingController(text: "Jamilton");
  TextEditingController _idadeController = TextEditingController(text: "32");
  TextEditingController _cpfController = TextEditingController(text: "334.616.710-02");

  final _formKey = GlobalKey<FormState>();

  String _mensagem = "";
  String _nome;
  String _idade;
  String _cpf;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[

            TextFormField(
              controller: _nomeController,
             onSaved: (valor){
                _nome = valor;
             },
             decoration: InputDecoration(
               hintText: "Digite seu nome"
             ),
             validator: (valor){

               return Validador()
                   .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                    .minLength(5, msg: "Mínimo de 5 caracteres")
                    .maxLength(100, msg: "Máximo de 100 caracteres")
                   .valido(valor);

             },
            ),

            TextFormField(
              controller: _idadeController,
              onSaved: (valor){
                _idade = valor;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Digite sua idade"
              ),
              validator: (valor){

                return Validador()
                    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                    .valido(valor);

              },
            ),

            TextFormField(
              controller: _cpfController,
              onSaved: (valor){
                _cpf = valor;
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                CpfInputFormatter()
              ],
              decoration: InputDecoration(
                  hintText: "Digite seu CPF"
              ),
              validator: (valor){

//                if( valor.isEmpty ){
//                  return "Campo obrigatório";
//                }
//
//                if( !CPFValidator.isValid(valor) ){
//                  return "CPF Inválido";
//                }

                return Validador()
                    .add(Validar.OBRIGATORIO, msg: "Campo obrigatório")
                    .add(Validar.CPF, msg: "CPF Inválido")
                .valido(valor);

              },
            ),

            RaisedButton(
              child: Text("Salvar"),
              onPressed: (){
                if( _formKey.currentState.validate() ){

                  _formKey.currentState.save();

                  setState(() {
                    /*
                    _nome = _nomeController.text;
                    _idade = _idadeController.text;
                    _cpf = _cpfController.text;
                    */
                    _mensagem = "Nome: ${_nome} idade: ${_idade} CPF: ${_cpf}";

                  });


                }
              },
            ),
            Text(
                _mensagem,
              style: TextStyle(
                fontSize: 25
              ),
            )

          ],),
        ),
      ),
    );
  }
}
