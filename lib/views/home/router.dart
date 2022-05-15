//we will just route the user to specific pages
import 'package:flutter/material.dart';
import 'package:pos/constants/routes.dart';

class RouteView extends StatelessWidget {
  const RouteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        // height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Hello There!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const Text(
              'Please verify with the email provided by your employer.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 61, 60, 60),
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: const Image(
                image: AssetImage(
                  'asset/images/loginView_logo.png',
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  //login page

                  Navigator.of(context).pushNamed(loginRoute);
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 0, 140, 150)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(registerRoute);
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                    Colors.white,
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
