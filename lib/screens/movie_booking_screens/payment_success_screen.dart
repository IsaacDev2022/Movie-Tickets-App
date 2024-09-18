import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/movie_provider.dart';
import '../../utils/convert_hours.dart';
import '../../widgets/button_custom.dart';
import '../movie_screens/home_screen.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final String movieName;
  final String session;
  final List<String> seat;
  final int id;
  final double totalPrice;
  final String cinema;
  final String date;

  PaymentSuccessScreen({
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
                  Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
                        child: Column(
                          children: [
                            Image.asset('assets/images/success.png'),
                            SizedBox(height: 20),
                            Text(
                              "Pagamento feito com sucesso!",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.amber
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              height: 400,
                              width: 320,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14)),
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
                                            )),
                                        SizedBox(width: 20),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 150,
                                              child: Text(
                                                "${movieProvider.selectedMovie!.title}",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                ),
                                                overflow: TextOverflow.fade,
                                                maxLines: 2,
                                              ),
                                            ),
                                            Text(
                                              "Action, Adventure",
                                              style: TextStyle(
                                                  color: Colors.black54, fontSize: 14),
                                            ),
                                            Text(
                                              convertToHours(movieProvider.selectedMovie!.runtime),
                                              style: TextStyle(
                                                  color: Colors.black54, fontSize: 14),
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
                                              color: Colors.black54, fontSize: 14),
                                        ),
                                        Text(
                                          "${cinema}",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "DATE",
                                          style: TextStyle(
                                              color: Colors.black54, fontSize: 14),
                                        ),
                                        Text(
                                          "${date}",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "TIME",
                                          style: TextStyle(
                                              color: Colors.black54, fontSize: 14),
                                        ),
                                        Text(
                                          "${session}",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "SEATS",
                                          style: TextStyle(
                                              color: Colors.black54, fontSize: 14),
                                        ),
                                        Text(
                                          "${seat}",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "PRICE",
                                          style: TextStyle(
                                              color: Colors.black54, fontSize: 14),
                                        ),
                                        Text(
                                          "${totalPrice}",
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      // Cor da linha
                                      height: 20,
                                      // Altura do espaço acima e abaixo da linha
                                      thickness: 1, // Espessura da linha
                                    ),
                                    Image.asset("assets/images/Bar-code.png")
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 100),
                            ButtonCustom(
                              textButton: "Voltar",
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (ctx) => HomeScreen())
                                );
                              },
                            )
                          ],
                        ),
                      )
                  )
                ],
              )
        )
      )
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       body: Padding(
  //         padding: EdgeInsets.all(14.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               "PAGAMENTO BEM SUCEDIDO",
  //               style: TextStyle(fontSize: 23),
  //             ),
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).push(
  //                       MaterialPageRoute(builder: (ctx) => MovieListScreen())
  //                   );
  //                 },
  //                 child: Text(
  //                   "VOLTAR",
  //                   style: TextStyle(fontSize: 16),
  //                 )
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}