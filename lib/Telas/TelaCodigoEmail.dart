import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
                    Navigator.pushNamed(context, '/login');
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}