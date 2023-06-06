import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/Entidades/Refeicao.dart';

class RefeicaoItem extends StatefulWidget {
  @override
  _RefeicaoItemState createState() => _RefeicaoItemState();

  final List<Refeicao> listRefeicao;
  final int indice;

  const RefeicaoItem({super.key, required this.listRefeicao, required this.indice});
}

class _RefeicaoItemState extends State<RefeicaoItem> {
  final strNomeAlimento = TextEditingController();
  final strCarboAlimento = TextEditingController();
  final strProteinaAlimento = TextEditingController();
  final strGorduraAlimento = TextEditingController();
  List<Widget> textFormFields = [];


  AtualizarLista () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idUsuario = prefs.getString('currentUser');
    if(widget.indice > widget.listRefeicao.length - 1) {
      widget.listRefeicao.add(Refeicao(idUsuario: idUsuario!, nome: strNomeAlimento.text, alimento: strNomeAlimento.text, carbo: strCarboAlimento.text, proteina: strProteinaAlimento.text, gordura: strGorduraAlimento.text));
    }
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
    return TextFormField(
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
    return TextFormField(
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
    return TextFormField(
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
    return ElevatedButton(
        child: Icon(Icons.add_a_photo),
        onPressed: () {
          _openCamera(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
              elevation: 12.0,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
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
                    Row(children: <Widget>[
                      _iconcamera(),
                    ])
                  ],
                ),
              ),
            );
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
