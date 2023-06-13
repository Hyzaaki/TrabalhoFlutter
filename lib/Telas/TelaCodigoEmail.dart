import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Entidades/Usuario.dart';

class TelaCodigoEmail extends StatefulWidget {

  @override
  _TelaCodigoEmailState createState() => _TelaCodigoEmailState();
}

class _TelaCodigoEmailState extends State<TelaCodigoEmail> {
  final strCodigo = TextEditingController();
  final strNewPassword = TextEditingController();

  Widget _codigotxt() {
    return TextFormField(
      controller: strCodigo,
      decoration: InputDecoration(
          hintText: "CÓDIGO",
          hintStyle: TextStyle(
            color: Colors.green,
            fontSize: 18.0,
          )),
    );
  }

  Widget _senhanovatxt() {
    return TextFormField(
      controller: strNewPassword,
      decoration: InputDecoration(
          hintText: "NOVA SENHA",
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
                      _codigotxt(),
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
                      _senhanovatxt(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                  child: Text('REDEFINIR'),
                  onPressed: () {
                    _validarCodigo(context);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future _validarCodigo(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? codigo = prefs.getString('codigo');
    String? email = prefs.getString('email');
    if(codigo == strCodigo.text)
      {
        var usuarios = await FirebaseFirestore.instance
            .collection('usuarios')
            .where('email', isEqualTo: email)
            .get();
        print(usuarios.size);
        print('aqui');
        print(usuarios.docs.length);
        if( usuarios!=null && usuarios.docs!=null &&usuarios.docs.isNotEmpty) {
          var usu =  Usuario.fromJson(usuarios.docs.first.data());
          usu.id = usuarios.docs.first.id;
          print(usuarios.docs.first.data());
          var usuarioSnapshot = await FirebaseFirestore.instance.collection('usuarios').doc(usu.id).get();
          Usuario usuario = Usuario.fromJson(usuarioSnapshot.data() as Map<String, dynamic>);
          usuario.senha = strNewPassword.text;
          print(usuario.toJson());
          await FirebaseFirestore.instance.collection('usuarios').doc(usu.id).set(usuario.toJson());
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
        }
      }
    else
      {
        alert(context, 'Código inválido.');
      }
  }

  alert(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Código"),
            content: Text(msg),
            actions: <Widget>[
              ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
}