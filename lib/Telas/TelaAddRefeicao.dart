import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/Entidades/Refeicao.dart';

import 'RefeicaoItem.dart';

class ItemRefeicao {
  TextEditingController nome;
  TextEditingController alimento;
  TextEditingController carbo;
  TextEditingController proteina;
  TextEditingController gordura;

  // Add any additional properties you need

  ItemRefeicao({
    required this.nome,
    required this.alimento,
    required this.carbo,
    required this.proteina,
    required this.gordura,
    // Initialize additional properties here
  });
}

class TelaAddRefeicao extends StatefulWidget {
  @override
  _TelaAddRefeicaoState createState() => _TelaAddRefeicaoState();
}

class _TelaAddRefeicaoState extends State<TelaAddRefeicao> {
  final strNomeNumeroRefeicao = TextEditingController();
  List<Widget> textFormFields = [];
  List<ItemRefeicao> listItemRefeicao = [];
  final List<Refeicao> listRefeicao = [];

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

  Widget _addalimento() {
    return ElevatedButton(
      child: Icon(Icons.add_circle),
      onPressed: () {
        // Adiciona um novo TextFormField à lista
        setState(() {
          textFormFields.add(RefeicaoItem(listRefeicao: listRefeicao, indice: textFormFields.length));
        });
      },
    );
  }

  Widget _salvarRefeicao() {
    return ElevatedButton(
      child: Text('Salvar'),
      onPressed: () {
        _saveRefeicao(context);
      },
    );
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      textFormFields.add(RefeicaoItem(listRefeicao: listRefeicao, indice: textFormFields.length));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar refeição'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
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
            Column(
              children: textFormFields,
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
            Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                children: <Widget>[
                  _salvarRefeicao(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _saveRefeicao(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idUsuario = prefs.getString('currentUser');
    print('tamanho lista na hora de salvar');
    print(listRefeicao.length);
    if (idUsuario != null) {
      listRefeicao.forEach((element) async {
        element.nome = strNomeNumeroRefeicao.text;
        print(element.nome);
        print(element.alimento);
        print(element.carbo);
        print(element.gordura);
        print(element.proteina);

        await FirebaseFirestore.instance
            .collection("refeicoes")
            .add(element.toJson());

        if(listRefeicao.indexOf(element) == listRefeicao.length - 1)
          Navigator.of(context).pushNamedAndRemoveUntil('/TelaMenu', (r) => false);
      });
    }
  }

}
