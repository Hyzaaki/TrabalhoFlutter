import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:teste/Telas/TelaInicial.dart';

import 'TelaAddRefeicao.dart';
import 'TelaUsuario.dart';


class TelaMenu extends StatefulWidget {

  @override
  _TelaMenuState createState() => _TelaMenuState();
}

class _TelaMenuState extends State<TelaMenu> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [TelaInicial(), TelaUsuario()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Conta',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}