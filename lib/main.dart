import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/firebase_options.dart';
import 'package:instagram_clone/screens/splash_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
          colorScheme: ColorScheme.dark(background: mobileBackgroundColor),
          iconTheme: IconThemeData(color: primaryColor),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: primaryColor,
          )),
      home: SplashScreen(),
    );
  }
}
