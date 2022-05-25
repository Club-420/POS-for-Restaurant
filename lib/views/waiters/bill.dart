import 'package:flutter/material.dart';
import 'package:pos/constants/test_data.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
// ignore: camel_case_types
class billwidget extends StatefulWidget {
  const billwidget({Key? key}) : super(key: key);

  @override
  State<billwidget> createState() => _billwidgetState();
}

// ignore: camel_case_types
class _billwidgetState extends State<billwidget> {


  
  int indexes = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.height/1.1,
        child: Row(
      children: [
        Flexible(
            flex: 1,
            child: Container(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: ((context, index) {
                    return Container(
                      color: index == indexes ? Colors.white : Colors.teal,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            indexes = index;
                          });
                        },
                        child: Text(
                          'Table ${index + 1}',
                          style: TextStyle(
                            color:
                                index == indexes ? Colors.black : Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  })),
            )),
            Flexible( flex:2,child: Container(  color: Colors.white,)),
        Flexible(
          flex: 4,
          child: Container(
            margin: EdgeInsets.all(10),
            color: Colors.grey,
            child: ListView.builder(
                itemCount: tableSchema.foods.length,
                itemBuilder: (context, index) {
                  return Container(
                    
                    
                    child: Text('${tableSchema.foods[indexes]}')
                  );
                }),
          ),
        ),
         Flexible( flex:2,child: Container(
             color: Colors.white,
         )),
      ],
    ));
  }
}
