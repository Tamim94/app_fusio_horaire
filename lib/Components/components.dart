import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// ici j'ai defini le BottomNavigationBar de l'app ( custom )
class BottomNavigationBar1 extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavigationBar1({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Accueil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Liste des fuseaux horaires',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}