import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TelaInicial extends StatefulWidget {

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  bool temRefeicao = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('NUTRI DIARY'),
        ),
        body: temRefeicao // VALIDACAO SE TEM REFEICAO CADASTRADA OU NAO
            ?
            Column(
              children: [
                Expanded(child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                  title: Text('Aqui fica o nome da refeicao'),
                                  subtitle: Text('pode ter algo aqui ou nao fodas'),
                                  trailing: InkWell(
                                      onTap: () => true,
                                      child: const Icon(Icons.remove, color: Colors.red)
                                  )
                              )
                          )
                      );
                    }
                )
                )
              ],
            )
            :
            Padding(
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
            )
    );
  }
}