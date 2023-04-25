import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TelaAddRefeicao extends StatefulWidget {

  @override
  _TelaAddRefeicaoState createState() => _TelaAddRefeicaoState();
}

class _TelaAddRefeicaoState extends State<TelaAddRefeicao> {
  final strNomeNumeroRefeicao = TextEditingController();
  final strNomeAlimento = TextEditingController();
  final strCarboAlimento = TextEditingController();
  final strProteinaAlimento = TextEditingController();
  final strGorduraAlimento = TextEditingController();

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
          hintText: "Alimento:",
          hintStyle: TextStyle(
            color: Colors.green,
            fontSize: 18.0,
          )),
    );
  }
  Widget _carboalimentotxt() {
    return
      TextFormField(
        controller: strCarboAlimento,
        decoration: InputDecoration(
          hintText: "Carboidratos:",
          hintStyle: TextStyle(
            color: Colors.green,
            fontSize: 18.0,
          )),
      );
  }

  Widget _proteinaalimentotxt() {
    return
      TextFormField(
        controller: strProteinaAlimento,
        decoration: InputDecoration(
            hintText: "Proteínas:",
            hintStyle: TextStyle(
              color: Colors.green,
              fontSize: 18.0,
            )),
      );
  }

  Widget _gorduralimentotxt() {
    return
      TextFormField(
        controller: strGorduraAlimento,
        decoration: InputDecoration(
            hintText: "Gordura:",
            hintStyle: TextStyle(
              color: Colors.green,
              fontSize: 18.0,
            )),
      );
  }

  Widget _iconcamera() {
    return
      ElevatedButton(
        child: Icon(Icons.add_a_photo),
          onPressed: () {
            _openCamera(context);
          }
      );
  }

  Widget _addalimento() {
    return
      ElevatedButton(
          child: Icon(Icons.add_circle),
          onPressed: () {
            _openCamera(context);
          }
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
                  child:
                  Column(
                    children: <Widget>[
                      _nomealimentotxt(),
                      SizedBox(
                        height: 12.0,
                      ),
                      _carboalimentotxt(),
                      SizedBox(
                        height: 12.0,
                      ),
                      _proteinaalimentotxt(),
                      SizedBox(
                        height: 12.0,
                      ),
                      _gorduralimentotxt(),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: <Widget>[
                          _iconcamera(),
                        ]
                      )
                    ],
                  ),

                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: <Widget>[
                      _addalimento(),
                    ],
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
  _openCamera(BuildContext context) async {
    /* var usuario =
    await SerializaLogin.serializarJson(strName.text, strPassword.text);
    if(usuario == null || usuario.Mensagem != 'Login efetuado com sucesso!') {
      alert(context, "Usuário e/ou Senha Inválidos!");
    }
    */
  }
}