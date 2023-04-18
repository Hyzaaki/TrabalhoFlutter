import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TelaLogin extends StatefulWidget {

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final strName = TextEditingController();
  final strPassword = TextEditingController();

  Widget _logintxt() {
    return TextFormField(
      controller: strName,
      decoration: InputDecoration(
          hintText: "EMAIL",
          hintStyle: TextStyle(
            color: Colors.green,
            fontSize: 18.0,
          )),
    );
  }

  Widget _senhatxt() {
    return TextFormField(
        obscureText: true,
        controller: strPassword,
        decoration: InputDecoration(
            hintText: "SENHA",
            hintStyle: TextStyle(
              color: Colors.green,
              fontSize: 18.0,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             /* Image(
                image: AssetImage("assets/imagens/logo.jpeg"),
                height: 160.0,
                width: 160.0,
              ),
              */
              Card(
                elevation: 12.0,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      _logintxt(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _senhatxt(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                  child: Text('CONECTAR'),
                  onPressed: () {
                    _clickButton(context);
                    Navigator.pushNamed(context, '/TelaInicial');
                  }),
              Divider(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Não possui cadastro?",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/cadastro');
                    },
                    child: Text(
                      "Cadastre-se",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/redefinir');
                    },

                    child: Text(
                      "Esqueceu sua senha?",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.red,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
  }

  _clickButton(BuildContext context) async {
   /* var usuario =
    await SerializaLogin.serializarJson(strName.text, strPassword.text);
    if(usuario == null || usuario.Mensagem != 'Login efetuado com sucesso!') {
      alert(context, "Usuário e/ou Senha Inválidos!");
    }
    */
  }
  alert(BuildContext context, String msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Login"),
            content: Text(msg),
            actions: <Widget>[
              ElevatedButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
}
