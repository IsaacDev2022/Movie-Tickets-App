import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_back_custom.dart';
import '../../widgets/button_custom.dart';

class UserProfileScreen extends StatelessWidget {
  late final User user;

  UserProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/screenBG.png'),
                    fit: BoxFit.cover
                )
            ),
          ),
          Row(
            children: [
              ButtonBackCustom(padButton: 20.0),
              Text(
                "Perfil",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              )
            ],
          ),
          FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    var userData = snapshot.data!;
                    return Padding(
                      padding: EdgeInsets.fromLTRB(20, 140, 20, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0x4DAFA6A6),
                                borderRadius: BorderRadius.circular(16)
                            ),
                            height: 360,
                            width: 340,
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage('assets/images/movie.jpg'),
                                      radius: 50,//Text
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.amber, // Cor de fundo amarelo
                                          shape: BoxShape.circle, // Define o formato como círculo
                                        ),
                                        child: Icon(
                                          Icons.camera_alt, // Ícone de câmera
                                          size: 20, // Tamanho do ícone
                                          color: Colors.white, // Cor do ícone
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "${userData['name']}",
                                  style: TextStyle(
                                    fontSize: 26,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey, // Cor da linha
                                  height: 20, // Altura do espaço acima e abaixo da linha
                                  thickness: 1, // Espessura da linha
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20),
                                    Text(
                                      "Email",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      "${userData['email']}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white70
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "Telefone",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      "Telefone: ${userData['phone']}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          ButtonCustom(
                            textButton: "Deslogar",
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                          )
                        ],
                      ),
                    );
                  } else {
                    return Center(child: Text('User data not found'));
                  }
                }
                return Center(child: CircularProgressIndicator());
              }
          ),
        ],
      )
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       body: FutureBuilder<DocumentSnapshot>(
  //         future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
  //         builder: (context, snapshot) {
  //           if (snapshot.connectionState == ConnectionState.done) {
  //             if (snapshot.hasData) {
  //               var userData = snapshot.data!;
  //               return Center(
  //                 child: Padding(
  //                   padding: EdgeInsets.fromLTRB(22, 100, 22, 0),
  //                   child: Column(
  //                     children: [
  //                       CircleAvatar(
  //                         backgroundColor: Color.fromARGB(255, 165, 255, 137),
  //                         radius: 60,
  //                         child: Text(
  //                           "A",
  //                           style: TextStyle(fontSize: 30.0, color: Colors.blue),
  //                         ), //Text
  //                       ),
  //                       SizedBox(height: 20),
  //                       Text(
  //                         "${userData['name']}",
  //                         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
  //                       ),
  //                       SizedBox(height: 20),
  //                       Text(
  //                         "Email: ${userData['email']}",
  //                         style: TextStyle(fontSize: 16),
  //                       ),
  //                       SizedBox(height: 20),
  //                       Text(
  //                         "Número de telefone: ${userData['phone']}",
  //                         style: TextStyle(fontSize: 16),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             } else {
  //               return Center(child: Text('User data not found'));
  //             }
  //           }
  //           return Center(child: CircularProgressIndicator());
  //         },
  //       ),
  //     )
  //   );
  // }
}