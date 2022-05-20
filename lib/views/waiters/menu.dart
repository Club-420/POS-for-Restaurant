import 'package:flutter/material.dart';
import 'package:pos/constants/test_data.dart';

Widget menuWidget(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;
  return GridView.builder(
      itemCount: menu.menu.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
      ),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 1),
                blurRadius: 6,
              )
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
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
                ],
              ),
              const Image(
                alignment: Alignment.center,
                width: 100,
                height: 100,
                image: AssetImage(
                  'asset/images/loginView_logo.png',
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '   ${menu.menu[index]['name']}\t\t\n',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    'Rs ${menu.menu[index]['price']}        \n',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      fontSize: 10,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      });
}

class EditMenu extends StatefulWidget {
  const EditMenu({Key? key, required this.index}) : super(key: key);
  final index;
  @override
  State<EditMenu> createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  @override
  Widget build(BuildContext context) {
    final Map<String, Object> tempMenuItem = menu.menu[widget.index];
    return Scaffold(
      backgroundColor: Colors.transparent,
      // resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        // height: MediaQuery.of(context).size.height / 1.5,
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
            const Image(
              height: 200,
              image: AssetImage(
                'asset/images/loginView_logo.png',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width / 2,
                  child: TextField(
                    enableSuggestions: false,
                    autocorrect: false,
                    onSubmitted: (value) {
                      print(menu.toString());

                      setState(() {
                        tempMenuItem['name'] = value;
                      });
                    },
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
                  width: MediaQuery.of(context).size.width / 4,
                  child: TextField(
                    // controller: _name,
                    enableSuggestions: false,
                    autocorrect: false,
                    onSubmitted: (value) {
                      print(menu.toString());
                      if (double.tryParse(value) != null) {
                        setState(() {
                          tempMenuItem['price'] =
                              double.tryParse(value) as double;
                        });
                      }
                    },
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
              ],
            ),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () {
                  print('change photo');
                },
                child: const Text(
                  'Upload New Photo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    print('wrong tick');
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
                    print('right tick');
                    setState(() {
                      // menu.updateByMap(
                      //   index: widget.index,
                      //   map: tempMenuItem,
                      // );
                    });
                    Navigator.pop(context);
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
