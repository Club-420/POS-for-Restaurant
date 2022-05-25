import 'package:flutter/material.dart';

class KitchenView extends StatefulWidget {
  const KitchenView({Key? key}) : super(key: key);

  @override
  State<KitchenView> createState() => _KitchenViewState();
}

class _KitchenViewState extends State<KitchenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitchen'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: GridView.builder(
            itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.teal,
                  border: Border.all(color: Colors.grey, width: 1.5),
                ),
                child: Column(children: [
                  Container(
                    height: 30,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            "Table no.",
                            style: TextStyle(fontSize: 25, color: Colors.white),
                          ),
                        ),
                        Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Flexible(child: Container(), flex: 1),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            flex: 1,
                            child: Container(
                                width: double.infinity,
                                child: Center(
                                    child: Text(
                                  'Items',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                )))),
                        Flexible(
                            flex: 1,
                            child: Container(
                                width: double.infinity,
                                child: Center(
                                    child: Text(
                                  "Qty",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                )))),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 10,
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(color: Colors.teal, width: 1.5),
                      ),
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: ((context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Row(
                                    children: [
                                      Checkbox(
                                          value: true,
                                          onChanged: (ValueKey) {}),
                                      Text('Items here'),
                                    ],
                                  ),
                                ),
                                Flexible(child: Center(child: Text('Qty'))),
                              ],
                            );
                          })),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                    margin: const EdgeInsets.all(4),
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Served",
                          style: TextStyle(color: Colors.teal),
                        )),
                  ),
                ]),
              );
            }),
      ),
    );
  }
}
//
