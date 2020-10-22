import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _cpfController = TextEditingController();
  TextEditingController _cnpjController = TextEditingController();
  TextEditingController _cepController = TextEditingController();
  TextEditingController _telController = TextEditingController();
  TextEditingController _dataController = TextEditingController();
  String _valorRecuperado = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mascaras e validacoes"),),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // CPF

            TextField(
              controller: _cpfController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                // ignore: deprecated_member_use
                WhitelistingTextInputFormatter.digitsOnly,
                CpfInputFormatter()
              ],
              decoration: InputDecoration(
                hintText: "Digite cpf"
              ),
            ),
            TextField(
              controller: _cnpjController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                // ignore: deprecated_member_use
                WhitelistingTextInputFormatter.digitsOnly,
                CnpjInputFormatter()
              ],
              decoration: InputDecoration(
                  hintText: "Digite cnpj"
              ),
            ),


            TextField(
              controller: _cepController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                // ignore: deprecated_member_use
                WhitelistingTextInputFormatter.digitsOnly,
                CepInputFormatter()
              ],
              decoration: InputDecoration(
                  hintText: "Digite cep"
              ),
            ),


            TextField(
              controller: _telController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                // ignore: deprecated_member_use
                WhitelistingTextInputFormatter.digitsOnly,
                TelefoneInputFormatter()
              ],
              decoration: InputDecoration(
                  hintText: "Digite telefone"
              ),
            ),


            TextField(
              controller: _dataController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                // ignore: deprecated_member_use
                WhitelistingTextInputFormatter.digitsOnly,
                DataInputFormatter()
              ],
              decoration: InputDecoration(
                  hintText: "Digite data"
              ),
            ),
            
            RaisedButton(
              child: Text("Recuperar Valor"),
              onPressed: (){
                setState(() {
                  _valorRecuperado = _dataController.text.toString();
                });
              },
            ),
            
            Text("Valor " + _valorRecuperado, style: TextStyle(
              fontSize: 25
            ),)
          ],
        ),
      ),
    );
  }
}
