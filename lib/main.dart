import 'package:flutter/material.dart';
import 'package:market_watch/screens/splash.dart';
import 'package:market_watch/state/app_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MarketWatch());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
  ));
}

class MarketWatch extends StatefulWidget {
  const MarketWatch({Key? key}) : super(key: key);

  @override
  _MarketWatchState createState() => _MarketWatchState();
}

class _MarketWatchState extends State<MarketWatch> {
  User? user;
  bool authed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _light = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      splashColor: const Color(0xFF7DCEFB),
      textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
    );

    ThemeData _dark = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      splashColor: const Color(0xFF7DCEFB),
      textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
    );

    return AppStateWidget(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Market Watch',
        theme: _light,
        darkTheme: _dark,
        home: const Splash(),
      ),
    );
  }
}
