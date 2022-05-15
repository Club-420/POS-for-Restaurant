import 'package:flutter/material.dart';
import 'package:pos/auth/auth_service.dart';
import 'package:pos/constants/routes.dart';
import 'package:pos/views/authtification/verify.dart';
import 'package:pos/views/chiefs/kitchen.dart';
import 'package:pos/views/home/workers.dart';
import 'package:pos/views/waiters/tables.dart';

import 'views/authtification/login.dart';
import 'views/authtification/register.dart';
import 'views/admin/admin.dart';
import 'views/home/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
    ),
    home: const WorkersView(),
    routes: {
      mainRoute: (context) => const RouteView(),
      registerRoute: (context) => const RegisterView(),
      verifyRoute: (context) => const VerifyView(),
      loginRoute: (context) => const LoginView(),
      waiterRoute: (context) => const WorkersView(),
      kitchenRoute: (context) => const KitchenView(),
      adminRoute: (context) => const AdminView(),
      tableRoute: (context) => const TableView(),
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
