import 'package:flutter/material.dart';
import 'package:pos/auth/auth_service.dart';
import 'package:pos/constants/routes.dart';
import 'package:pos/constants/test_data.dart';

import '../../constants/emums.dart';
import '../admin/setting.dart';

class WorkersView extends StatefulWidget {
  const WorkersView({Key? key}) : super(key: key);

  @override
  State<WorkersView> createState() => _WorkersViewState();
}

class _WorkersViewState extends State<WorkersView> {
  @override
  Widget build(BuildContext context) {
    menu.populateMenu();
    tableSchema.fetchAllTables();
    // tableSchema.populate();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: cols,
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
                  case MenuAction.setting:
                  Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SettingAll(),
                      ),
                    );
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log Out'),
                ),
                PopupMenuItem<MenuAction>(
                  value: MenuAction.setting,
                  child: Text('Setting'),
                ),
              ];
            },
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(tableRoute, (route) => false);
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: cols,
                    boxShadow:  [
                      BoxShadow(
                        color: cols,
                        offset:const Offset(0, 1),
                        blurRadius: 6,
                      ),
                    ]),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.room_service_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                      Text(
                        'Serving',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(kitchenRoute, (route) => true);
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: cols,
                    boxShadow:  [
                      BoxShadow(
                        color: cols,
                        offset:const Offset(0, 1),
                        blurRadius: 6,
                      )
                    ]),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.soup_kitchen_outlined,
                        color: Colors.white,
                        size: 50,
                      ),
                      Text(
                        'Kitchen',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
