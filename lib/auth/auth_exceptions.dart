//handling user not found
import 'package:flutter/material.dart';

class UserNotFoundAuthException implements Exception{}

//handling wrong password
class WrongPasswordAuthException implements Exception{}

//handing weak password
class WeakPasswordAuthException implements Exception{}

//handing invalid email
class InvalidEmailAuthException implements Exception{}

//handling email already in use
class EmailAlreadyUsedAuthException implements Exception{}

//user not logged in 
class UserNotLoggedInAuthException implements Exception{}

//generic auth exception
class GenericAuthException implements Exception{}

//implementation of error dialogs
//show errors to users
Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      });
}