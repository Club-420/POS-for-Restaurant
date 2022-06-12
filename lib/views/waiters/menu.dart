import 'package:flutter/material.dart';
import 'package:pos/constants/test_data.dart';
import 'package:pos/views/admin/notifications.dart';
import 'package:pos/views/waiters/tables.dart';

var indexess = 0;
List all = [];

class menuWidget extends StatefulWidget {
  const menuWidget({Key? key, required this.buildParent}) : super(key: key);
  final Function() buildParent;
  @override
  State<menuWidget> createState() => _menuWidgetState(buildParent: buildParent);
}

class _menuWidgetState extends State<menuWidget> {
  final Function() buildParent;
  _menuWidgetState({required this.buildParent});
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Container(
            width: 80,
            color: cols,
            child: ListView.builder(
                itemCount: Categories.length,
                scrollDirection: Axis.vertical,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        indexess = index;
                        all.clear();
                        for (var item in menu.menu) {
                          if (Categories[indexess] == item['category']) {
                            all.add(item);
                          } else if (Categories[indexess] == 'All') {
                            all.add(item);
                          }
                        }
                      });
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width / 4,
                        color: index == indexess ? Colors.white : cols,
                        margin: EdgeInsets.fromLTRB(5, 0, 8, 5),
                        child: Text(
                          '${Categories[index]}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: index == indexess ? cols : Colors.white,
                            fontSize: 15,
                          ),
                        )),
                  );
                })),
          ),
        ),
        Flexible(
          flex: 3,
          child: FutureBuilder(
              future: menu.populateMenu(),
              builder: (context, snapshot) {
                return Container(
                  child: GridView.builder(
                      itemCount: all.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 5 : 2,
                      ),
                      itemBuilder: (context, index) {
                        return FittedBox(
                          child: Container(
                            height: 200,
                            width: 200,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.grey, width: 1.5),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => EditMenu(
                                                  buildParent: buildParent,
                                                  index: index,
                                                ));
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: cols,
                                        size: 20,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => DeleteMenu(
                                                  index: index,
                                                  buildParent: buildParent,
                                                ));
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: cols,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                FittedBox(
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
                                        '   ${all[index]['name']}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: cols,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        'Rs ${all[index]['price']}        \n',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: cols,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }),
        ),
      ],
    );
  }
}

class DeleteMenu extends StatefulWidget {
  const DeleteMenu({Key? key, required this.index, required this.buildParent})
      : super(key: key);
  final index;
  final Function() buildParent;
  @override
  State<DeleteMenu> createState() => _DeleteMenuState(buildParent: buildParent);
}

class _DeleteMenuState extends State<DeleteMenu> {
  _DeleteMenuState({required this.buildParent});
  final Function() buildParent;
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
                  color: cols,
                  fontSize: 20,
                ),
              ),
              Flexible(child: Container()),
              Text(
                'Confirm Delete This Item?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cols,
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
                            buildParent: buildParent,
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
  const EditMenu({Key? key, required this.index, required this.buildParent})
      : super(key: key);
  final Function() buildParent;
  final index;
  @override
  State<EditMenu> createState() => _EditMenuState(buildParent: buildParent);
}

class _EditMenuState extends State<EditMenu> {
  _EditMenuState({required this.buildParent});
  final Function() buildParent;
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cols,
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
                            buildParent: buildParent,
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
