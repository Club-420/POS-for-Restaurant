import 'package:flutter/material.dart';
import 'package:pos/constants/test_data.dart';
import 'package:pos/views/waiters/tables.dart';

class menuWidget extends StatefulWidget {
  const menuWidget({Key? key}) : super(key: key);

  @override
  State<menuWidget> createState() => _menuWidgetState();
}

class _menuWidgetState extends State<menuWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: menu.populateMenu(),
        builder: (context, snapshot) {
          return Container(
            child: GridView.builder(
                itemCount: menu.menu.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 1.5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => EditMenu(
                                          index: index,
                                        ));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.teal,
                                size: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => DeleteMenu(
                                          index: index,
                                        ));
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.teal,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const FittedBox(
                          child: Image(
                            alignment: Alignment.center,
                            width: 80,
                            height: 80,
                            image: AssetImage(
                              'asset/images/loginView_logo.png',
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Column(
                            children: [
                              Text(
                                '   ${menu.menu[index]['name']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'Rs ${menu.menu[index]['price']}        \n',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
          );
        });
  }
}

class DeleteMenu extends StatefulWidget {
  const DeleteMenu({Key? key, required this.index}) : super(key: key);
  final index;
  @override
  State<DeleteMenu> createState() => _DeleteMenuState();
}

class _DeleteMenuState extends State<DeleteMenu> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> tempMenuItem = menu.menu[widget.index];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 4,
          margin: EdgeInsets.fromLTRB(
            10,
            // MediaQuery.of(context).size.height / 4,
            10,
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
              Flexible(child: Container()),
              Text(
                '${tempMenuItem['name']}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  fontSize: 20,
                ),
              ),
              Flexible(child: Container()),
              const Text(
                'Confirm Delete This Item?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  fontSize: 20,
                ),
              ),
              Flexible(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 35,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      MenuSchema().deleteSingleItem(name: tempMenuItem['name']);

                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              TableView(
                            currentPage: 1,
                          ),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 35,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

var _itemname = TextEditingController();
var _itemprice = TextEditingController();

class EditMenu extends StatefulWidget {
  const EditMenu({Key? key, required this.index}) : super(key: key);
  final index;
  @override
  State<EditMenu> createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> tempMenuItem = menu.menu[widget.index];

    // _itemname.text = tempMenuItem['name'];
    // _itemprice.text = tempMenuItem['price'].toString();
    // dropdownvalue = tempMenuItem['category'];
    return Scaffold(
      backgroundColor: Colors.transparent,
      // resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.height / 2,
          margin: EdgeInsets.fromLTRB(
            10,
            // MediaQuery.of(context).size.height / 4,
            10,
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
              Flexible(child: Container(), flex: 1),
              Text(
                '\n${tempMenuItem['name']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  fontSize: 20,
                ),
              ),
              Flexible(child: Container(), flex: 1),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width / 2,
                    child: TextField(
                      onSubmitted: (value) {
                        _itemname.text = value;
                      },
                      controller: _itemname,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New Name',
                        hintText: 'Enter new name of Item',
                        hintStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: TextField(
                      onSubmitted: (value) {
                        _itemprice.text = value;
                      },
                      controller: _itemprice,
                      keyboardType: TextInputType.number,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'New Price',
                        hintText: 'Rs. ',
                        hintStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const dropdown(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 35,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      MenuSchema().deleteSingleItem(name: tempMenuItem['name']);

                      menu.addSingleItem(
                          name: _itemname.text,
                          price: _itemprice.text,
                          category: dropdownvalue);
                      _itemname.clear();
                      _itemprice.clear();
                      dropdownvalue = 'Veg';
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              TableView(
                            currentPage: 1,
                          ),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                      // );
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 35,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
