import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  Widget _titulo() {
    return Text("NUTRI DIARY",
        style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*Image(
                image: AssetImage("assets/imagens/logo.jpeg"),
                height: 140.0,
                width: 140.0,
              ),*/
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      _titulo(),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          /*Navigator.pushNamed(context, '/login');

                           */
                          Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
                        },
                        child: Text(
                          "CONECTAR",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}