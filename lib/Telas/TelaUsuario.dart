import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/Entidades/Usuario.dart';

class TelaUsuario extends StatefulWidget {

  @override
  _TelaUsuarioState createState() => _TelaUsuarioState();
}

class _TelaUsuarioState extends State<TelaUsuario> {
  final strName = TextEditingController();
  final strEmail = TextEditingController();
  final strAltura = TextEditingController();
  final strPeso = TextEditingController();

  Future obterUsuario() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idUsuario = prefs.getString('currentUser');
    if(idUsuario != null) {
      var usuarioSnapshot = await FirebaseFirestore.instance.collection('usuarios').doc(idUsuario).get();
      Usuario usuario = Usuario.fromJson(usuarioSnapshot.data() as Map<String, dynamic>);
      strName.text = usuario.nome;
      strEmail.text = usuario.email;
      strAltura.text = usuario.altura;
      strPeso.text = usuario.peso;
    }
    else{

    }
  }

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

  @override
  void initState(){
    obterUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha conta'),
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
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                  child: Text('EDITAR'),
                  /*onPressed: () {
                    _saveLoginDetails(context);
                  }

                   */
                  onPressed: () {
                    Navigator.pushNamed(context, '/TelaMenu');
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
