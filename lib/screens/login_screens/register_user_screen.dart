import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/button_custom.dart';
import '../../widgets/textfield_custom.dart';

class RegisterUserScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String name = '';
  String phone = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/BackgroundMovies.png'),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7 )
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 100, 20, 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/Logo.png",
                          width: 110,
                          height: 120,
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Cadastre-se",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFieldCustom(
                          hint: "Nome",
                          icon: Icon(Icons.person, color: Colors.grey[400]),
                          onChanged: (value) {
                            name = value;
                          },
                          obscure: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o nome completo';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFieldCustom(
                          hint: "Telefone",
                          icon: Icon(Icons.phone, color: Colors.grey[400]),
                          onChanged: (value) {
                            phone = value;
                          },
                          obscure: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o telefone';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFieldCustom(
                          hint: "Email",
                          icon: Icon(Icons.email, color: Colors.grey[400]),
                          onChanged: (value) {
                            email = value;
                          },
                          obscure: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFieldCustom(
                          hint: "Senha",
                          icon: Icon(Icons.password, color: Colors.grey[400]),
                          onChanged: (value) {
                            password = value;
                          },
                          obscure: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira a senha';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 100),
                        ButtonCustom(
                          textButton: 'CADASTRAR',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print("Vampos inválidos");
                            }
                            try {
                              final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                              if (newUser != null) {
                                await _firestore
                                    .collection('users')
                                    .doc(newUser.user!.uid)
                                    .set({
                                  'name': name,
                                  'phone': phone,
                                  'email': email,
                                });
                                Navigator.pushReplacementNamed(
                                    context, '/home');
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Register'),
  //     ),
  //     body: Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Column(
  //         children: <Widget>[
  //           TextField(
  //             onChanged: (value) {
  //               name = value;
  //             },
  //             decoration: InputDecoration(hintText: 'Name'),
  //           ),
  //           TextField(
  //             onChanged: (value) {
  //               phone = value;
  //             },
  //             decoration: InputDecoration(hintText: 'Phone'),
  //           ),
  //           TextField(
  //             onChanged: (value) {
  //               email = value;
  //             },
  //             decoration: InputDecoration(hintText: 'Email'),
  //           ),
  //           TextField(
  //             obscureText: true,
  //             onChanged: (value) {
  //               password = value;
  //             },
  //             decoration: InputDecoration(hintText: 'Password'),
  //           ),
  //           ElevatedButton(
  //             child: Text('Register'),
  //             onPressed: () async {
  //               try {
  //                 final newUser = await _auth.createUserWithEmailAndPassword(
  //                     email: email, password: password);
  //                 if (newUser != null) {
  //                   await _firestore.collection('users').doc(newUser.user!.uid).set({
  //                     'name': name,
  //                     'phone': phone,
  //                     'email': email,
  //                   });
  //                   Navigator.pushReplacementNamed(context, '/movieList');
  //                 }
  //               } catch (e) {
  //                 print(e);
  //               }
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}