import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_booking_screens/movie_check_screen.dart';
import 'package:movie_app/widgets/button_custom.dart';

import '../../widgets/button_back_custom.dart';

class MovieTheaterSeatsScreen extends StatelessWidget {
  final int id;
  final String session;
  final String cinema;

  MovieTheaterSeatsScreen({required this.id, required this.session, required this.cinema});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SeatSelectionScreen(id: id, session: session, cinema: cinema),
      ),
    );
  }
}

class SeatSelectionScreen extends StatefulWidget {
  final int id;
  final String session;
  final String cinema;
  SeatSelectionScreen({
    required this.id,
    required this.session,
    required this.cinema
  });

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState(
      id: id,
      session: session,
      cinema: cinema
  );
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  List<List<bool>> seatStatus = List.generate(7, (_) => List.generate(6, (_) => false));
  List<String> selectedSeats = [];
  final int id;
  final String session;
  final double seatPrice = 35.0;
  double totalPrice = 0.0;

  final String cinema;

  _SeatSelectionScreenState({
    required this.id,
    required this.session,
    required this.cinema
  });

  Widget buildSeat(int row, int col) {
    String seatLabel = String.fromCharCode(65 + col) + (row + 1).toString();
    bool isSelected = seatStatus[row][col];

    return GestureDetector(
      onTap: () {
        setState(() {
          seatStatus[row][col] = !seatStatus[row][col];
          // selectedSeat = isSelected ? '' : seatLabel;
          if (seatStatus[row][col]) {
            selectedSeats.add(seatLabel);
            totalPrice += seatPrice;
          }
        });
      },
      child: Container(
        margin: EdgeInsets.all(6),
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.amber : Colors.white70,
        ),
        child: Center(
          child: Text(
            seatLabel,
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    "Escolher assento",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  )
                ],
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    // Grade de cadeiras
                    Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: AssetImage('assets/images/cardBG.png'),
                              fit: BoxFit.cover,
                            )
                        ),
                        width: 340.0,
                        height: 560.0,
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(12)
                                ),
                                height: 30,
                                width: 280,
                                child: Center(
                                  child: Text(
                                      "Tela"
                                  ),
                                )
                            ),
                            Expanded(
                              child: GridView.builder(
                                padding: EdgeInsets.all(42),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                ),
                                itemCount: 35,
                                itemBuilder: (context, index) {
                                  int row = index ~/ 5;
                                  int col = index % 5;
                                  return buildSeat(row, col);
                                },
                              ),
                            ),
                            Divider(
                              color: Colors.grey, // Cor da linha
                              height: 20, // Altura do espaço acima e abaixo da linha
                              thickness: 1, // Espessura da linha
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white70,
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        height: 20,
                                        width: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Ocupados",
                                        style: TextStyle(color: Colors.white70),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius: BorderRadius.circular(8)
                                        ),
                                        height: 20,
                                        width: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        "Selecionados",
                                        style: TextStyle(color: Colors.white70),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                    // Texto mostrando a cadeira selecionada
                    // Row (
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.all(16.0),
                    //       child: Text(
                    //         selectedSeat.isNotEmpty
                    //             ? 'Cadeira Selecionada: $selectedSeat'
                    //             : 'Nenhuma cadeira selecionada',
                    //         style: TextStyle(fontSize: 14),
                    //       ),
                    //     ),
                    //     TextButton(
                    //         onPressed: () {
                    //           Navigator.of(context).push(
                    //               MaterialPageRoute(builder: (ctx) => MovieCheckScreen(selectedSeat: selectedSeat, id: id, session: session))
                    //           );
                    //         },
                    //         child: Text("PRÓXIMO")
                    //     )
                    //   ],
                    // )
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              selectedSeats.isNotEmpty
                                  ? 'Cadeira Selecionada: $selectedSeats'
                                  : 'Nenhuma cadeira selecionada',
                              style: TextStyle(fontSize: 14, color: Colors.white70),
                            ),
                            SizedBox(height: 30),
                            ButtonCustom(
                              textButton: "Reservar agora",
                              onPressed: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (ctx) => MovieCheckScreen(
                                        selectedSeats: selectedSeats,
                                        id: id,
                                        session: session,
                                        totalPrice: totalPrice,
                                        cinema: cinema
                                    ))
                                );
                              },
                            )
                          ],
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}