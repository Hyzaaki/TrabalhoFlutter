import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Rotas.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
       ],
      supportedLocales: [const Locale('pt', 'BR')],
      title: "Aplicativo Nutri Diary",
      theme: ThemeData(primaryColor: Colors.green),
      onGenerateRoute: Rotas.generateRoute,
      initialRoute: '/',
    );
  }
}