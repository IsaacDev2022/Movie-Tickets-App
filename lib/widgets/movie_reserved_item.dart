import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movie_provider.dart';

class MovieReservedItem extends StatelessWidget {
  final int id;
  final String cinema;
  final String date;
  final String movieName;
  final String session;

  MovieReservedItem({
    required this.id,
    required this.cinema,
    required this.date,
    required this.movieName,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0x80434856),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            FutureBuilder(
            future: Provider.of<MovieProvider>(context, listen: false).fetchMovieDetail(id),
              builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : Consumer<MovieProvider>(
                  builder: (ctx, movieProvider, _) => Container(
                      height: 120,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage('https://image.tmdb.org/t/p/w500${movieProvider.selectedMovie!.posterPath}'),
                          fit: BoxFit.cover,
                        ),
                      )
                  ),
              )
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  child: Text(
                    "${movieName}",
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                    maxLines: null,
                    overflow: TextOverflow.visible,
                  ),
                ),
                Text(
                  "${cinema}",
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14
                  ),
                ),
                Text(
                  "${date}",
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14
                  ),
                ),
                Text(
                  "${session}",
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}