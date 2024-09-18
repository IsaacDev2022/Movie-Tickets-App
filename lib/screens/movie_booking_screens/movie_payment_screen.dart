import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_booking_screens/payment_success_screen.dart';
import 'package:movie_app/widgets/button_custom.dart';
import 'package:movie_app/widgets/textfield_custom.dart';

import '../../widgets/button_back_custom.dart';

class MoviePaymentScreen extends StatefulWidget {
  final String movieName;
  final String session;
  final List<String> seat;
  final int id;
  final double totalPrice;
  final String cinema;
  final String date;

  MoviePaymentScreen({
    required this.movieName,
    required this.session,
    required this.seat,
    required this.id,
    required this.totalPrice,
    required this.cinema,
    required this.date,
  });

  @override
  _MoviePaymentState createState() => _MoviePaymentState(
    movieName: movieName,
    session: session,
    seat: seat,
    id: id,
    totalPrice: totalPrice,
    cinema: cinema,
    date: date
  );
}

class _MoviePaymentState extends State<MoviePaymentScreen> {
  final _firestore = FirebaseFirestore.instance;
  String name = '';
  String validDate = '';
  String cvv = '';
  String cardNumber = '';

  final String movieName;
  final String session;
  final List<String> seat;
  final int id;
  final double totalPrice;
  final String cinema;
  final String date;

  final _formKey = GlobalKey<FormState>();

  _MoviePaymentState({
    required this.movieName,
    required this.session,
    required this.seat,
    required this.id,
    required this.totalPrice,
    required this.cinema,
    required this.date,
  });

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
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      ButtonBackCustom(padButton: 0.0),
                      SizedBox(width: 10),
                      Text(
                        "Dados de pagamento",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70
                        ),
                      )
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset('assets/images/creditCard.png'),
                            SizedBox(height: 16),
                            TextFieldCustom(
                              hint: "Nome no cartão",
                              icon: Icon(
                                Icons.person,
                                color: Colors.white70,
                              ),
                              onChanged: (value) {
                                name = value;
                              },
                              obscure: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira o nome completo no cartão';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            TextFieldCustom(
                              hint: "Número do cartão",
                              icon: Icon(
                                Icons.card_giftcard,
                                color: Colors.white70,
                              ),
                              onChanged: (value) {
                                cardNumber = value;
                              },
                              obscure: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira o número do cartão';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: TextFieldCustom(
                                    hint: "00/00/0000",
                                    icon: Icon(
                                      Icons.date_range,
                                      color: Colors.white70,
                                    ),
                                    onChanged: (value) {
                                      validDate = value;
                                    },
                                    obscure: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, insira a data';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  flex: 1,
                                  child: TextFieldCustom(
                                    hint: "CVV",
                                    icon: Icon(
                                      Icons.numbers,
                                      color: Colors.white70,
                                    ),
                                    onChanged: (value) {
                                      cvv = value;
                                    },
                                    obscure: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Por favor, insira o CVV';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 195),
                        ButtonCustom(
                          textButton: "Confirmar",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print("Vampos inválidos");
                            }
                            try {
                              CollectionReference movieBooking = _firestore.collection("movieBooking");
                              movieBooking.add({
                                'name': name,
                                'validDate': validDate,
                                'cvv': cvv,
                                'cardNumber': cardNumber,
                                'id': id,
                                'totalPrice': totalPrice,
                                'cinema': cinema,
                                'movieName': movieName,
                                'session': session,
                                'seat': seat,
                              });
                            } catch (e) {
                              print(e);
                            }
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx) => PaymentSuccessScreen(
                                    movieName: movieName,
                                    session: session,
                                    seat: seat,
                                    id: id,
                                    totalPrice: totalPrice,
                                    cinema: cinema,
                                    date: date
                                ))
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       body: Padding(
  //         padding: EdgeInsets.all(16.0),
  //         child: Column(
  //           children: [
  //             SizedBox(height: 50),
  //             Text(
  //               "Métodos de Pagamento",
  //               style: TextStyle(fontSize: 22),
  //             ),
  //             SizedBox(height: 20),
  //             TextField(
  //               onChanged: (value) {
  //                 name = value;
  //               },
  //               decoration: InputDecoration(
  //                 border: OutlineInputBorder(),
  //                 hintText: 'Nome completo',
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             TextField(
  //               onChanged: (value) {
  //                 cpf = value;
  //               },
  //               decoration: InputDecoration(
  //                 border: OutlineInputBorder(),
  //                 hintText: 'CPF',
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             TextField(
  //               onChanged: (value) {
  //                 email = value;
  //               },
  //               decoration: InputDecoration(
  //                 border: OutlineInputBorder(),
  //                 hintText: 'E-mail',
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             TextField(
  //               onChanged: (value) {
  //                 cardNumber = value;
  //               },
  //               decoration: InputDecoration(
  //                 border: OutlineInputBorder(),
  //                 hintText: 'Número do cartão',
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             ElevatedButton(
  //                 onPressed: () async {
  //                   try {
  //                     CollectionReference movieBooking = _firestore.collection("movieBooking");
  //                     movieBooking.add({
  //                       'name': name,
  //                       'cpf': cpf,
  //                       'email': email,
  //                       'cardNumber': cardNumber,
  //                       'movieName': movieName,
  //                       'session': session,
  //                       'seat': seat,
  //                     });
  //                   } catch (e) {
  //                     print(e);
  //                   }
  //                   Navigator.of(context).push(
  //                       MaterialPageRoute(builder: (ctx) => PaymentSuccessScreen())
  //                   );
  //                 },
  //                 child: Text("CONFIRMAR")
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}