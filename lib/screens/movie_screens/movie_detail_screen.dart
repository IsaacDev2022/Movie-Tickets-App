import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_booking_screens/movie_theaters_screen.dart';
import 'package:provider/provider.dart';

import '../../../providers/movie_provider.dart';
import '../../widgets/button_back_custom.dart';
import '../../widgets/button_custom.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;

  MovieDetailScreen(this.id);

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Movie Details'),
  //     ),
  //     body: FutureBuilder(
  //       future: Provider.of<MovieProvider>(context, listen: false).fetchMovieDetail(id),
  //       builder: (ctx, snapshot) =>
  //       snapshot.connectionState == ConnectionState.waiting
  //           ? Center(child: CircularProgressIndicator())
  //           : Consumer<MovieProvider>(
  //         builder: (ctx, movieProvider, _) => Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             children: [
  //               Image.network('https://image.tmdb.org/t/p/w500${movieProvider.selectedMovie!.posterPath}'),
  //               SizedBox(height: 20),
  //               Text(
  //                 movieProvider.selectedMovie!.title,
  //                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //               ),
  //               SizedBox(height: 10),
  //               Text(movieProvider.selectedMovie!.overview),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  String convertToHours(int minutes) {
    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;
    return '${hours}h ${remainingMinutes}m';
  }

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
          FutureBuilder(
            future: Provider.of<MovieProvider>(context, listen: false).fetchMovieDetail(id),
            builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<MovieProvider>(
                builder: (ctx, movieProvider, _) => Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50.0), // Raio no canto inferior esquerdo
                            bottomRight: Radius.circular(50.0), // Raio no canto inferior direito
                          ),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movieProvider.selectedMovie!.backdropPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        ButtonBackCustom(padButton: 20.0),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 300.0,
                                  child: Text(
                                    movieProvider.selectedMovie!.title,
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Color(0xFFF5F6F8),
                                        fontWeight: FontWeight.bold
                                    ),
                                    overflow: TextOverflow.fade,
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  width: 220.0,
                                  child: Text(
                                    convertToHours(movieProvider.selectedMovie!.runtime),
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF95989D)
                                    ),
                                    overflow: TextOverflow.fade,
                                    maxLines: 5,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Row (
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 30.0,
                                    ),
                                    SizedBox(width: 5.0),
                                    Container(
                                      width: 220.0,
                                      child: Text(
                                        "${movieProvider.selectedMovie!.voteAverage.ceilToDouble()}/10",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white
                                        ),
                                        overflow: TextOverflow.fade,
                                        maxLines: 5,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Divider(
                                  color: Colors.grey, // Cor da linha
                                  height: 20, // Altura do espaço acima e abaixo da linha
                                  thickness: 1, // Espessura da linha
                                ),
                                SizedBox(height: 15.0),
                                Container(
                                  width: 220.0,
                                  child: Text(
                                    "Sinopse",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                    overflow: TextOverflow.fade,
                                    maxLines: 5,
                                  ),
                                ),
                                SizedBox(height: 8.0),
                                Container(
                                  child: Text(
                                    movieProvider.selectedMovie!.overview,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF95989D)
                                    ),
                                    overflow: TextOverflow.fade,
                                    maxLines: 10 ,
                                  ),
                                ),
                              ],
                            ),
                            ButtonCustom(
                              textButton: 'Reservar',
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => MovieTheatersScreen(
                                    id: movieProvider.selectedMovie!.id,
                                    runtime: movieProvider.selectedMovie!.runtime,
                                  ),
                                ));
                              },
                            )
                          ],
                        ),
                      )
                    )
                  ],
                )
            ),
          ),
        ],
      )
    );
  }
}