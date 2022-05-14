import 'package:flutter/material.dart';
import 'package:pos/auth/auth_service.dart';
import 'package:pos/constants/routes.dart';

import '../../constants/emums.dart';

class WorkersView extends StatefulWidget {
  const WorkersView({Key? key}) : super(key: key);

  @override
  State<WorkersView> createState() => _WorkersViewState();
}

class _WorkersViewState extends State<WorkersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final result = await showLogOutDialog(context);

                  if (result) {
                    await AuthService.firebase().logOut();
                    //send back to login
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (route) => false,
                    );
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('log out'),
                ),
              ];
            },
          )
        ],
      ),
    );
  }
}

//logout dialog
Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("log out"),
          content: const Text("Are you sure you want to log out ?"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text("Yes"))
          ],
        );
      }).then((value) => value ?? false);
}
