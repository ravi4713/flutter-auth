
import 'package:flutter/material.dart';
import 'package:flutter_auth_jwt/screens/contains.dart';
import 'package:flutter_auth_jwt/screens/signin.dart';
import 'package:flutter_auth_jwt/screens/signup.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home : SignUp(),
      initialRoute: '/',
      routes: {
        '/' : (context)=>SignUp(),
        '/signin':(context)=>SignIn(),
        '/contain' : (context) => Contain()
      },
    );
  }
}