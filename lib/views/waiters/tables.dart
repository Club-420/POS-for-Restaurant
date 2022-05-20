import 'package:flutter/material.dart';
import 'package:pos/constants/routes.dart';
import 'package:pos/constants/test_data.dart';
import 'package:pos/views/waiters/bill.dart';
import 'package:pos/views/waiters/individual_table.dart';
import 'package:pos/views/waiters/menu.dart';
import 'package:pos/views/waiters/setting.dart';

class TableView extends StatefulWidget {
  const TableView({Key? key}) : super(key: key);

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  int _selectedIndex = 0;
//generate list of popupmenu item
  List<PopupMenuEntry> listOfNotification() {
    final List<PopupMenuEntry> _list = [];

    for (final item in notifications) {
      final _temp = PopupMenuItem(
        value: item,
        child: Text(item),
      );
      _list.add(_temp);
      _list.add(const PopupMenuDivider());
    }

    _list.removeLast();

    return _list;
  }

  //add value to notificaton
  @override
  Widget build(BuildContext context) {
    pages.add(tableWidget(context));
    pages.add(menuWidget(context));
    pages.add(billWidget(context));
    pages.add(settingWidget(context));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(waiterRoute, (route) => false);
          },
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              notifications.isEmpty
                  ? Icons.notifications_outlined
                  : Icons.notifications_active_outlined,
            ),
            onSelected: (value) async {
              await showNotificationDialog(context, value.toString());
            },
            itemBuilder: (context) {
              return listOfNotification();
            },
          )
        ],
      ),
      body: Container(
        child: pages.elementAt(_selectedIndex),
      ),
      // resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_max_outlined,
              color: Colors.blue,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book_outlined,
              color: Colors.blue,
            ),
            label: 'Menus',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.money_outlined,
              color: Colors.blue,
            ),
            label: 'Bill',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
              color: Colors.blue,
            ),
            label: 'Settings',
          )
        ],
        // backgroundColor: Colors.green,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (item) {
          setState(() {
            _selectedIndex = item;
          });
        },
      ),
    );
  }
}

//show notifications dialog
Future<bool> showNotificationDialog(BuildContext context, String value) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Task Completion",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(value),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  notifications.remove(value);
                  Navigator.of(context).pop(false);
                },
                child: const Text("Yes"))
          ],
        );
      }).then((value) => value ?? false);
}

Future<bool> showCheckoutDialog(BuildContext context, {required index}) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text('Are you sure the customer wants to Checkout?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                //clear the table
                tables[index].clear();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  tableRoute,
                  (route) => false,
                );
              },
              child: const Text("Yes"))
        ],
      );
    },
  ).then((value) => false);
}

//table widget
Widget tableWidget(BuildContext context) {
  //populate the tables with schema
  for (int index = 0; index < noOfTables; index++) {
    tables.add(
      TableSchema(index: index),
    );
  }

  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: MediaQuery.of(context).size.width > 500 ? 5 : 2,
    ),
    itemCount: noOfTables,
    itemBuilder: (context, index) {
      return Container(
        // width: double.infinity,
        // height: 20,
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: index.isEven ? Colors.grey : Colors.blueGrey,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 1),
                blurRadius: 6,
              )
            ]),
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => IndividualTable(
                  index: index,
                ),
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Row(
                  children: [
                    Icon(
                      tables[index].isOccupied ? Icons.check : null,
                      size: 23,
                      color: Colors.white,
                    ),
                    Text(
                      'Table ${index + 1}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
