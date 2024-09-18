import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/widgets/button_back_custom.dart';
import 'package:movie_app/widgets/movie_theater_item.dart';

class MovieTheatersScreen extends StatelessWidget {
  final int id;
  final int runtime;
  final CollectionReference cinemas = FirebaseFirestore.instance.collection("cinemas");

  MovieTheatersScreen({
    required this.id,
    required this.runtime
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
            Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ButtonBackCustom(padButton: 10.0),
                        Text(
                          "Cinemas disponíveis",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: StreamBuilder(
                          stream: cinemas.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(child: Text('Erro ao carregar dados'));
                            }
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            if (!snapshot.hasData || snapshot.data == null) {
                              return Center(child: Text('Nenhum dado disponível'));
                            }
                            else {
                              final data = snapshot.requireData;
                              return ListView.builder(
                                  itemCount: data.size,
                                  itemBuilder: (context, index) {
                                    var movieTheater = data.docs[index];
                                    var cinema = movieTheater['cinema'];
                                    var localizacao = movieTheater['localizacao'];

                                    return MovieTheaterItem(
                                      id: id,
                                      cinema: cinema,
                                      localizacao: localizacao,
                                      runtime: runtime,
                                    );
                                  }
                              );
                            }
                          }
                      ),
                    )
                  ],
                )
            )
          ],
        )
    );
  }
}