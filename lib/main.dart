import 'package:flutter/material.dart';
import 'package:pos/auth/auth_service.dart';
import 'package:pos/constants/routes.dart';
import 'package:pos/views/authtification/verify.dart';
import 'package:pos/views/home/workers.dart';

import 'views/authtification/login.dart';
import 'views/authtification/register.dart';
import 'views/home/admin.dart';
import 'views/home/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
    ),
    home: const HomePage(),
    routes: {
      mainRoute: (context) => const RouteView(),
      registerRoute: (context) => const RegisterView(),
      verifyRoute: (context) => const VerifyView(),
      loginRoute: (context) => const LoginView(),
      waiterRoute: (context) => const WorkersView(),
      adminRoute: (context) => const AdminView(),
    },
  ));
}

//our homepage
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return const RouteView();
          default:
            return const Scaffold(
              body: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
