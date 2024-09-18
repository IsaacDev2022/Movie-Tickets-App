import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_tickets_app/providers/movie_provider.dart';
import 'package:movie_tickets_app/screens/login_screens/login_user_screen.dart';
import 'package:movie_tickets_app/screens/login_screens/register_user_screen.dart';
import 'package:movie_tickets_app/screens/movie_booking_screens/movie_check_screen.dart';
import 'package:movie_tickets_app/screens/movie_booking_screens/movie_payment_screen.dart';
import 'package:movie_tickets_app/screens/movie_booking_screens/movie_theater_seats_screen.dart';
import 'package:movie_tickets_app/screens/movie_booking_screens/movie_theaters_screen.dart';
import 'package:movie_tickets_app/screens/movie_booking_screens/payment_success_screen.dart';
import 'package:movie_tickets_app/screens/movie_screens/home_screen.dart';
import 'package:movie_tickets_app/screens/movie_screens/movie_list_screen.dart';
import 'package:movie_tickets_app/screens/movie_screens/movie_reserved_screen.dart';
import 'package:movie_tickets_app/screens/movie_screens/movie_search_screen.dart';
import 'package:movie_tickets_app/screens/profile_screens/user_profile_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => MovieProvider(),
      child: MaterialApp(
        title: 'Movie App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginUserScreen(),
          '/register': (context) => RegisterUserScreen(),
          '/home': (context) => HomeScreen(),
          '/movieList': (context) => MovieListScreen(user: FirebaseAuth.instance.currentUser!),
          '/movieSearch': (context) => MovieSearchScreen(),
          '/userProfile': (context) => UserProfileScreen(user: FirebaseAuth.instance.currentUser!),
          '/movieTheaters': (context) => MovieTheatersScreen(id: 0, runtime: 0,),
          '/movieReserved': (context) => MovieReservedScreen(),
          '/movieSeater': (context) => MovieTheaterSeatsScreen(id: 0, session: '', cinema: '',),
          '/movieCheck': (context) => MovieCheckScreen(selectedSeats: const [""], id: 0, session: "", totalPrice: 0.0, cinema: '',),
          '/moviePayment': (context) => MoviePaymentScreen(movieName: "", session: "", seat: const [""], id: 0, totalPrice: 0.0, cinema: '', date: '',),
          '/moviePaymentSuccess': (context) => PaymentSuccessScreen(movieName: '', session: '', seat: [], id: 0, totalPrice: 0.0, cinema: '', date: '',),
        },
      ),
    );
  }
}