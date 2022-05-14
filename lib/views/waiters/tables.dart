import 'package:flutter/material.dart';
import 'package:pos/constants/routes.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(waiterRoute, (route) => false);
          },
        ),
        title: const Text(
          'Orders',
        ),
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
              label: 'Settings')
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


//group all the pages
List<Widget> pages = [
  tableWidget(),
  menuWidget(),
  billWidget(),
  settingWidget(),
];

//table widget
Widget tableWidget(){
  return const Center(child: Text('this is tables'),);
}