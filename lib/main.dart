import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pos/auth/auth_service.dart';
import 'package:pos/constants/routes.dart';
import 'package:pos/constants/test_data.dart';
import 'package:pos/views/admin/notifications.dart';
import 'package:pos/views/authtification/verify.dart';
import 'package:pos/views/chiefs/kitchen.dart';
import 'package:pos/views/home/workers.dart';
import 'package:pos/views/waiters/tables.dart';
import 'package:flutter/services.dart';
import 'views/authtification/login.dart';
import 'views/authtification/register.dart';
import 'views/admin/admin.dart';
import 'views/home/router.dart';

void main() {
  //initialize the menu items category
  menu.allCategory();
  NotificationService().initNotification();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp( MyApp()));
  runApp( MyApp());
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
            final users = FirebaseAuth.instance.currentUser;
            if (users != null) {
              if (users.emailVerified) {
                return const WorkersView();
              } else {
                return const VerifyView();
              }
            } else {
              return const RouteView();
            }

          default:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
        }
      },
    );
  }
}

var pageRouteIndex = 0;

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void refresh() {
    pageRouteIndex++;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cafe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: cols),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: cols, //<-- SEE HERE
              displayColor: cols,
            ),
      ),
      home: pageRouteIndex==0 ?TableView(
              buildParent: refresh,
            ): const HomePage(),
      themeMode: ThemeMode.light,
      routes: {
        mainRoute: (context) => const RouteView(),
        registerRoute: (context) => const RegisterView(),
        verifyRoute: (context) => const VerifyView(),
        loginRoute: (context) => const LoginView(),
        waiterRoute: (context) => const WorkersView(),
        kitchenRoute: (context) => const KitchenView(),
        adminRoute: (context) => const AdminView(),
        tableRoute: (context) => TableView(
              buildParent: refresh,
            ),
      },
    );
  }
}
