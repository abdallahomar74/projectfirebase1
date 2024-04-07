import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projectfirebase1/auth/login.dart';
import 'package:projectfirebase1/auth/register.dart';
import 'package:projectfirebase1/category/add.dart';
import 'package:projectfirebase1/category/edit.dart';
import 'package:projectfirebase1/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyCLBmFL7_P3nJ5E_KtKUuZeXQ02lXV8dGg',
              appId: '1:832238855459:android:999ff65ec5adbd86941896',
              messagingSenderId: '832238855459',
              projectId: 'project1-11cdc'))
      : await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('======User is currently signed out!');
      } else {
        print('======User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: Colors.black,
              centerTitle: true,
              titleTextStyle: TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),
              // ignore: deprecated_member_use
              iconTheme: IconThemeData(color: Colors.orange))),
      debugShowCheckedModeBanner: false,
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? Homepage()
          : loginpage(),
      routes: {
        "signup": (context) => signuppage(),
        "homepage": (context) => Homepage(),
        "login": (context) => loginpage(),
        "addcategory": (context) => addnewcategory(),
      },
    );
  }
}
