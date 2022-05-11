import 'package:flutter/material.dart';
import 'package:pos/constants/routes.dart';

import 'views/authtification/login.dart';
import 'views/authtification/register.dart';
import 'views/home/admin.dart';
import 'views/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: homeRoute,
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        homeRoute: (context) => const HomeView(),
        adminRoute: (context) => const AdminView(),
      },
    );
  }
}
