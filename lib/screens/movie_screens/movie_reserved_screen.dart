import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/movie_reserved_item.dart';

class MovieReservedScreen extends StatelessWidget {
  final CollectionReference moviesReserved = FirebaseFirestore.instance.collection("movieBooking");

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
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Filmes reservados",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
                SizedBox(height: 40),
                Expanded(
                  child: StreamBuilder(
                      stream: moviesReserved.snapshots(),
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
                                var movieReserved = data.docs[index];
                                var id = movieReserved['id'];
                                var movieName = movieReserved['movieName'];
                                var cinema = movieReserved['cinema'];
                                var date = movieReserved['validDate'];
                                var session = movieReserved['session'];

                                return MovieReservedItem(
                                  id: id,
                                  movieName: movieName,
                                  cinema: cinema,
                                  date: date,
                                  session: session,
                                );
                              }
                          );
                        }
                      }
                  )
                )
              ],
            )
          )
        ],
      )
    );
  }
}