import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/Entidades/Refeicao.dart';

import '../Entidades/Usuario.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  List<Refeicao> listaRefeicoes = [];

  Future listarRefeicoes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idUsuario = prefs.getString('currentUser');
    if (idUsuario != null) {
      var refeicoesSnapshot = await FirebaseFirestore.instance
          .collection('refeicoes')
          .where('idUsuario', isEqualTo: idUsuario)
          .get();
      refeicoesSnapshot.docs.forEach((refeicaoItem) {
        var r = Refeicao.fromJson(refeicaoItem.data());
        r.id = refeicaoItem.id;
        listaRefeicoes.add(r);
      });
      if (listaRefeicoes.isNotEmpty) {
        setState(() {
          listaRefeicoes = listaRefeicoes;
        });
      }
    }
  }

  @override
  void initState() {
    listarRefeicoes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('NUTRI DIARY'),
        ),
        body: listaRefeicoes
                .isNotEmpty // VALIDACAO SE TEM REFEICAO CADASTRADA OU NAO
            ? Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: listaRefeicoes.length,
                          itemBuilder: (BuildContext context, int index) {
                            Refeicao item = listaRefeicoes[index];
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ListTile(
                                        title: Text(item.nome),
                                        subtitle:
                                            Text('Quantidade das calorias'),
                                        trailing: InkWell(
                                            onTap: () => _deleteRefeicao(
                                                context,
                                                item.id as String,
                                                index),
                                            child: const Icon(Icons.remove, color: Colors.red)))));
                          }))
                ],
              )
            : Padding(
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
                            minimumSize:
                                MaterialStateProperty.all(Size(100, 70)),
                            // define o tamanho mínimo do botão
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(20)),
                            // define o preenchimento do botão
                            textStyle: MaterialStateProperty.all(TextStyle(
                                fontSize:
                                    50)), // define o estilo do texto do botão
                          ),
                        ),
                      ],
                    ),
                  ],
                )));
  }

  _deleteRefeicao(
      BuildContext context, String idRefeicao, int indexRefeicao) async {
    await FirebaseFirestore.instance
        .collection("refeicoes")
        .doc(idRefeicao)
        .delete();
    listaRefeicoes.removeAt(indexRefeicao);
    setState(() {
      listaRefeicoes = listaRefeicoes;
    });
  }
}
