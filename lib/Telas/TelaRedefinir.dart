import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TelaRedefinirSenha extends StatefulWidget {

  @override
  _TelaRedefinirSenhaState createState() => _TelaRedefinirSenhaState();
}

class _TelaRedefinirSenhaState extends State<TelaRedefinirSenha> {
  final strEmail = TextEditingController();
  String Codigo = "";

  Future sendEmail() async {
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    var intValue = Random().nextInt(9).toString()+Random().nextInt(9).toString()+Random().nextInt(9).toString()+Random().nextInt(9).toString();
    Codigo = intValue;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(Codigo);
    await prefs.setString('codigo', Codigo);
    await prefs.setString('email', strEmail.text);
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'service_id': 'default_service',
        'template_id': 'template_jlgeo1j',
        'user_id': 'CeylLGFiLlcF5cMYQ',
        'template_params':{
          'to_email': strEmail.text,
          'codigo': Codigo
        }
      }),
    );
    print(response.statusCode);
    print(response.body);
    Navigator.of(context).pushNamedAndRemoveUntil('/codigo', (r) => false);
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
                    sendEmail();
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}