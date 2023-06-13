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

  Future lerImagem(XFile stateImagem) async {
    Map<String, String> header = new Map<String, String>();
    String url = 'https://compvision-philipicalt.cognitiveservices.azure.com/computervision/imageanalysis:analyze?features=read&model-version=latest&language=en&api-version=2023-02-01-preview';
    print('stateImage');
    print(stateImagem!.name);
    var bytes  = await stateImagem!.readAsBytes();
    print(bytes.length);
    var request = new http.Request("POST", Uri.parse(url))
      ..headers['Ocp-Apim-Subscription-Key'] = "43547ca6642c41918d5de5af7d2bd5c9"
      ..headers['Content-Type'] = "application/octet-stream"
      ..bodyBytes = bytes;
    var response = await http.Response.fromStream(await request.send());
    print(request);
    print("Result: ${response.statusCode}");
    print(response.statusCode);
    print(response.body);
    String body = response.body.toLowerCase();

    var carboidratos = getAllNumbers('carboidratos\\n', body);
    if(carboidratos == 0)
      carboidratos = getAllNumbers('carboidrato\\n', body);
    strCarboAlimento.text = carboidratos.toString();

    var proteinas = getAllNumbers('proteínas\\n', body);
    if(proteinas == 0)
      proteinas = getAllNumbers('proteinas\\n', body);
    if(proteinas == 0)
      proteinas = getAllNumbers('proteina\\n', body);
    strProteinaAlimento.text = proteinas.toString();

    var gordura = getAllNumbers('gorduras totais\\n', body);
    if(gordura == 0)
      gordura = getAllNumbers('gordura total\\n', body);
    if(gordura == 0)
      gordura = getAllNumbers('gordura\\n', body);
    if(gordura == 0)
      gordura = getAllNumbers('gorduras\\n', body);
    if(gordura == 0)
      gordura = getAllNumbers('gordura saturada\\n', body);
    if(gordura == 0)
      gordura = getAllNumbers('gorduras saturadas\\n', body);
    if(gordura == 0)
      gordura = getAllNumbers('gordura trans\\n', body);
    if(gordura == 0)
      gordura = getAllNumbers('gorduras trans\\n', body);
    strGorduraAlimento.text = gordura.toString();
  }

  int getAllNumbers(String search, String texto){
    try {
      int i = texto.indexOf(search) + search.length;
      String textoNumerico = "";
      for (; int.tryParse(texto[i]) != null; i++) {
        textoNumerico += texto[i];
      }
      return int.tryParse(textoNumerico) ?? 0;
    }
    catch(ex){
      return 0;
    }
  }

  _openCamera(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TakePictureScreen(lerImagem: lerImagem,),
            fullscreenDialog: true,
        )
    );
  }

  AtualizarLista (String? texto) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idUsuario = prefs.getString('currentUser');

    if(widget.indice > widget.listRefeicao.length - 1) {
      widget.listRefeicao.add(
          Refeicao(idUsuario: idUsuario!,
              nome: "",
              alimento: strNomeAlimento.text,
              carbo: strCarboAlimento.text,
              proteina: strProteinaAlimento.text,
              gordura: strGorduraAlimento.text,
              data: DateTime.now()));
    }
    else {
      widget.listRefeicao[widget.indice].alimento = strNomeAlimento.text;
      widget.listRefeicao[widget.indice].carbo = strCarboAlimento.text;
      widget.listRefeicao[widget.indice].proteina = strProteinaAlimento.text;
      widget.listRefeicao[widget.indice].gordura = strGorduraAlimento.text;
    }
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
      onChanged: AtualizarLista,
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
      onChanged: AtualizarLista,
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
      onChanged: AtualizarLista,
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
