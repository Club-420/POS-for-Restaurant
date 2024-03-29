import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pos/views/waiters/menu.dart';
// import 'package:pos/views/waiters/ordermenu.dart';
import 'package:pos/views/waiters/tables.dart';
import '../../constants/routes.dart';
import '../../constants/test_data.dart';
class IndividualTable extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final index;

  IndividualTable({Key? key, required this.index}) : super(key: key);

  @override
  State<IndividualTable> createState() => _IndividualTableState();
}

class _IndividualTableState extends State<IndividualTable> {
  num totalBill = 0;
  num itemcount = 0;

  @override
  Widget build(BuildContext context) {
    
    bool checked = tableSchema.isOccupied(index: widget.index);
    return FutureBuilder(
      future: tableSchema.getSingleTable(index: widget.index),
      builder: (context, snapshot) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
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
              'Table ${tableSchema.tables[widget.index]['index'] + 1}',
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () async {
                    if (tableSchema.isOccupied(index: widget.index)) {
                      await showCheckoutDialog(context, index: widget.index);
                    }
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                  ))
            ],
          ),
          body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      flex: 8,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        child: TextField(
                          enableSuggestions: false,
                          autocorrect: false,
                          onSubmitted: (value) {
                            setState(() {
                              tableSchema.updateCustomerName(
                                  index: widget.index, customerName: value);
                            });
                          },
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: tableSchema.tables[widget.index]
                                    ['name'] ??
                                'Enter Customer Name',
                            hintStyle: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      // child: Container(),
                      child: Checkbox(
                          value: checked,
                          onChanged: (value) {
                            setState(() {
                              checked = true;
                              tableSchema.updateStatusOfTable(
                                  index: widget.index, status: true);
                            });
                          }),
                    ),
                  ],
                ),
                Row(children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 1.4,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1.5)),
                      child: FutureBuilder(
                          future: menu.populateMenu(),
                          builder: (context, snapshot) {
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                              ),
                              itemCount: all.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey, width: 0.5)),
                                  child: InkWell(
                                    child: Column(
                                      children: [
                                        Flexible(
                                          flex: 3,
                                          child: Image.asset(
                                              'asset/images/loginView_logo.png'),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: FittedBox(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${all[index]['name']}',
                                                  style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width >
                                                                500
                                                            ? 20
                                                            : 10,
                                                    color: cols,
                                                  ),
                                                ),
                                                Text(
                                                  '  Rs. ${all[index]['price']}',
                                                  style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width >
                                                                500
                                                            ? 20
                                                            : 10,
                                                    color: cols,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    onTap: () {
                                      //first check if the table is occupied
                                      if (tableSchema.isOccupied(
                                          index: widget.index)) {
                                        tableSchema.add(
                                            itemPrice: all[index]
                                                ['price'],
                                            index: widget.index,
                                            foodName: all[index]['name']);
                                      }
                                    },
                                  ),
                                );
                              },
                            );
                          }),
                    ),
                  ),

                  //itemsprices
                  Flexible(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          border: Border.all(color: Colors.grey, width: 1.5)),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                                width: 1,
                              ),
                            )),
                            height: 30,
                            // height: MediaQuery.of(context).size.height / 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    'Items',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  550
                                              ? 20
                                              : 10,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    'Qty',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  550
                                              ? 20
                                              : 10,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Text(
                                    'Price',
                                    style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width >
                                                  550
                                              ? 20
                                              : 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //orders list
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 1.5,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('tables')
                                    .doc('table ${widget.index}')
                                    .collection('foodsColl')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  totalBill = 0;
                                  return ListView.builder(
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder: (context, index) {
                                      totalBill = totalBill +
                                          snapshot.data?.docs[index]['price']!;

                                      if (snapshot.data?.docs[index].id ==
                                          'test') {
                                        return Container();
                                      } else {
                                        return InkWell(
                                          onDoubleTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      content:
                                                          Text("are you sure?"),
                                                      actions: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            IconButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                icon: Icon(
                                                                  Icons.cancel,
                                                                )),
                                                            IconButton(
                                                                onPressed: () {
                                                                  tableSchema.removeSingleItem(
                                                                      index: widget
                                                                          .index,
                                                                      itemName: (snapshot
                                                                          .data
                                                                          ?.docs[
                                                                              index]
                                                                          .id)!);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                icon: Icon(
                                                                    Icons.save))
                                                          ],
                                                        )
                                                      ],
                                                    ));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(5),
                                            height: 50,
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.5,
                                                ),
                                              ),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  flex: 2,
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: Center(
                                                      child: Text(
                                                        '${snapshot.data?.docs[index].id}',
                                                        // '${tableSchema.tables[widget.index].foods[index]['name']}',
                                                        style: TextStyle(
                                                          color: cols,
                                                          fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width >
                                                                  550
                                                              ? 15
                                                              : 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // ),
                                                //no of item
                                                Flexible(
                                                  flex: 1,
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: Center(
                                                      child: Text(
                                                        '${snapshot.data?.docs[index]['noOfItem']}',
                                                        // '   ${tableSchema.tables[widget.index].howMuch(tableSchema.tables[widget.index].foods[index]['name'])}',
                                                        style: TextStyle(
                                                          color: cols,
                                                          fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width >
                                                                  550
                                                              ? 15
                                                              : 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                //total item price

                                                Flexible(
                                                  flex: 2,
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child: Center(
                                                      child: Text(
                                                        '${snapshot.data?.docs[index]['price']}',
                                                        // '  ${tableSchema.tables[widget.index].getItemTotalPrice(foodName: tableSchema.tables[widget.index].foods[index]['name'])}',
                                                        style: TextStyle(
                                                          color: cols,
                                                          fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width >
                                                                  550
                                                              ? 15
                                                              : 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  );
                                }),
                          ),

                          // total price
                        ],
                      ),
                    ),
                  ),
                ]),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    top: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  )),
                  height: 50,
                  // height: MediaQuery.of(context).size.height / 20,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          height: 50,
                          color: cols,
                         

            child: ListView.builder(
                itemCount: Categories.length,
                scrollDirection: Axis.horizontal,
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
                        child: Center(
                          child: Text(
                            '${Categories[index]}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: index == indexess ? cols : Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        )),
                  );
                })),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                'Count :',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width > 550
                                          ? 20
                                          : 10,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                'Total Qty:',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width > 550
                                          ? 20
                                          : 10,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Text(
                                
                                'Total: $totalBill',
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width > 550
                                          ? 20
                                          : 10,
                                ),
                              ),
                            ),
                          ],
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
                onPressed: () async {
                  totalBill = 0;
                  //clear the table
                  tableSchema.clear(index: index);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    tableRoute,
                    (route) => false,
                  );
                  // tableSchema.fetchAllTables().then((value) {

                  // });
                },
                child: const Text("Yes"))
          ],
        );
      },
    ).then((value) => false);
  }
}
