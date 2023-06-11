import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/Entidades/Refeicao.dart';

import '../Entidades/Usuario.dart';
import 'TelaUsuario.dart';

class TelaInicial extends StatefulWidget {
  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  List<Refeicao> listaRefeicoes = [];

  int _selectedIndex = 0;

  final List<Widget> _pages = [TelaInicial(), TelaUsuario()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        listaRefeicoes.sort((a, b) => a.data.compareTo(b.data));
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
    return
      Material(
        child: listaRefeicoes
            .isNotEmpty // VALIDACAO SE TEM REFEICAO CADASTRADA OU NAO
            ? Column(
          children: [
            Flexible(
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
                        subtitle: Text('Kcal:'),
                        trailing: InkWell(
                          onTap: () => _deleteRefeicao(
                            context,
                            item.id as String,
                            index,
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(context, '/TelaAddRefeicao');
              },
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(40, 40)),
                padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                textStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 50),
                ),
              ),
            ),
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
                        /*Navigator.pushNamed(context, '/TelaAddRefeicao');

                         */
                        Navigator.of(context).pushNamedAndRemoveUntil('/TelaAddRefeicao', (r) => false);
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
            )),
      );
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

/*
@override
Widget build(BuildContext context) {
  return Material(
    child: listaRefeicoes.isNotEmpty
        ? Column(
      children: [
        Flexible(
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
                    subtitle: Text('Kcal:'),
                    trailing: InkWell(
                      onTap: () => _deleteRefeicao(
                        context,
                        item.id as String,
                        index,
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/TelaAddRefeicao');
          },
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(Size(40, 40)),
            padding: MaterialStateProperty.all(EdgeInsets.all(20)),
            textStyle: MaterialStateProperty.all(
              TextStyle(fontSize: 50),
            ),
          ),
        ),
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
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/TelaAddRefeicao', (r) => false);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(100, 70)),
                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                  textStyle: MaterialStateProperty.all(
                    TextStyle(fontSize: 50),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}


 */