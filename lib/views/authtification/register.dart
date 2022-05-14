import 'package:flutter/material.dart';
import 'package:pos/auth/auth_exceptions.dart';
import 'package:pos/auth/auth_service.dart';
import 'package:pos/constants/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password1;
  late final TextEditingController _password2;

  @override
  void initState() {
    _email = TextEditingController();
    _password1 = TextEditingController();
    _password2 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password1.dispose();
    _password2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Sign Up',
          ),
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
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: const Align(
                  alignment: Alignment.center,
                  child: Text('Create an Account, its free',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.teal,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _email,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'email',
                      hintText: 'Enter your email here.'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _password1,
                  autocorrect: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'password',
                      hintText: 'Create a secure password.'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _password2,
                  autocorrect: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'confirm password',
                      hintText: 'Re-enter your password.'),
                ),
              ),
              Container(
                width: 250,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextButton(
                  onPressed: () async {
                    //first check if both the password are same
                    if (_password1.text == _password2.text) {
                      final email = _email.text;
                      final password = _password1.text;

                      try {
                        await AuthService.firebase().createUser(
                          email: email,
                          password: password,
                        );
                        //send to verify view
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            verifyRoute, (route) => false);
                      } on WeakPasswordAuthException {
                        showErrorDialog(
                          context,
                          "Use Stronger Password",
                        );
                      } on EmailAlreadyUsedAuthException {
                        showErrorDialog(
                          context,
                          "email already in use",
                        );
                      } on InvalidEmailAuthException {
                        showErrorDialog(
                          context,
                          "invalid email",
                        );
                      } on GenericAuthException {
                        showErrorDialog(
                          context,
                          "failed to register",
                        );
                      } catch (e) {
                        showErrorDialog(context, e.toString());
                      }
                    } else {
                      showErrorDialog(
                        context,
                        'passwords doesn\'t match.',
                      );
                    }
                  },
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? '),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            loginRoute, (route) => false);
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
