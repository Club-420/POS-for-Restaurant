import 'package:flutter/material.dart';
import 'package:pos/auth/auth_exceptions.dart';
import 'package:pos/auth/auth_service.dart';
import 'package:pos/constants/routes.dart';
import 'package:pos/constants/test_data.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //values for text and email
  late final TextEditingController _email;
  late final TextEditingController _password;

  //initialize at beginning
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  //dispose after creation
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        // backgroundColor: cols,
        title: const Text("Login Page"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              mainRoute,
              (route) => false,
            );
          },
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 200,
                width: 200,
                padding: const EdgeInsets.only(
                  top: 40,
                ),
                child: const Center(
                  child: Center(
                      child: Image(
                          image: AssetImage('asset/images/loginView_logo.png'))),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _email,
              autocorrect: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                hintText: 'Enter your email address.',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter your password.',
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Forgot your password?',
            ),
          ),
          Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              color: cols,
              borderRadius: BorderRadius.circular(50),
            ),
            child: TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;

                try {
                  await AuthService.firebase().logIn(
                    email: email,
                    password: password,
                  );

                  final user = AuthService.firebase().currentUser;
                  if (user!.isEmailVerified) {
                    //route to worker or admin page
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(waiterRoute, (route) => false);
                  } else {
                    //verify email
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(verifyRoute, (route) => false);
                  }
                } on UserNotFoundAuthException {
                  showErrorDialog(
                    context,
                    'user not found',
                  );
                } on WrongPasswordAuthException {
                  showErrorDialog(
                    context,
                    'wrong password',
                  );
                } on GenericAuthException {
                  showErrorDialog(
                    context,
                    'authentification error. Invalid credentials',
                  );
                }
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(),
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        registerRoute, (route) => false);
                  },
                  child: const Text(
                    'Sign Up',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
