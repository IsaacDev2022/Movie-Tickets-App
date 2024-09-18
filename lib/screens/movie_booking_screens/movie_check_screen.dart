import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/screens/movie_booking_screens/movie_payment_screen.dart';
import 'package:movie_app/utils/convert_hours.dart';
import 'package:movie_app/widgets/button_custom.dart';
import 'package:provider/provider.dart';

import '../../providers/movie_provider.dart';
import '../../widgets/button_back_custom.dart';

class MovieCheckScreen extends StatelessWidget {
  final List<String> selectedSeats;
  final String session;
  final int id;
  final double totalPrice;
  final String cinema;

  String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  MovieCheckScreen({
    required this.selectedSeats,
    required this.id,
    required this.session,
    required this.totalPrice,
    required this.cinema,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: Provider.of<MovieProvider>(context, listen: false).fetchMovieDetail(id),
            builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<MovieProvider>(
            builder: (ctx, movieProvider, _) => Stack(
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
                              "Checkout",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: Color(0x4DAFA6A6),
                                        borderRadius: BorderRadius.circular(16)
                                    ),
                                    height: 450,
                                    width: 340,
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
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
                                              SizedBox(width: 20),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 150,
                                                    child: Text(
                                                      movieProvider.selectedMovie!.title,
                                                      style: TextStyle(
                                                          color: Colors.white70,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 22
                                                      ),
                                                      maxLines: null,
                                                      overflow: TextOverflow.visible,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Action, Adventure",
                                                    style: TextStyle(
                                                        color: Colors.white54,
                                                        fontSize: 14
                                                    ),
                                                  ),
                                                  Text(
                                                    convertToHours(movieProvider.selectedMovie!.runtime),
                                                    style: TextStyle(
                                                        color: Colors.white54,
                                                        fontSize: 14
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "CINEMA",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 14
                                                ),
                                              ),
                                              Text(
                                                "${cinema}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "DATE",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 14
                                                ),
                                              ),
                                              Text(
                                                "${formattedDate}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "TIME",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 14
                                                ),
                                              ),
                                              Text(
                                                session,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "SEATS",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 14
                                                ),
                                              ),
                                              Text(
                                                "${selectedSeats}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.grey, // Cor da linha
                                            height: 20, // Altura do espaço acima e abaixo da linha
                                            thickness: 1, // Espessura da linha
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "TYPE",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 14
                                                ),
                                              ),
                                              Text(
                                                "Inteira",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Preço",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontSize: 14
                                                ),
                                              ),
                                              Text(
                                                "R\$ 35.00",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "TOTAL",
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16
                                                ),
                                              ),
                                              Text(
                                                "R\$ ${totalPrice}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                ),
                                ButtonCustom(
                                  textButton: "Comprar",
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (ctx) => MoviePaymentScreen(
                                          movieName: movieProvider.selectedMovie!.title,
                                          session: session,
                                          seat: selectedSeats,
                                          id: id,
                                          totalPrice: totalPrice,
                                          cinema: cinema,
                                          date: formattedDate,
                                        ))
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        ),
                      ],
                    )
                ),
              ],
            ),

            //     Padding(
            //   padding: EdgeInsets.all(16.0),
            //   child: Column(
            //     children: [
            //       Image.network(
            //         'https://image.tmdb.org/t/p/w500${movieProvider.selectedMovie!.posterPath}',
            //         width: 120,
            //         height: 220,
            //         fit: BoxFit.cover,
            //       ),
            //       Text(movieProvider.selectedMovie!.title),
            //       Text(movieProvider.selectedMovie!.overview),
            //       Text("Cadeira selecionada: $selectedSeat"),
            //       Text("Horário da sessão: $session"),
            //       TextButton(
            //           onPressed: () {
            //             Navigator.of(context).push(
            //               MaterialPageRoute(builder: (ctx) => MoviePaymentScreen(
            //                 movieName: movieProvider.selectedMovie!.title,
            //                 session: session,
            //                 seat: selectedSeat,
            //               ))
            //             );
            //           },
            //           child: Text("PROXIMO")
            //       )
            //     ],
            //   ),
            // )
          ),
        )
      )
    );
  }
}