import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_jwt/models/users.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();
  bool allcheck = true;
  User user = User('', '');
  String checkpoint;

  Future save() async {
    var res = await http.post(
        Uri.parse('https://auth-node-f.herokuapp.com/login'),
        headers: <String, String>{
          'context-Type': 'application/json;charSet=UT-8'
        },
        body: <String, String>{
          'email': user.email,
          'password': user.password
        });
    return res.body.isEmpty ? null : res.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            'images/Colorful-Stingrays.svg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Container(
            alignment: Alignment.center,
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  Text(
                    'SignIn',
                    style: GoogleFonts.pacifico(
                      fontWeight: FontWeight.bold,
                      fontSize: 70,
                      color: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: TextEditingController(text: user.email),
                      onChanged: (value) {
                        user.email = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return '*required';
                        }
                        return EmailValidator.validate(value)
                            ? null
                            : "Please enter a valid email";
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Your Email',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue[900]),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue[900]),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: TextEditingController(text: user.password),
                      onChanged: (value) {
                        user.password = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return '*required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter Your Password',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      height: 50,
                      width: 400,
                      child: FlatButton(
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            print('ok');
                            String checkpoint1 =
                                await save().then((value) => value.toString());
                            print(checkpoint1);
                            if (checkpoint1.isNotEmpty &
                                (checkpoint1.contains('Enter')| checkpoint1.contains('Password') | checkpoint1.contains('Email'))) {
                              setState(() {
                                allcheck = false;
                                checkpoint = checkpoint1;
                              });
                            } else {
                              setState(() {
                                allcheck = true;
                                checkpoint = 'SigmUp Done';
                                Navigator.pushNamed(context, '/contain');
                              });
                            }
                          } else {
                            print('nok');
                            // save();
                          }
                        },
                        child: Container(
                          child: Text(
                            'SignIn',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  allcheck
                      ? Center(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Not have Account ?'),
                              ),
                              InkWell(
                                child: Text(
                                  'SignUp',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(context, '/');
                                },
                              )
                            ],
                          ),
                        )
                      : ResponseMessage(checkpoint),
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text('Not have Account ?'),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ResponseMessage extends StatelessWidget {
  final String response;
  ResponseMessage(this.response);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: Container(
        child: Column(
          children: [
            Text(
              response,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.red[400]),
            ),
            InkWell(
              child: Text(
                'SignUp',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            )
          ],
        ),
      ),
    );
  }
}

