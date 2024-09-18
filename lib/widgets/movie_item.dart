import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../screens/movie_screens/movie_detail_screen.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;

  MovieItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(16, 50, 16, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                      fit: BoxFit.cover
                  )
              ),
              width: 400.0,
              height: 400.0,
            ),
            Container(
                margin: EdgeInsets.fromLTRB(50, 360, 50, 0),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('assets/images/cardBG.png'),
                      fit: BoxFit.cover,
                    )
                ),
                width: 300.0,
                height: 170.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "${movie.voteAverage.ceilToDouble()}/10",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) => MovieDetailScreen(movie.id)),
                            );
                          },
                          child: Text(
                            "Ver detalhes",
                            style: TextStyle(color: Colors.black54),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber
                          ),
                        )
                      ],
                    )
                  ],
                )
            )
          ],
        )
    );
  }
}