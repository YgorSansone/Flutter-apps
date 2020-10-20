import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _showPassword = false;
  bool _cadastrar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(""),),
      body: Container(
        padding:EdgeInsets.all(16),
        child: Center(
          child:SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "assets/img/logo.png",
                    width: 200,
                    height: 150
                  )
                ),
                TextField(
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    hintText: "Email",
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)
                    )
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: TextField(
                      obscureText: !this._showPassword,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Senha",
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6)
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.remove_red_eye,
                            color:
                            this._showPassword ? Color(0xff9c27b0) : Colors.grey,
                          ),
                          onPressed: () {
                            setState(
                                    () => this._showPassword = !this._showPassword);
                          },
                        ),
                      )
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text("Logar"),
                    Switch(
                      value: _cadastrar,
                      onChanged: (bool valor){
                        setState(() {
                          _cadastrar = valor;
                        });
                      }
                    ),
                    Text("Cadastrar"),
                  ]
                ),
                RaisedButton(
                  child: Text("Entrar", style: TextStyle(
                    color: Colors.white, fontSize: 20
                  ),
                  ),
                  color: Color(0xff9c27b0),
                  padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                  onPressed:(){

                  }
                )
              ]
            )
          )
        )
      )
    );
  }
}
