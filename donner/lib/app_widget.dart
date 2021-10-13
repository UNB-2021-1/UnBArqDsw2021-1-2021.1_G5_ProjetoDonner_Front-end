import 'package:donner/models/client_model.dart';
import 'package:donner/screens/edit_profile_screen.dart';
import 'package:donner/screens/home_screen.dart';
import 'package:donner/screens/login_screen.dart';
import 'package:donner/screens/profile_screen.dart';
import 'package:donner/screens/register_screen.dart';
import 'package:donner/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  AppWidget();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: HomeScreen(),
      initialRoute: "/home",
      routes: {
        "/splash": (context) => const SplashScreen(),
        "/home": (context) => HomeScreen(
            user: ModalRoute.of(context)!.settings.arguments as ClientModel?),
        "/login": (context) => const LoginScreen(),
        "/register": (context) => RegisterScreen(
            user: ModalRoute.of(context)!.settings.arguments as User),
        "/profile": (context) => ProfileScreen(
            user: ModalRoute.of(context)!.settings.arguments as ClientModel),
        "/edit": (context) => EditProfileScreen(
            user: ModalRoute.of(context)!.settings.arguments as ClientModel),
      },
    );
  }
}