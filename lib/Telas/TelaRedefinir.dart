import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TelaRedefinirSenha extends StatefulWidget {

  @override
  _TelaRedefinirSenhaState createState() => _TelaRedefinirSenhaState();
}

class _TelaRedefinirSenhaState extends State<TelaRedefinirSenha> {
  final strEmail = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Redefinir senha'),
        ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                  child: Text('ENVIAR'),
                  onPressed: () {
                    _sendCode(context);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
  _sendCode(BuildContext context) async {
    // FirebaseFirestore.instance.collection("refeicoes")
        // .add(Refeicao(nome: strNomeNumeroRefeicao.text, alimento: strNomeAlimento.text, carbo: strCarboAlimento.text, proteina: strProteinaAlimento.text, gordura: strGorduraAlimento.text).toJson())
        // .then((querySnapshot) {
      Navigator.pushNamed(context, '/codigo');
    // });
  }
}