import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/Entidades/Refeicao.dart';
import 'package:http/http.dart' as http;

import 'TakePictureScreen.dart';


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

  _openCamera(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePictureScreen(),
            fullscreenDialog: true
        )
    );
  }

  AtualizarLista (String? texto) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idUsuario = prefs.getString('currentUser');
    print('AtualizarLista');
    print(widget.indice);
    print(widget.listRefeicao.length);

    if(widget.indice > widget.listRefeicao.length - 1) {
      print('aqui1');
      widget.listRefeicao.add(
          Refeicao(idUsuario: idUsuario!,
              nome: strNomeAlimento.text,
              alimento: strNomeAlimento.text,
              carbo: strCarboAlimento.text,
              proteina: strProteinaAlimento.text,
              gordura: strGorduraAlimento.text,
              data: DateTime.now()));
    }
    else {
      print('aqui2');
      widget.listRefeicao[widget.indice].nome = strNomeAlimento.text;
      widget.listRefeicao[widget.indice].alimento = strNomeAlimento.text;
      widget.listRefeicao[widget.indice].carbo = strCarboAlimento.text;
      widget.listRefeicao[widget.indice].proteina = strProteinaAlimento.text;
      widget.listRefeicao[widget.indice].gordura = strGorduraAlimento.text;
    }
  }



  Future<http.Response> fetchAlbum() {
    Map<String, String> header = new Map<String, String>();
    header['Ocp-Apim-Subscription-Key'] = '43547ca6642c41918d5de5af7d2bd5c9';
    header['Content-Type'] = 'application/octet-stream';
    String url = '"https://compvision-philipicalt.cognitiveservices.azure.com/computervision/imageanalysis:analyze?features=read&model-version=latest&language=en&api-version=2023-02-01-preview';
    return http.post(
      Uri.parse(url),
      headers: header,
      body: ''
    );
  }


  Widget _nomealimentotxt() {
    return TextFormField(
      controller: strNomeAlimento,
      onChanged: AtualizarLista,
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
}
