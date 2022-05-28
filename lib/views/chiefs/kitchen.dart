import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pos/constants/test_data.dart';

String clickedFood = '';

class KitchenView extends StatefulWidget {
  const KitchenView({Key? key}) : super(key: key);

  @override
  State<KitchenView> createState() => _KitchenViewState();
}

class _KitchenViewState extends State<KitchenView> {
  @override
  Widget build(BuildContext context) {
    // kitchenSchema.loadItemForKitchen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitchen'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collectionGroup('foodsColl')
              .snapshots(),
          builder: (context, snapshot) {
            return Column(
              children: [
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.5)),
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Center(child: Text('ItemName')),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Center(child: Text('Quantity')),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Center(
                          child: Text(
                            ('TableNo'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.3,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        final tableIndex = snapshot.data?.docs[index]['index'];
                        final foodName = snapshot.data?.docs[index].id;
                        final isCooked = snapshot.data?.docs[index]['isCooked'];
                        final noOfItems =
                            snapshot.data?.docs[index]['noOfItem'];
                        final cookedNumber =
                            snapshot.data?.docs[index]['noOfItemsCooked'];
                        if (foodName == 'test' || isCooked) {
                          // print('text bhitra');
                          return Container();
                        } else {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: foodName == clickedFood
                                    ? Colors.blue
                                    : Color.fromARGB(31, 181, 181, 181),
                                border:
                                    Border.all(color: Colors.grey, width: 0.5)),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  clickedFood = foodName!;
                                });
                              },
                              onDoubleTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Container(
                                          height: 100,
                                          width: 100,
                                          child: Column(
                                            children: [
                                              Text('Is This Item Cooked?'),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        final db =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'tables');
                                                        db
                                                            .doc(
                                                                'table $tableIndex')
                                                            .collection(
                                                                'foodsColl')
                                                            .doc('$foodName')
                                                            .update({
                                                          'isCooked':
                                                              cookedNumber !=
                                                                      noOfItems
                                                                  ? true
                                                                  : false,
                                                          'noOfItemsCooked':
                                                              noOfItems
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(
                                                          Icons.soup_kitchen)),
                                                  IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(Icons.cancel)),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Center(child: Text('$foodName')),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Center(
                                      child: Text((noOfItems - cookedNumber)
                                          .toString()),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    fit: FlexFit.tight,
                                    child: Center(
                                        child:
                                            Text((tableIndex + 1).toString())),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                ),
              ],
            );
          }),

      // return Container(
      //   width: double.infinity,
      //   height: double.infinity,
      //   child: GridView.builder(
      //       itemCount: 10,
      //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //           crossAxisCount: 3),
      //       itemBuilder: (context, index) {
      //         return Container(
      //           margin: const EdgeInsets.all(10),
      //           decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(5),
      //             color: Colors.teal,
      //             border: Border.all(color: Colors.grey, width: 1.5),
      //           ),
      //           child: Column(children: [
      //             Container(
      //               height: 30,
      //               child: Row(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Flexible(
      //                     child: Container(
      //                       width: double.infinity,
      //                       child: Center(
      //                         child: Text(
      //                           "Table no.",
      //                           style: TextStyle(
      //                               fontSize: 25, color: Colors.white),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                   Stack(children: [
      //                     Icon(
      //                       Icons.notifications,
      //                       color: Colors.white,
      //                     ),
      //                     Icon(
      //                       Icons.circle,
      //                       color: Color.fromARGB(255, 239, 2, 2),
      //                       size: 0,
      //                     )
      //                   ]),
      //                 ],
      //               ),
      //             ),
      //             Flexible(child: Container(), flex: 1),
      //             Container(
      //               child: Row(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 children: [
      //                   Flexible(
      //                       flex: 1,
      //                       child: Container(
      //                           width: double.infinity,
      //                           child: Center(
      //                               child: Text(
      //                             'Items',
      //                             style: TextStyle(
      //                                 fontSize: 15, color: Colors.white),
      //                           )))),
      //                   Flexible(
      //                       flex: 1,
      //                       child: Container(
      //                           width: double.infinity,
      //                           child: Center(
      //                               child: Text(
      //                             "Qty",
      //                             style: TextStyle(
      //                                 fontSize: 15, color: Colors.white),
      //                           )))),
      //                 ],
      //               ),
      //             ),
      //             Flexible(
      //               flex: 10,
      //               child: Container(
      //                 margin: const EdgeInsets.all(2),
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(5),
      //                   color: Colors.white,
      //                   border:
      //                       Border.all(color: Colors.teal, width: 1.5),
      //                 ),
      //                 width: double.infinity,
      //                 child: ListView.builder(
      //                     itemCount: 50,
      //                     itemBuilder: ((context, index) {
      //                       return Container(
      //                         decoration: BoxDecoration(
      //                             border: Border(
      //                                 bottom: BorderSide(
      //                                     color: Colors.teal, width: 1))),
      //                         child: Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Flexible(
      //                               child: Row(
      //                                 children: [
      //                                   Checkbox(
      //                                       value: true,
      //                                       onChanged: (ValueKey) {}),
      //                                   Text('Items here'),
      //                                 ],
      //                               ),
      //                             ),
      //                             Flexible(
      //                                 child: Center(child: Text('Qty'))),
      //                           ],
      //                         ),
      //                       );
      //                     })),
      //               ),
      //             ),
      //             Container(
      //               decoration: const BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius:
      //                       BorderRadius.all(Radius.circular(2))),
      //               margin: const EdgeInsets.all(4),
      //               child: TextButton(
      //                   onPressed: () {},
      //                   child: const Text(
      //                     "Served",
      //                     style: TextStyle(color: Colors.teal),
      //                   )),
      //             ),
      //           ]),
      //         );
      //       }),
      // );
    );
  }
}
//
