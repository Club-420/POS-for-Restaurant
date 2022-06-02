import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pos/constants/test_data.dart';

class settingWidget extends StatefulWidget {
  final Function() buildParent;
  const settingWidget({Key? key, required this.buildParent}) : super(key: key);

  @override
  State<settingWidget> createState() =>
      _settingWidgetState(buildParent: buildParent);
}

class _settingWidgetState extends State<settingWidget> {
  _settingWidgetState({required this.buildParent});
  double boxSize = 30;
  final Function() buildParent;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(children: [
        Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: const Center(
            //     child: Text(
            //       "Theme Colors",
            //       style: TextStyle(fontSize: 20),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width:0.5,color: Colors.grey))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (() {
                          cols = Color.fromARGB(255, 0, 124, 106);
                          widget.buildParent();
                        }),
                        child: Container(
                          width: boxSize,
                          height: boxSize,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 124, 106),
                              
                              borderRadius:
                                  BorderRadius.all(Radius.circular(boxSize))),
                        ),
                      ),
                      InkWell(
                        onTap: (() {
                          cols = Colors.blueGrey;
                          widget.buildParent();
                        }),
                        child: Container(
                          width: boxSize,
                          height: boxSize,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              
                              borderRadius:
                                  BorderRadius.all(Radius.circular(boxSize))),
                        ),
                      ),
                      InkWell(
                        onTap: (() {
                          cols = Color.fromARGB(255, 14, 169, 156);
                          widget.buildParent();
                        }),
                        child: Container(
                          width: boxSize,
                          height: boxSize,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 14, 169, 156),
                              
                              borderRadius:
                                  BorderRadius.all(Radius.circular(boxSize))),
                        ),
                      ),
                      InkWell(
                        onTap: (() {
                          cols = Color.fromARGB(255, 2, 66, 135);
                          widget.buildParent();
                        }),
                        child: Container(
                          width: boxSize,
                          height: boxSize,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 2, 66, 135),
                              
                              borderRadius:
                                  BorderRadius.all(Radius.circular(boxSize))),
                        ),
                      ),
                      InkWell(
                        onTap: (() {
                          cols = Color.fromARGB(255, 128, 1, 68);
                          widget.buildParent();
                        }),
                        child: Container(
                          width: boxSize,
                          height: boxSize,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 128, 1, 68),
                              
                              borderRadius:
                                  BorderRadius.all(Radius.circular(boxSize))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
