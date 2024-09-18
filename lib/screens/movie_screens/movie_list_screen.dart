import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/movie_provider.dart';
import '../../../widgets/movie_item.dart';
import '../profile_screens/user_profile_screen.dart';

class MovieListScreen extends StatefulWidget {
  final User user;
  const MovieListScreen({required this.user, super.key});

  @override
  State<MovieListScreen> createState() => _movieListState(user: user);
}

class _movieListState extends State<MovieListScreen> {
  List<Map<String, String>> cardMovies = [];
  final User user;
  _movieListState({required this.user});

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
          Column(
            children: [
              FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var userData = snapshot.data!;
                      return Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Bem vindo, ${userData["name"]}",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (ctx) => UserProfileScreen(user: FirebaseAuth.instance.currentUser!))
                                );
                              },
                              child: CircleAvatar(
                                backgroundImage: AssetImage('assets/images/movie.jpg'),
                                radius: 30,//Text
                              ),
                            )
                          ],
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  }
              ),
              SizedBox(height: 30),
              Text(
                "O que você deseja assistir?",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                    future: Provider.of<MovieProvider>(context, listen: false)
                        .fetchMovies(),
                    builder: (ctx, snapshot) =>
                    snapshot.connectionState == ConnectionState.waiting
                        ? Center(child: CircularProgressIndicator())
                        : Consumer<MovieProvider>(
                      builder: (ctx, movieProvider, _) =>
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movieProvider.movies.length,
                          itemBuilder: (ctx, index) {
                            return MovieItem(movie: movieProvider.movies[index]);
                          },
                        )
                          // GridView.builder(
                          //     itemCount: movieProvider.movies.length,
                          //     itemBuilder: (ctx, index) => MovieItem(movieProvider.movies[index]),
                          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          //         crossAxisCount: 1,
                          //         childAspectRatio: 2 / 3
                          //     )
                          // ),
                    ),
                  )
              )
            ],
          ),
          // Carrossel
          // cardMovies.isEmpty
          //   ? Center(child: CircularProgressIndicator())
          //   : CarouselSlider(
          //       options: CarouselOptions(
          //         height: 400,
          //         enlargeCenterPage: true,
          //         autoPlay: true,
          //       ),
          //       items: cardMovies.map((movie) {
          //         return MovieItem(movie: movie);
          //       }).toList(),
          //     ),
        ],
      )
    );
  }


  // int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  // TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Index 0: Home',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 1: Business',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 2: School',
  //     style: optionStyle,
  //   ),
  // ];
  //
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: Text('Home'),
  //         actions: <Widget>[
  //           IconButton(
  //             icon: Icon(Icons.logout),
  //             onPressed: () async {
  //               await FirebaseAuth.instance.signOut();
  //               Navigator.pushReplacementNamed(context, '/login');
  //             },
  //           ),
  //         ],
  //         leading: Builder(
  //           builder: (context) {
  //             return IconButton(
  //               icon: const Icon(Icons.menu),
  //               onPressed: () {
  //                 Scaffold.of(context).openDrawer();
  //               },
  //             );
  //           },
  //         ),
  //       ),
  //       body: Padding(
  //           padding: EdgeInsets.all(15.0),
  //           child: Column(
  //             children: [
  //               Container(
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.all(Radius.circular(25.0)),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.grey.withOpacity(0.5),
  //                       spreadRadius: 2,
  //                       blurRadius: 5,
  //                       offset: Offset(0, 3), // changes position of shadow
  //                     ),
  //                   ],
  //                 ),
  //                 child: TextField(
  //                   decoration: InputDecoration(
  //                     hintText: 'Search...',
  //                     prefixIcon: Icon(Icons.search),
  //                     border: OutlineInputBorder(
  //                       borderRadius: BorderRadius.all(Radius.circular(25.0)),
  //                       borderSide: BorderSide.none,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 50),
  //               Expanded(
  //                 child: FutureBuilder(
  //                   future: Provider.of<MovieProvider>(context, listen: false).fetchMovies(),
  //                   builder: (ctx, snapshot) =>
  //                   snapshot.connectionState == ConnectionState.waiting
  //                       ? Center(child: CircularProgressIndicator())
  //                       : Consumer<MovieProvider>(
  //                     builder: (ctx, movieProvider, _) => GridView.builder(
  //                         itemCount: movieProvider.movies.length,
  //                         itemBuilder: (ctx, index) => MovieItem(movieProvider.movies[index]),
  //                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //                             crossAxisCount: 3,
  //                             childAspectRatio: 2 / 3
  //                         )
  //                     ),
  //                   ),
  //                 ),
  //               )
  //             ],
  //           )
  //       ),
  //     drawer: Drawer(
  //       child: ListView(
  //         padding: EdgeInsets.zero,
  //         children: [
  //           const DrawerHeader(
  //             decoration: BoxDecoration(
  //               color: Colors.blue,
  //             ),
  //             child: Column(
  //               children: [
  //                 CircleAvatar(
  //                   backgroundColor: Color.fromARGB(255, 165, 255, 137),
  //                   radius: 40,
  //                   child: Text(
  //                     "A",
  //                     style: TextStyle(fontSize: 30.0, color: Colors.blue),
  //                   ), //Text
  //                 ),
  //                 SizedBox(height: 10),
  //                 Text(
  //                   "Isaac Martins",
  //                   style: TextStyle(color: Colors.white),
  //                 )
  //               ],
  //             ),
  //           ),
  //           ListTile(
  //             title: const Text('Perfil'),
  //             selected: _selectedIndex == 0,
  //             onTap: () {
  //               // Update the state of the app
  //               _onItemTapped(0);
  //               // Then close the drawer
  //               Navigator.of(context).push(
  //                 MaterialPageRoute(builder: (ctx) => UserProfileScreen(user: FirebaseAuth.instance.currentUser!))
  //               );
  //             },
  //           ),
  //           ListTile(
  //             title: const Text('Home'),
  //             selected: _selectedIndex == 0,
  //             onTap: () {
  //               // Update the state of the app
  //               _onItemTapped(0);
  //               // Then close the drawer
  //               Navigator.pop(context);
  //             },
  //           ),
  //           ListTile(
  //             title: const Text('Filmes populares'),
  //             selected: _selectedIndex == 1,
  //             onTap: () {
  //               // Update the state of the app
  //               _onItemTapped(1);
  //               // Then close the drawer
  //               Navigator.pop(context);
  //             },
  //           ),
  //           ListTile(
  //             title: const Text('Filmes reservados'),
  //             selected: _selectedIndex == 2,
  //             onTap: () {
  //               // Update the state of the app
  //               _onItemTapped(2);
  //               // Then close the drawer
  //               Navigator.pop(context);
  //             },
  //           ),
  //           ListTile(
  //             title: const Text('Sair'),
  //             selected: _selectedIndex == 2,
  //             onTap: () {
  //               // Update the state of the app
  //               _onItemTapped(2);
  //               // Then close the drawer
  //               Navigator.pop(context);
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}