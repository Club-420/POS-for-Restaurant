
import 'package:flutter/material.dart';
import 'package:pos/views/waiters/individual_table.dart';

import '../../constants/test_data.dart';

class OrderMenu extends StatefulWidget {
  const OrderMenu({Key? key, this.index}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final index;
  @override
  State<OrderMenu> createState() => _OrderMenuState();
}

class _OrderMenuState extends State<OrderMenu> {
  final TableSchema foodItems = TableSchema();

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
                          foodItems.howMuch(
                                      menu.menu[index]['name'] as String) <
                                  1
                              ? '  ${menu.menu[index]['name']}'
                              : '  ${menu.menu[index]['name']}   x  ${foodItems.howMuch(menu.menu[index]['name'] as String)}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            // setState(() {
                            //   foodItems.add(
                            //       menu.menu[index]['name'] as String, 1);
                            // });
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
                    tableSchema.tables[widget.index].addFoodList(foodItems.foods);
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
