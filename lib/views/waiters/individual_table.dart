import 'package:flutter/material.dart';
import 'package:pos/views/waiters/menu.dart';
import 'package:pos/views/waiters/ordermenu.dart';
import 'package:pos/views/waiters/tables.dart';
import '../../constants/routes.dart';
import '../../constants/test_data.dart';

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
    final TableSchema foodItems = TableSchema(index: 0);

    //add items to the menu
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
                          tables[widget.index].name = value;
                          tables[widget.index].isOccupied = true;
                        });
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText:
                            tables[widget.index].name ?? 'Enter Customer Name',
                        hintStyle: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Checkbox(
                      value: clicked,
                      onChanged: (value) {
                        setState(() {
                          tables[widget.index].isOccupied = true;
                          clicked = true;
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
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: menu.menu.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey, width: 0.5)),
                        child: InkWell(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${menu.menu[index]['name']}',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  500
                                              ? 20
                                              : 10,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      Text(
                                        '  Rs. ${menu.menu[index]['price']}',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  500
                                              ? 20
                                              : 10,
                                          color: Colors.teal,
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
                            if (tables[widget.index].isOccupied) {
                              setState(() {
                                tables[widget.index]
                                    .add(menu.menu[index]['name'], 1);
                              });
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
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
                            width: 0.5,
                          ),
                        )),
                        height: MediaQuery.of(context).size.height / 20,
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
                                      MediaQuery.of(context).size.width > 550
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
                                      MediaQuery.of(context).size.width > 550
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
                                      MediaQuery.of(context).size.width > 550
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
                        height: MediaQuery.of(context).size.height / 1.4,
                        child: ListView.builder(
                          itemCount: tables[widget.index].foods.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.all(5),
                              height: 60,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //name of item
                                  Flexible(
                                    flex: 2,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          '${tables[widget.index].foods[index]['name']}',
                                          style: TextStyle(
                                            color: Colors.teal,
                                            fontSize: MediaQuery.of(context)
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
                                  //no of item
                                  Flexible(
                                    flex: 1,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Center(
                                        child: Text(
                                          '   ${tables[widget.index].howMuch(tables[widget.index].foods[index]['name'])}',
                                          style: TextStyle(
                                            color: Colors.teal,
                                            fontSize: MediaQuery.of(context)
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
                                          '  ${tables[widget.index].getItemTotalPrice(foodName: tables[widget.index].foods[index]['name'])}',
                                          style: TextStyle(
                                            color: Colors.teal,
                                            fontSize: MediaQuery.of(context)
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
                            );
                          },
                        ),
                      ),
                  
                      // total price
                      // SizedBox(
                      //    height: MediaQuery.of(context).size.height/50,
                      //   child: Row(children: [
                      //     Flexible(
                      //         child: SizedBox(
                               
                      //           child: Text('Count: '),
                      //         ),
                      //         flex: 2),
                      //     Flexible(
                      //         child: SizedBox(
                      //           width: double.infinity,
                      //           child: Text('Count ='),
                      //         ),
                      //         flex: 1),
                      //     Flexible(
                      //         child: SizedBox(
                      //           width: double.infinity,
                      //           child: Text('Count ='),
                      //         ),
                      //         flex: 2),
                      //   ]),
                      // )
                    ],
                  ),
                ),
              ),
            ]),
            // Row(
            //   children: <Widget>[
            //     Flexible(
            //       child: Container(
            //         color: Colors.teal,
            //         child: ListView.builder(
            //           itemBuilder: (_, i) => ListTile(title: Text("List1: $i")),
            //         ),
            //       ),
            //     ),
            //     Flexible(
            //       child: Container(
            //         color: Colors.orange,
            //         child: ListView.builder(
            //           itemBuilder: (_, i) => ListTile(title: Text("List2: $i")),
            //         ),
            //       ),
            //     ),
            //   ],
            // )

            //bottom tables
            // Row(
            //   children: [
            //     //menulist
            //     Container(
            //       margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            //       width: double.infinity,
            //       height: double.infinity,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(5),
            //         color: Colors.white,
            //         boxShadow: const [
            //           BoxShadow(
            //             color: Colors.black,
            //             blurRadius: 6,
            //             offset: Offset(
            //               0,
            //               1,
            //             ),
            //           )
            //         ],
            //       ),
            //       child:const Text('Hello'),
            //       // child: GridView.builder(
            //       //     gridDelegate:
            //       //         const SliverGridDelegateWithFixedCrossAxisCount(
            //       //       crossAxisCount: 4,
            //       //     ),
            //       //     itemCount: menu.menu.length,
            //       //     itemBuilder: (context, index) {
            //       //       return Container(
            //       //         margin: const EdgeInsets.all(5),
            //       //         decoration: BoxDecoration(
            //       //           borderRadius: BorderRadius.circular(5),
            //       //           color: Colors.white,
            //       //           boxShadow: const [
            //       //             BoxShadow(
            //       //               color: Colors.grey,
            //       //               offset: Offset(0, 1),
            //       //               blurRadius: 6,
            //       //             )
            //       //           ],
            //       //         ),
            //       //         child: TextButton(
            //       //           onPressed: (() {}),
            //       //           child: Text(
            //       //             '   ${menu.menu[index]['name']}\t\t\n',
            //       //             style: const TextStyle(
            //       //               fontWeight: FontWeight.bold,
            //       //               color: Colors.teal,
            //       //               fontSize: 10,
            //       //             ),
            //       //           ),
            //       //         ),
            //       //       );
            //       //     }),
            //     ),

            //     //Placingordertable
            //     // Flexible(
            //     //   flex: 1,
            //     //   child: Container(
            //     //     margin: const EdgeInsets.all(10),
            //     //     width: double.infinity,
            //     //     decoration: BoxDecoration(
            //     //       borderRadius: BorderRadius.circular(5),
            //     //       color: Colors.white,
            //     //       boxShadow: const [
            //     //         BoxShadow(
            //     //           color: Colors.black,
            //     //           blurRadius: 6,
            //     //           offset: Offset(
            //     //             0,
            //     //             1,
            //     //           ),
            //     //         )
            //     //       ],
            //     //     ),
            //     //     child: Column(
            //     //       children: [
            //     //         Row(
            //     //           children: const [
            //     //             Flexible(
            //     //               flex: 1,
            //     //               child: SizedBox(
            //     //                 width: double.infinity,
            //     //                 child: Text(
            //     //                   'SN',
            //     //                   textAlign: TextAlign.center,
            //     //                 ),
            //     //               ),
            //     //             ),
            //     //             Flexible(
            //     //               flex: 2,
            //     //               child: SizedBox(
            //     //                 width: double.infinity,
            //     //                 child: Text(
            //     //                   'Orders',
            //     //                   textAlign: TextAlign.center,
            //     //                 ),
            //     //               ),
            //     //             ),
            //     //             Flexible(
            //     //               flex: 2,
            //     //               child: SizedBox(
            //     //                 width: double.infinity,
            //     //                 child: Text(
            //     //                   'Quantity',
            //     //                   textAlign: TextAlign.center,
            //     //                 ),
            //     //               ),
            //     //             ),
            //     //             Flexible(
            //     //               flex: 2,
            //     //               child: SizedBox(
            //     //                 width: double.infinity,
            //     //                 child: Text(
            //     //                   'Price',
            //     //                   textAlign: TextAlign.center,
            //     //                 ),
            //     //               ),
            //     //             ),
            //     //           ],
            //     //         ),
            //     //         const Divider(
            //     //           thickness: 60,
            //     //         ),
            //     //         ListView.builder(
            //     //             itemCount: 3,
            //     //             itemBuilder: (
            //     //               contex,
            //     //               index,
            //     //             ) {
            //     //               return Text(index.toString());
            //     //             }),
            //     //       ],
            //     //     ),
            //     //   ),
            //     // ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Container(
            //       margin: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(5),
            //         // color: Colors.white,
            //         color: Colors.red,
            //         boxShadow: const [
            //           BoxShadow(
            //             color: Colors.black,
            //             offset: Offset(0, 1),
            //             blurRadius: 6,
            //           )
            //         ],
            //       ),
            //       height: MediaQuery.of(context).size.height,
            //       alignment: Alignment.center,
            //       child: GridView.builder(
            //           itemCount: menu.menu.length,
            //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //               crossAxisCount: 4),
            //           itemBuilder: (context, index) {
            //             return Container(
            //               margin: const EdgeInsets.all(10),
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(5),
            //                 color: Colors.white,
            //                 boxShadow: const [
            //                   BoxShadow(
            //                     color: Colors.black,
            //                     offset: Offset(0, 1),
            //                     blurRadius: 6,
            //                   )
            //                 ],
            //               ),
            //               child: Column(
            //                 children: [
            //                   TextButton(
            //                     onPressed: () {
            //                       tables[widget.index]
            //                           .addFoodList(foodItems.foods);
            //                     },
            //                     child: const Image(
            //                       alignment: Alignment.center,
            //                       width: 100,
            //                       height: 50,
            //                       image: AssetImage(
            //                         'asset/images/loginView_logo.png',
            //                       ),
            //                     ),
            //                   ),
            //                   Row(
            //                     crossAxisAlignment: CrossAxisAlignment.center,
            //                     children: [
            //                       Text(
            //                         '   ${menu.menu[index]['name']}\t\t\n',
            //                         style: const TextStyle(
            //                           fontWeight: FontWeight.bold,
            //                           color: Colors.teal,
            //                           fontSize: 10,
            //                         ),
            //                       ),
            //                       Text(
            //                         'Rs ${menu.menu[index]['price']}        \n',
            //                         style: const TextStyle(
            //                           fontWeight: FontWeight.bold,
            //                           color: Colors.teal,
            //                           fontSize: 10,
            //                         ),
            //                       ),
            //                     ],
            //                   )
            //                 ],
            //               ),
            //             );
            //           }),
            //     ),
            //     Flexible(
            //       flex: 1,
            //       child: Container(
            //         margin: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(5),
            //           color: Colors.white,
            //           boxShadow: const [
            //             BoxShadow(
            //               color: Colors.black,
            //               offset: Offset(0, 1),
            //               blurRadius: 6,
            //             )
            //           ],
            //         ),
            //         height: MediaQuery.of(context).size.height,
            //         alignment: Alignment.center,
            // child:
// Column(
//                       children: [
//                         Row(
//                           children: [
//                             const Text(
//                               '  Orders',
//                               // textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 fontSize: 20,
//                               ),
//                             ),
//                             IconButton(
//                               onPressed: () {
//                                 if (tables[widget.index].isOccupied) {
//                                   showDialog(
//                                       context: context,
//                                       builder: (context) =>
//                                           OrderMenu(index: widget.index));
//                                 }
//                               },
//                               icon: const Icon(
//                                 Icons.add,
//                                 color: Colors.blueGrey,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SingleChildScrollView(
//                           child: Container(
//                             margin: const EdgeInsets.all(10),
//                             width: double.infinity,
//                             height: MediaQuery.of(context).size.height,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               color: Colors.white,
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: Colors.grey,
//                                   offset: Offset(1, 0),
//                                   blurRadius: 6,
//                                 )
//                               ],
// //                             ),
//                     child: ListView.builder(
//                       itemCount: tables[widget.index].foods.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           width: double.infinity,
//                           height: MediaQuery.of(context).size.height,
//                           margin: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                               color:
//                                   index.isEven ? Colors.grey : Colors.blueGrey,
//                               boxShadow: const [
//                                 BoxShadow(
//                                   color: Colors.black,
//                                   offset: Offset(0, 1),
//                                   blurRadius: 6,
//                                 )
//                               ]),
//                           child: Row(
//                             children: [
//                               Text(
//                                 tables[widget.index].howMuch(
//                                             tables[widget.index].foods[index]
//                                                 ['name']) ==
//                                         0
//                                     ? '  ${tables[widget.index].foods[index]['name']}'
//                                     : '  ${tables[widget.index].foods[index]['name']}   x  ${tables[widget.index].howMuch(tables[widget.index].foods[index]['name'])}',
//                                 textAlign: TextAlign.center,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   setState(() {
//                                     tables[widget.index].remove(
//                                         tables[widget.index].foods[index]
//                                             ['name'],
//                                         1);

//                                     totalBill = tables[widget.index]
//                                         .getTotalPrice as double;
//                                   });
//                                 },
//                                 icon: const Icon(
//                                   Icons.remove,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                     //       ),
//                     //     ),
//                     //   ],
//                     // ),
//                   ),
//                 ),
//               ],
//             ),
//             // SizedBox(
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.center,
//             //     children: [
//             //       const Text(
//             //         'Total: \n',
//             //         style: TextStyle(
//             //           fontSize: 23,
//             //         ),
//             //       ),
//             //       Text(
//             //         'Rs ${tables[widget.index].getTotalPrice as double}\n',
//             //         style: const TextStyle(
//             //           fontSize: 25,
//             //           color: Colors.teal,
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // )
          ],
        ),
      ),
    );
  }
}
