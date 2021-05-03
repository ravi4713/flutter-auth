import 'package:flutter/material.dart';

class Contain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Nikal Chal Nikal',
          style: TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
    );
  }
}
