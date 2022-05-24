import 'package:flutter/foundation.dart';
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
    List navbar = ['Home', 'Menu', 'Bill', 'Settings'];
    pages.add(tableWidget(context));
    pages.add(const menuWidget());
    pages.add(const billwidget());
    pages.add(settingWidget(context));
    var hello = '';
    return Scaffold(
      floatingActionButton: _selectedIndex == 1
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      var itemnameController = TextEditingController();
                      var priceController = TextEditingController();

                      return AlertDialog(
                        title: const Text('Add Item'),
                        content: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: itemnameController,
                                decoration:
                                    InputDecoration(hintText: 'Item Name'),
                              ),
                              TextFormField(
                                controller: priceController,
                                decoration: InputDecoration(hintText: 'Price'),
                              ),
                              DropdownButton(
                                value: dropdownvalue,
                                items: Categories.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item),
                                  );
                                }).toList(),
                                onChanged: (String? itemval) {
                                  setState(() {
                                    dropdownvalue = itemval!;
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Send them to your email maybe?
                              var itemname = itemnameController.text;
                              var price = priceController.text;

                              if (itemname != '' && price != '') {
                                setState(() {
                                  
                                });
                              Navigator.pop(context);
                              }
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      );
                    });
              },
            )
          : null,
      appBar: AppBar(
        title: Text(navbar[_selectedIndex]),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 49, 105, 131),
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
              color: Colors.teal,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book_outlined,
              color: Colors.teal,
            ),
            label: 'Menus',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.money_outlined,
              color: Colors.teal,
            ),
            label: 'Bill',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.settings_outlined,
              color: Colors.teal,
            ),
            label: 'Settings',
          )
        ],
        //  backgroundColor: Colors.green,
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
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(7)),
          color: tables[index].isOccupied
              ? Color.fromARGB(255, 0, 0, 0)
              : Colors.teal,
        ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.restaurant_rounded,
                size: 50,
                color: Colors.white,
              ),
              Text(
                'Table ${index + 1}',
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
