import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../Entidades/Usuario.dart';

class TelaCadastro extends StatefulWidget {

  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final strName = TextEditingController();
  final strEmail = TextEditingController();
  final strAltura = TextEditingController();
  final strPeso = TextEditingController();
  final strPassword = TextEditingController();

  Widget _nometxt() {
    return TextFormField(
      controller: strName,
      decoration: InputDecoration(
          hintText: "NOME",
          hintStyle: TextStyle(
            color: Colors.green,
            fontSize: 18.0,
          )),
    );
  }

  Widget _emailtxt() {
    return TextFormField(
      controller: strEmail,
      decoration: InputDecoration(
          hintText: "EMAIL",
          hintStyle: TextStyle(
            color: Colors.green,
            fontSize: 18.0,
          )),
    );
  }

  Widget _alturatxt() {
    return TextFormField(
      controller: strAltura,
      decoration: InputDecoration(
          hintText: "ALTURA",
          hintStyle: TextStyle(
            color: Colors.green,
            fontSize: 18.0,
          )),
    );
  }

  Widget _pesotxt() {
    return TextFormField(
      controller: strPeso,
      decoration: InputDecoration(
          hintText: "PESO",
          hintStyle: TextStyle(
            color: Colors.green,
            fontSize: 18.0,
          )),
    );
  }

  Widget _senhatxt() {
    return TextFormField(
        obscureText: true,
        controller: strPassword,
        decoration: InputDecoration(
            hintText: "SENHA",
            hintStyle: TextStyle(
              color: Colors.green,
              fontSize: 18.0,
            )));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Card(
                elevation: 12.0,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      _nometxt(),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 12.0,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      _emailtxt(),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 12.0,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      _alturatxt(),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 12.0,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      _pesotxt(),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 12.0,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      _senhatxt(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                  child: Text('SALVAR'),
                  onPressed: () {
                    _saveLoginDetails(context);
                    }
                  ),
            ],
          ),
        ),
      ),
    );
  }
  _saveLoginDetails(BuildContext context) async {
    FirebaseFirestore.instance.collection("usuarios")
    .add(Usuario(nome: strName.text, email: strEmail.text, altura: strAltura.text, peso: strPeso.text, senha: strPassword.text).toJson())
        .then((querySnapshot) {
          Navigator.pushNamed(context, '/login');
        });
  }
}





