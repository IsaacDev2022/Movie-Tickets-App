import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/movie_booking_screens/movie_theater_seats_screen.dart';

class MovieTheaterItem extends StatelessWidget {
  final List<String> sessionItems = List<String>.generate(6, (index) => "Item $index");
  final int id;
  final String cinema;
  final String localizacao;
  final int runtime;

  MovieTheaterItem({
    required this.id,
    required this.cinema,
    required this.localizacao,
    required this.runtime
  });

  List<String> generateCinemaSessions(int movieDurationMinutes) {
    List<String> sessions = [];
    DateTime startTime = DateTime(2024, 9, 4, 13, 0); // Início às 13:00
    DateTime endTime = DateTime(2024, 9, 4, 23, 0); // Término às 23:00
    int intervalMinutes = 30;

    while (true) {
      DateTime sessionEndTime = startTime.add(Duration(minutes: movieDurationMinutes));

      if (sessionEndTime.isAfter(endTime)) {
        break;
      }

      String formattedSession = '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';

      sessions.add(formattedSession);

      startTime = sessionEndTime.add(Duration(minutes: intervalMinutes));
    }

    return sessions;
  }

  @override
  Widget build(BuildContext context) {
    List<String> cinemaSessions = generateCinemaSessions(runtime);
    return GestureDetector(
      onTap: () {

      },
      child: Center(
        child: Card(
          color: Color(0x80434856),
            child: Column(
              children: [
                ListTile(
                  title: Text(
                      cinema,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      localizacao,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white70),
                    ),
                ),
                SizedBox(height: 4),
                Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                ),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.all(10),
                  // child: Wrap(
                  //   direction: Axis.horizontal,
                  //   children: cinemaSessions.map((session) {
                  //     return ConstrainedBox(
                  //       constraints: BoxConstraints(
                  //         minWidth: 100.0
                  //       ),
                  //       child: MovieSessionsItem(session, id)
                  //     );
                  //   }).toList()
                  // ),
                  child: Row(
                    children: [
                      MovieSessionsItem("13:00", id, cinema),
                      MovieSessionsItem("15:30", id, cinema),
                      MovieSessionsItem("17:00", id, cinema),
                      MovieSessionsItem("19:30", id, cinema),
                    ],
                  ),
                ),
              ],
            )
        ),
      )
    );
  }
}

class MovieSessionsItem extends StatelessWidget {
  String session;
  final int id;
  final String cinema;

  MovieSessionsItem(this.session, this.id, this.cinema);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) => MovieTheaterSeatsScreen(
            id: id,
            session: session,
            cinema: cinema
          ))
        );
      },
      child: Center(
        child: Card(
          color: Colors.amber,
          elevation: 4.0,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              session,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        )
      ),
    );
  }
}