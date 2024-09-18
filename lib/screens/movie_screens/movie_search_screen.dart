import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/movie_screens/movie_list_screen.dart';

class MovieSearchScreen extends StatelessWidget {
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
          Row(
            children: [
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(builder: (ctx) => MovieListScreen(user: user))
              //     )
              //   },
              //   child: Padding(
              //     padding: EdgeInsets.all(20),
              //     child: Container(
              //       padding: EdgeInsets.all(12.0),
              //       decoration: BoxDecoration(
              //           color: Color(0xff434856),
              //           borderRadius: BorderRadius.circular(30)
              //       ),
              //       child: Icon(
              //         Icons.arrow_back,
              //         color: Colors.white70,
              //         size: 30,
              //       ),
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Pesquisar filmes",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                )
              )
            ],
          ),
          Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
          ),
        ],
      )
    );
  }
}