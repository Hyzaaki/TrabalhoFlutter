import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TelaAddRefeicao extends StatefulWidget {

  @override
  _TelaAddRefeicaoState createState() => _TelaAddRefeicaoState();
}

class _TelaAddRefeicaoState extends State<TelaAddRefeicao> {
  final strNomeNumeroRefeicao = TextEditingController();
  final strNomeAlimento = TextEditingController();
  final strQuantidadeAlimento = TextEditingController();

  Widget _nomenumerorefeicaotxt() {
    return TextFormField(
      controller: strNomeNumeroRefeicao,
      decoration: InputDecoration(
          hintText: "NOME/Nº REFEIÇÃO:",
          hintStyle: TextStyle(
            color: Colors.green,
            fontSize: 18.0,
          )),
    );
  }
  Widget _nomealimentotxt() {
    return TextFormField(
      controller: strNomeAlimento,
      decoration: InputDecoration(
          hintText: "ALIMENTO:",
          hintStyle: TextStyle(
            color: Colors.green,
            fontSize: 18.0,
          )),
    );
  }
  Widget _quantidadealimentotxt() {
    return TextFormField(
      controller: strQuantidadeAlimento,
      decoration: InputDecoration(
          hintText: "QUANTIDADE:",
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
        title: Text('Adicionar refeição'),
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
                      _nomenumerorefeicaotxt(),
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
                      _nomealimentotxt(),
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
                      _quantidadealimentotxt(),
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
                    _saveRefeicao(context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
  _saveRefeicao(BuildContext context) async {
    /* var usuario =
    await SerializaLogin.serializarJson(strName.text, strPassword.text);
    if(usuario == null || usuario.Mensagem != 'Login efetuado com sucesso!') {
      alert(context, "Usuário e/ou Senha Inválidos!");
    }
    */
  }
}