import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TelaInicial extends StatefulWidget {

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('NUTRI DIARY'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      child: Icon(Icons.add),
                      onPressed: () {
                        Navigator.pushNamed(context, '/TelaAddRefeicao');
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(100, 70)), // define o tamanho mínimo do botão
                        padding: MaterialStateProperty.all(EdgeInsets.all(20)), // define o preenchimento do botão
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 50)), // define o estilo do texto do botão
                      ),
                  ),
                ],
              ),
            ],
          )
        ),
    );
  }
}