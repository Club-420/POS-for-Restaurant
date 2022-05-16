import 'package:flutter/material.dart';
import 'package:pos/constants/routes.dart';
import 'package:pos/constants/test_data.dart';
import 'package:pos/views/waiters/bill.dart';
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
      resizeToAvoidBottomInset: false,
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

  return ListView.builder(
    itemCount: noOfTables,
    itemBuilder: (context, index) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 10,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Table ${index + 1}',
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Icon(
                tables[index].isOccupied ? Icons.check : null,
                size: 33,
                color: Colors.white,
              )
            ],
          ),
        ),
      );
    },
  );
}

class IndividualTable extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final index;
  const IndividualTable({Key? key, required this.index}) : super(key: key);

  @override
  State<IndividualTable> createState() => _IndividualTableState();
}

class _IndividualTableState extends State<IndividualTable> {
  @override
  //for testing checkout
  @override
  Widget build(BuildContext context) {
    bool clicked = tables[widget.index].isOccupied;
    double totalBill = tables[widget.index].getTotalPrice as double;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              tableRoute,
              (route) => false,
            );
          },
        ),
        title: Text(
          'Table ${widget.index + 1}',
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                if (tables[widget.index].isOccupied) {
                  await showCheckoutDialog(context, index: widget.index);
                }
              },
              icon: const Icon(
                Icons.logout_outlined,
              ))
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: TextField(
                        // controller: _name,
                        enableSuggestions: false,
                        autocorrect: false,
                        onSubmitted: (value) {
                          setState(() {
                            tables[widget.index].name = value;
                            tables[widget.index].isOccupied = true;
                          });
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: tables[widget.index].name ??
                              'Enter Customer Name',
                          hintStyle: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Checkbox(
                        value: clicked,
                        onChanged: (value) {
                          setState(() {
                            tables[widget.index].isOccupied = true;
                            clicked = true;
                          });
                        }),
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 1),
                    blurRadius: 6,
                  )
                ],
              ),
              height: MediaQuery.of(context).size.height / 2,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        '  Orders',
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          if (tables[widget.index].isOccupied) {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    OrderMenu(index: widget.index));
                          }
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1, 0),
                            blurRadius: 6,
                          )
                        ],
                      ),
                      child: ListView.builder(
                        itemCount: tables[widget.index].foods.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 15,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: index.isEven
                                    ? Colors.grey
                                    : Colors.blueGrey,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(0, 1),
                                    blurRadius: 6,
                                  )
                                ]),
                            child: Row(
                              children: [
                                Text(
                                  tables[widget.index].howMuch(
                                              tables[widget.index].foods[index]
                                                  ['name']) ==
                                          0
                                      ? '  ${tables[widget.index].foods[index]['name']}'
                                      : '  ${tables[widget.index].foods[index]['name']}   x  ${tables[widget.index].howMuch(tables[widget.index].foods[index]['name'])}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      tables[widget.index].remove(
                                          tables[widget.index].foods[index]
                                              ['name'],
                                          1);

                                      totalBill = tables[widget.index]
                                          .getTotalPrice as double;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total: \n',
                    style: TextStyle(
                      fontSize: 23,
                    ),
                  ),
                  Text(
                    'Rs ${tables[widget.index].getTotalPrice as double}\n',
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderMenu extends StatefulWidget {
  const OrderMenu({Key? key, this.index}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final index;
  @override
  State<OrderMenu> createState() => _OrderMenuState();
}

class _OrderMenuState extends State<OrderMenu> {
  final TableSchema foodItems = TableSchema(index: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 1.5,
        margin: EdgeInsets.fromLTRB(
          10,
          MediaQuery.of(context).size.height / 4,
          10,
          10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 6,
              color: Colors.black,
            )
          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              margin: const EdgeInsets.fromLTRB(
                10,
                30,
                10,
                10,
              ),
              child: ListView.builder(
                itemCount: menu.menu.length,
                itemBuilder: (context, index) {
                  //get the items
                  return Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height / 10,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: index.isEven ? Colors.grey : Colors.blueGrey,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 1),
                            blurRadius: 6,
                          )
                        ]),
                    child: Row(
                      children: [
                        Text(
                          foodItems.howMuch(menu.menu[index]['name'] as String) < 1
                              ? '  ${menu.menu[index]['name']}'
                              : '  ${menu.menu[index]['name']}   x  ${foodItems.howMuch(menu.menu[index]['name'] as String)}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              foodItems.add(menu.menu[index]['name'] as String, 1);
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              foodItems.remove(
                                  menu.menu[index]['name'] as String, 1);
                            });
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    tables[widget.index].addFoodList(foodItems.foods);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => IndividualTable(
                          index: widget.index,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
