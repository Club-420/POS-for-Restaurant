import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/constants/routes.dart';
import 'package:pos/constants/test_data.dart';
import 'package:pos/views/waiters/bill.dart';
import 'package:pos/views/waiters/individual_table.dart';
import 'package:pos/views/waiters/menu.dart';
import 'package:pos/views/waiters/setting.dart';

var itemnameController = TextEditingController();
var priceController = TextEditingController();

class TableView extends StatefulWidget {
  TableView({Key? key, this.currentPage = 0, required this.buildParent})
      : super(key: key);
  int currentPage;
  final Function() buildParent;
  @override
  State<TableView> createState() => _TableViewState(buildParent);
}

class _TableViewState extends State<TableView> {
  _TableViewState(this.buildParent);
  final Function() buildParent;
//generate list of popupmenu item
  List<PopupMenuEntry> listOfNotification() {
    final List<PopupMenuEntry> _list = [];

    for (final item in notifications) {
      final _temp = PopupMenuItem(
        value: item,
        child: Text(item),
      );
      _list.add(_temp);
      // _list.add(const PopupMenuDivider());
    }
  
    return _list;
  }

  //add value to notificaton
  @override
  Widget build(BuildContext context) {
    List navbar = ['Home', 'Menu', 'Bill', 'Settings'];
    pages.add(tableWidget(context));
    pages.add(menuWidget(
      buildParent: buildParent,
    ));
    pages.add(const billwidget());
    pages.add(settingWidget(buildParent: buildParent));

    return Scaffold(
      floatingActionButton: widget.currentPage == 1
          ? FloatingActionButton(
              backgroundColor: cols,
              child: Icon(Icons.add),
              onPressed: () {
                widget.buildParent();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Add Item'),
                        content: Container(
                          height: MediaQuery.of(context).size.height / 4,
                          child: Column(
                            children: [
                              const dropdown(),
                              TextFormField(
                                controller: itemnameController,
                                decoration: const InputDecoration(
                                    hintText: 'Item Name'),
                              ),
                              TextFormField(
                                keyboardType: TextInputType.number,
                                controller: priceController,
                                decoration:
                                    const InputDecoration(hintText: 'Price'),
                              ),
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
                                menu.addSingleItem(
                                    name: itemname,
                                    price: price,
                                    category: dropdownvalue);
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            TableView(
                                      currentPage: 1,
                                      buildParent: buildParent,
                                    ),
                                    transitionDuration: Duration.zero,
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
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
        title: Text(navbar[widget.currentPage]),
        centerTitle: true,
        backgroundColor: cols,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
                  : Icons.notifications_active,
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
        child: pages.elementAt(widget.currentPage),
      ),
      // resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_max_outlined,
              color: cols,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book_outlined,
              color: cols,
            ),
            label: 'Menus',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.money_outlined,
              color: cols,
            ),
            label: 'Bill',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.settings_outlined,
              color: cols,
            ),
            label: 'Settings',
          )
        ],
        //  backgroundColor: Colors.green,
        selectedItemColor: Colors.black12,
        unselectedItemColor: Colors.red,
        currentIndex: widget.currentPage,
        onTap: (item) {
          setState(() {
            widget.currentPage = item;
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
                child: const Text("Yes")),
          ],
        );
      }).then((value) => value ?? false);
}



//table widget
Widget tableWidget(BuildContext context) {
  return FutureBuilder(
    future: tableSchema.fetchAllTables(),
    builder: (context, snapshot) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 500 ? 5 : 2,
        ),
        itemCount: tableSchema.tables.length,
        itemBuilder: (context, index) {
          return Container(
            // width: double.infinity,
            // height: 20,

            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              color: tableSchema.isOccupied(index: index)
                  ? const Color.fromARGB(255, 0, 0, 0)
                  : cols,
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
                    'Table ${tableSchema.tables[index]['index'] + 1}',
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
    },
  );
}

class dropdown extends StatefulWidget {
  const dropdown({Key? key}) : super(key: key);

  @override
  State<dropdown> createState() => _dropdownState();
}

class _dropdownState extends State<dropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
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
    );
  }
}
