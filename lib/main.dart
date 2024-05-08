import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socail_media_app/view/screens/auth/dashboard.dart';
import 'package:socail_media_app/view/screens/auth/login_screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: CheckCurrentUser(),
    );
  }
}

class CheckCurrentUser extends StatefulWidget {
  const CheckCurrentUser({super.key});

  @override
  State<CheckCurrentUser> createState() => _CheckCurrentUserState();
}

class _CheckCurrentUserState extends State<CheckCurrentUser> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool isLoggedIn = false;

  Future<void> getCurrentUser() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getCurrentUser(),
          builder: ((context, snapshot) {
            if (firebaseAuth.currentUser != null) {
              return MyDashboard();
            } else {
              return LoginScreen();
            }
          })),
    );
  }
}
