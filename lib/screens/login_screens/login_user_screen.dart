import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_tickets_app/screens/login_screens/register_user_screen.dart';

import '../../utils/animation_transition.dart';
import '../../widgets/button_custom.dart';
import '../../widgets/textfield_custom.dart';
import '../home_screen.dart';

class LoginUserScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
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
                           "Logue na sua conta",
                           style: TextStyle(
                               color: Colors.white,
                               fontSize: 26,
                               fontWeight: FontWeight.bold
                           ),
                         ),
                         SizedBox(height: 20),
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
                         SizedBox(height: 10),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Row(
                               children: [
                                 CheckboxWidget(),
                                 Text(
                                   "Lembrar de mim",
                                   style: TextStyle(color: Colors.white),
                                 ),
                               ],
                             ),
                             Text(
                               "Esqueceu a senha?",
                               style: TextStyle(color: Colors.amber),
                             )
                           ],
                         ),
                         SizedBox(height: 30),
                         ButtonCustom(
                           textButton: 'CONFIRMAR',
                           onPressed: () async {
                             try {
                               if (_formKey.currentState!.validate()) {
                                 print("Vampos inválidos");
                               }
                               final user = await _auth
                                   .signInWithEmailAndPassword(
                                   email: email, password: password);
                               if (user != null) {
                                 // Navigator.pushReplacementNamed(context, '/home');
                                 Navigator.of(context).push(createRoute());
                               }
                             } catch (e) {
                               print(e);
                             }
                           },
                         ),
                         SizedBox(height: 30),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Container(
                               height: 60,
                               width: 60,
                               child: Image.asset(
                                 "assets/images/Facebook-logo.png",
                                 width: 40,
                                 height: 40,
                               ),
                               decoration: BoxDecoration(
                                   color: Colors.grey[800],
                                   borderRadius: BorderRadius.circular(10)
                               ),
                             ),
                             Container(
                               height: 60,
                               width: 60,
                               child: Image.asset(
                                 "assets/images/Google-logo.png",
                                 width: 40,
                                 height: 40,
                               ),
                               decoration: BoxDecoration(
                                   color: Colors.grey[800],
                                   borderRadius: BorderRadius.circular(10)
                               ),
                             ),
                             Container(
                               height: 60,
                               width: 60,
                               child: Image.asset(
                                 "assets/images/Apple-logo.png",
                                 width: 40,
                                 height: 40,
                               ),
                               decoration: BoxDecoration(
                                   color: Colors.grey[800],
                                   borderRadius: BorderRadius.circular(10)
                               ),
                             ),
                           ],
                         ),
                         SizedBox(height: 30),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text(
                               "Não possui conta?",
                               style: TextStyle(
                                   fontSize: 14,
                                   color: Colors.white
                               ),
                             ),
                             SizedBox(width: 5),
                             LinkRegister()
                           ],
                         )
                       ],
                     ),
                   )
                 )
             )
           )
          ],
        )
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Login'),
  //     ),
  //     body: Padding(
  //       padding: EdgeInsets.all(16.0),
  //       child: Column(
  //         children: <Widget>[
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
  //             child: Text('Login'),
  //             onPressed: () async {
  //               try {
  //                 final user = await _auth.signInWithEmailAndPassword(
  //                     email: email, password: password);
  //                 if (user != null) {
  //                   Navigator.pushReplacementNamed(context, '/movieList');
  //                 }
  //               } catch (e) {
  //                 print(e);
  //               }
  //             },
  //           ),
  //           TextButton(
  //             child: Text('Register'),
  //             onPressed: () {
  //               Navigator.push(context, MaterialPageRoute(
  //                 builder: (context) => RegisterUserScreen(),
  //               ));
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

// Checkbox ********************************************
class CheckboxWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Checkbox(
        checkColor: Colors.white,
        side: MaterialStateBorderSide.resolveWith(
              (states) => BorderSide(width: 1.0, color: Colors.white),
        ),
        value: isChecked,
        activeColor: Colors.orange,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
      ) ,
    );
  }
}

// LinkRegister ********************************************
class LinkRegister extends StatefulWidget {
  @override
  _LinkRegisterState createState() => _LinkRegisterState();
}

class _LinkRegisterState extends State<LinkRegister> {
  bool _isClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isClicked = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isClicked = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isClicked = false;
        });
      },
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => RegisterUserScreen())
        );
      },
      child: Text(
        "Cadastre-se agora",
        style: TextStyle(
            fontSize: 14,
            color: _isClicked ? Colors.orange : Colors.amber,
            decoration: _isClicked ? TextDecoration.underline : TextDecoration.none,
            fontWeight: _isClicked ? FontWeight.bold : FontWeight.normal
        ),
      ),
    );
  }
}

