import 'package:destek_talep_app/firebase_options.dart';
import 'package:destek_talep_app/helpers/app_colors.dart';
import 'package:destek_talep_app/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

final theme = ThemeData(
  useMaterial3: true,
  /* colorScheme: ColorScheme.fromSeed(
    //seedColor: const Color.fromARGB(255, 232, 119, 23),
    seedColor: const Color.fromARGB(255, 0, 55, 109),
  ),*/
  textTheme: GoogleFonts.kanitTextTheme(),
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
