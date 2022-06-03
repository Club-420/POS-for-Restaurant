import 'package:flutter/material.dart';
import 'package:pos/auth/auth_service.dart';
import 'package:pos/constants/routes.dart';
import 'package:pos/constants/test_data.dart';

class VerifyView extends StatefulWidget {
  const VerifyView({Key? key}) : super(key: key);

  @override
  State<VerifyView> createState() => _VerifyViewState();
}

class _VerifyViewState extends State<VerifyView> {
  final _user = AuthService.firebase().currentUser!;
  @override
  void initState() {
    AuthService.firebase().sendEmailVerification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cols,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(
              height: 100,
              width: 200,
              child: Image(
                image: AssetImage(
                  'asset/images/verifyEmail.png',
                ),
              )),
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow:  [
                  BoxShadow(
                    color: cols,
                    offset: Offset(0, 1),
                    blurRadius: 6,
                  )
                ]),
            height: MediaQuery.of(context).size.height / 2.5,
            alignment: Alignment.center,

            //all required content
            child: Column(
              children: [
                const Text(
                  '\nPlease verify your email.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '''
We sent an email to \n${_user.email} 

Just click on the link in the email to verify
and re login to proceed further.

Still can't find the email?
                  ''',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await AuthService.firebase().sendEmailVerification();
                  },
                  child: const Text(
                    'Resend email',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(cols),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                  },
                  child: const Text(
                    'Back to login',
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
